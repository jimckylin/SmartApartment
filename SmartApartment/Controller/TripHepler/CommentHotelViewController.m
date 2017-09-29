//
//  CommentHotelViewController.m
//  SmartApartment
//
//  Created by Jimcky Lin on 2017/8/31.
//  Copyright © 2017年 Jimcky Lin. All rights reserved.
//

#import "CommentHotelViewController.h"

#import "CommentHeaderCell.h"
#import "WRCellView.h"
#import "StarHotelCell.h"
#import "BlankCell.h"
#import "OrderViewModel.h"


@interface CommentHotelViewController ()<UITableViewDelegate,
UITableViewDataSource, StarHotelCellDelegtate, UIActionSheetDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) WRCellView *tripTypeView;
@property (nonatomic, strong) OrderViewModel  *orderViewModel;

@property (nonatomic, assign) CGFloat roomHealthScore;
@property (nonatomic, assign) CGFloat environmentScore;
@property (nonatomic, assign) CGFloat hotelScore;
@property (nonatomic, assign) CGFloat deviceScore;

@property (nonatomic, copy) NSString *commentContent;

@end


@implementation CommentHotelViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self iniData];
    [self initSubView];
}

- (void)iniData {
    _orderViewModel = [OrderViewModel new];
}

- (void)initSubView {
    
    _naviLabel.text = @"公寓点评";
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight-64)];
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_tableView registerClass:[StarHotelCell class] forCellReuseIdentifier:@"StarHotelCell"];
    [_tableView registerClass:[BlankCell class] forCellReuseIdentifier:@"BlankCell"];
    [_tableView registerClass:[CommentHeaderCell class] forCellReuseIdentifier:@"CommentHeaderCell"];
    [self.view addSubview:_tableView];
    
    // footer
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 100)];
    footerView.backgroundColor = [UIColor whiteColor];
    _tableView.tableFooterView = footerView;
    
    UIButton *commitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    commitBtn.backgroundColor = ThemeColor;
    [commitBtn addTarget:self action:@selector(commitCommentBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [commitBtn setTitle:@"提交" forState:UIControlStateNormal];
    [commitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [commitBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
    [commitBtn.titleLabel setFont:[UIFont systemFontOfSize:14]];
    commitBtn.layer.cornerRadius = 3;
    [footerView addSubview:commitBtn];
    [commitBtn autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(20, 12, 0, 12) excludingEdge:ALEdgeBottom];
    [commitBtn autoSetDimension:ALDimensionHeight toSize:40];
}


#pragma mark - UITableView Delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger section = indexPath.section;
    if (section == 0) {
        return 146;
    }else if (section == 1) {
        return 40;
    }else if (section == 2) {
        return 301;
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 0;
    }
    return 10;
}


#pragma mark - UITableView DataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSInteger section = indexPath.section;
    if (section == 0) {
        CommentHeaderCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CommentHeaderCell"];
        cell.tripOrder = self.tripOrder;
        return cell;
        
    }else if (section == 1) {
        BlankCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BlankCell"];
        
        _tripTypeView = [[WRCellView alloc] initWithLineStyle:WRCellStyleLabel_LabelIndicator];
        _tripTypeView.frame = CGRectMake(0, 0, kScreenWidth, cell.height);
        _tripTypeView.leftLabel.textColor = [UIColor darkTextColor];
        _tripTypeView.leftLabel.text = @"出游类型";
        _tripTypeView.rightLabel.text = @"出游类型";
        [cell addSubview:_tripTypeView];
        
        __weak typeof(self) weakSelf = self;
        _tripTypeView.tapBlock = ^ {
            __strong typeof(self) pThis = weakSelf;
            UIActionSheet *actionsheet = [[UIActionSheet alloc] initWithTitle:@"出游类型" delegate:pThis cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"商务出差",@"朋友出游",@"情侣出游", nil];
            // 显示
            [actionsheet showInView:pThis.view];
            
        };
        return cell;
        
    }else if (section == 2) {
        StarHotelCell *cell = [tableView dequeueReusableCellWithIdentifier:@"StarHotelCell"];
        cell.delegate = self;
        return cell;
    }
    
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 1) {
        NSMutableString* str = [[NSMutableString alloc] initWithFormat:@"telprompt://%@",@"400-4154-451"];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
    }
}


#pragma mark - UIActionSheetDelegate

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    if (buttonIndex != 3) {
        NSArray *array = @[@"商务出差",@"朋友出游",@"情侣出游"];
        _tripTypeView.rightLabel.text = array[buttonIndex];
    }
}


#pragma mark - StarHotelCellDelegtate

- (void)starHotelCellStarViewDidGiveScore:(CGFloat)score viewTag:(NSInteger)tag {
    
    if (tag == 1) {
        self.roomHealthScore = score;
    }else if (tag == 2) {
        self.environmentScore = score;
    }else if (tag == 3) {
        self.hotelScore = score;
    }else if (tag == 4) {
        self.deviceScore = score;
    }
}

- (void)starHotelCellStarViewDidComment:(NSString *)content {
    
    self.commentContent = content;
}


#pragma mark - UIButton Action

- (void)commitCommentBtnClick:(id)sender {
    
    __WeakObj(self)
    [_orderViewModel requestTripReview:self.tripOrder.orderNo
                       roomHealthScore:self.roomHealthScore
                      environmentScore:self.environmentScore
                            hotelScore:self.hotelScore
                           deviceScore:self.deviceScore
                      customerEvaluate:self.commentContent
                         customerImage:nil
                    imageExtensionName:nil
                              complete:^(BOOL isSuccess) {
                              
                                  [MBProgressHUD cwgj_showHUDWithText:@"评论成功"];
                                  dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                                      
                                      [[NSNotificationCenter defaultCenter] postNotificationName:@"kRefreshOrderList" object:nil];
                                      [[NavManager shareInstance] returnToFrontView:YES];
                                  });
                              }];
}




@end
