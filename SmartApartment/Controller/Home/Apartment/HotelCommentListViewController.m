//
//  HotelCommentListViewController.m
//  SmartApartment
//
//  Created by Jimcky Lin on 2017/8/18.
//  Copyright © 2017年 Jimcky Lin. All rights reserved.
//

#import "HotelCommentListViewController.h"

#import "HotelCommentHeaderCell.h"
#import "HotelCommentCell.h"

#import "HotelViewModel.h"


NSString *const kHotelCommentHeaderCell = @"HotelCommentHeaderCell";
NSString *const kHotelCommentCell = @"HotelCommentCell";


@interface HotelCommentListViewController ()<UITableViewDelegate,
UITableViewDataSource, HotelCommentHeaderCellDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *commentArr;
@property (nonatomic, strong) HotelViewModel *viewModel;

@property (nonatomic, assign) NSInteger evaluateType;
@property (nonatomic, assign) NSInteger pageNum;

@end

@implementation HotelCommentListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initData];
    [self initUI];
}

- (void)initUI {
    
    _naviLabel.text = @"评论评价";
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 20)];
    [self.view addSubview:view];
    
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    bgView.backgroundColor = [UIColor colorWithHexString:@"#F2F2F2"];
    [self.view addSubview:bgView];
    
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectZero];
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.sectionHeaderHeight = 10;
    //_tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [bgView addSubview:_tableView];
    [_tableView registerClass:[HotelCommentHeaderCell class] forCellReuseIdentifier:kHotelCommentHeaderCell];
    [_tableView registerClass:[HotelCommentCell class] forCellReuseIdentifier:kHotelCommentCell];

    
    [_tableView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(64, 0, 0, 0)];
    _tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0.01)];
    _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 10)];
    [self.view bringSubviewToFront:_naviView];
    
    
    __weak typeof(self) weakSelf = self;
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        weakSelf.pageNum = 1;
        [weakSelf requestStoreEvaluateListEvaluateType:weakSelf.evaluateType pageNum:1 pageSize:20];
    }];
    
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        weakSelf.pageNum ++;
        [weakSelf requestStoreEvaluateListEvaluateType:weakSelf.evaluateType pageNum:weakSelf.pageNum pageSize:20];
    }];
}


#pragma mark - UITableView Delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _commentArr.count + 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0) {
        return 138;
    }
    StoreEvaluate *evaluate = _commentArr[indexPath.row -1];
    return [HotelCommentCell getCellHeightWith:evaluate]; // 根据评论及回复内容动态高度
}


#pragma mark - UITableView DataSource


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSInteger row = indexPath.row;
    
    if (row == 0) {
        HotelCommentHeaderCell *cell = [tableView dequeueReusableCellWithIdentifier:kHotelCommentHeaderCell];
        cell.delegate = self;
        cell.storeEvaluateList = _viewModel.storeEvaluateList;
        
        return cell;
    }
    HotelCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:kHotelCommentCell];
    StoreEvaluate *evaluate = _commentArr[indexPath.row -1];
    cell.evaluate = evaluate;
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}


#pragma mark - HotelCommentHeaderCellDelegate

- (void)hotelCommentHeaderCellDidClick:(CommentType)type {
    
    // 0-全部 1- 差评 2-中评 3-好评
    _evaluateType = 0;
    if (type == CommentTypeAll) {
        _evaluateType = 0;
    }else if (type == CommentTypeGood) {
        _evaluateType = 3;
    }else if (type == CommentTypeNotbad) {
        _evaluateType = 2;
    }else if (type == CommentTypeBad) {
        _evaluateType = 1;
    }
    [self requestStoreEvaluateListEvaluateType:_evaluateType pageNum:1 pageSize:20];
    
}


#pragma mark - init Data

- (void)initData {
    
    _pageNum = 1;
    _commentArr = [[NSMutableArray alloc] initWithCapacity:1];
    _viewModel = [HotelViewModel new];
    [self requestStoreEvaluateListEvaluateType:0 pageNum:1 pageSize:20];
}

- (void)requestStoreEvaluateListEvaluateType:(NSInteger)evaluateType
                         pageNum:(NSInteger)pageNum
                        pageSize:(NSInteger)pageSize {
    
    __WeakObj(self)
    [_viewModel requestStoreEvaluate:self.storeId evaluateType:evaluateType pageNum:pageNum pageSize:pageSize complete:^(StoreEvaluateList *storeEvaluateList) {
        if (pageNum == 1) {
            [selfWeak.commentArr removeAllObjects];
        }
        [selfWeak.commentArr addObjectsFromArray:storeEvaluateList.customerList];
        [selfWeak.tableView reloadData];
        [selfWeak.tableView.mj_header endRefreshing];
        [selfWeak.tableView.mj_footer endRefreshing];
    }];
}


@end
