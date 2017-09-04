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
@property (nonatomic, strong) NSMutableArray *comments;
@property (nonatomic, strong) HotelViewModel *viewModel;

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
    
}


#pragma mark - UITableView Delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _viewModel.storeEvaluateArr.count + 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0) {
        return 138;
    }
    return 130; // 根据评论及回复内容动态高度
}


#pragma mark - UITableView DataSource


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSInteger row = indexPath.row;
    
    if (row == 0) {
        HotelCommentHeaderCell *cell = [tableView dequeueReusableCellWithIdentifier:kHotelCommentHeaderCell];
        cell.delegate = self;
        [cell setCommentHeaderDic:nil];
        return cell;
        
    }
    HotelCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:kHotelCommentCell];
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}


#pragma mark - HotelCommentHeaderCellDelegate

- (void)hotelCommentHeaderCellDidClick:(CommentType)type {
    
    NSLog(@"type:%zd", type);
}


#pragma mark - init Data

- (void)initData {
    
    _viewModel = [HotelViewModel new];
    [self requestStoreEvaluateList];
    
    
    NSArray *comments = @[@{@"userid": @"1",
                            @"name": @"Jimcky",
                            @"avatar": @"https://www.baidu.com",
                            @"content": @"这是评论内容",
                            @"reply": @"这是回复内容"
                            },
                          @{@"userid": @"1",
                            @"name": @"Jimcky",
                            @"avatar": @"https://www.baidu.com",
                            @"content": @"这是评论内容",
                            @"reply": @"这是回复内容"
                            },
                          @{@"userid": @"1",
                            @"name": @"Jimcky",
                            @"avatar": @"https://www.baidu.com",
                            @"content": @"这是评论内容",
                            @"reply": @"这是回复内容"
                            },
                          @{@"userid": @"1",
                            @"name": @"Jimcky",
                            @"avatar": @"https://www.baidu.com",
                            @"content": @"这是评论内容",
                            @"reply": @"这是回复内容"
                            },
                          @{@"userid": @"1",
                            @"name": @"Jimcky",
                            @"avatar": @"https://www.baidu.com",
                            @"content": @"这是评论内容",
                            @"reply": @"这是回复内容"
                            },];
    _comments = [NSMutableArray new];
    [_comments addObjectsFromArray:comments];
}

- (void)requestStoreEvaluateList {
    
    [_viewModel requestStoreEvaluate:self.storeId complete:^(NSArray *evaluateArr) {
        
        [_tableView reloadData];
    }];
}


@end
