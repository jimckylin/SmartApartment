//
//  PersonInfoViewController.m
//  SmartApartment
//
//  Created by Jimcky Lin on 2017/8/20.
//  Copyright © 2017年 Jimcky Lin. All rights reserved.
//

#import "PersonInfoViewController.h"
#import "BookSuccessViewController.h"
#import "WRCellView.h"

#define WRCellViewHeight  50
#define CustomViewX       110
#define CustomViewWidth   150

@interface PersonInfoViewController ()<UIAlertViewDelegate>

@property (nonatomic, strong) UIScrollView  *containerView;
@property (nonatomic, strong) WRCellView    *roomNumView;
@property (nonatomic, strong) WRCellView    *livePersonView;
@property (nonatomic, strong) WRCellView    *phoneNumView;
@property (nonatomic, strong) WRCellView    *arriveTimeView;
@property (nonatomic, strong) WRCellView    *invoiceView;
@property (nonatomic, strong) WRCellView    *remarkView;

@end


@implementation PersonInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
    [self addViews];
    [self setCellFrame];
    [self onClickEvent];
}

- (void)initView {
    
    _naviLabel.text = @"个人资料";
    self.containerView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, kScreenWidth, self.view.bounds.size.height-64 - 60)];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.view addSubview:self.containerView];
    
    UIView *bottomViewBg = [UIView new];
    bottomViewBg.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:bottomViewBg];
    [bottomViewBg autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(0, 0, 0, 0) excludingEdge:ALEdgeTop];
    [bottomViewBg autoSetDimension:ALDimensionHeight toSize:60];
    
    UIButton *logoutBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    logoutBtn.backgroundColor = ThemeColor;
    [logoutBtn addTarget:self action:@selector(logoutBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [logoutBtn setTitle:@"退出" forState:UIControlStateNormal];
    [logoutBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [logoutBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
    [logoutBtn.titleLabel setFont:[UIFont systemFontOfSize:14]];
    logoutBtn.layer.cornerRadius = 3;
    [bottomViewBg addSubview:logoutBtn];
    
    [logoutBtn autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(8, 15, 10, 15)];
}

- (void)addViews {
    [self.containerView addSubview:self.roomNumView];
    [self.containerView addSubview:self.livePersonView];
    [self.containerView addSubview:self.phoneNumView];
    [self.containerView addSubview:self.arriveTimeView];
    [self.containerView addSubview:self.invoiceView];
    [self.containerView addSubview:self.remarkView];

}

- (void)setCellFrame {
    self.roomNumView.frame = CGRectMake(0, 30, kScreenWidth, 100);
    self.livePersonView.frame = CGRectMake(0, _roomNumView.bottom+10, kScreenWidth, WRCellViewHeight);
    self.phoneNumView.frame = CGRectMake(0, _livePersonView.bottom, kScreenWidth, WRCellViewHeight);
    
    self.arriveTimeView.frame = CGRectMake(0, _phoneNumView.bottom, kScreenWidth, WRCellViewHeight);
    
    self.invoiceView.frame = CGRectMake(0, _arriveTimeView.bottom, kScreenWidth, WRCellViewHeight);
    self.remarkView.frame = CGRectMake(0, _invoiceView.bottom, kScreenWidth, WRCellViewHeight);
    
    if (self.remarkView.bottom< (kScreenHeight -64-60)) {
        self.containerView.contentSize = CGSizeMake(0, (kScreenHeight -64-60 + 20));
    }else {
        self.containerView.contentSize = CGSizeMake(0, self.remarkView.top + WRCellViewHeight + 60);
    }
}

- (void)onClickEvent {
    
    __weak typeof(self) weakSelf = self;
    self.arriveTimeView.tapBlock = ^ {
        __strong typeof(self) pThis = weakSelf;
        
    };
}


#pragma mark - UIButton Action

- (void)logoutBtnClick:(id)sender {
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"确定退出" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alertView show];
}

#pragma mark - UIAlertViewDelegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    if (buttonIndex == 1) {
        [[UserManager manager] removeUser];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"kLogoutSuccess" object:nil];
        [[NavManager shareInstance] returnToLoginView:YES];
    }
}



#pragma mark - getter

- (WRCellView *)roomNumView {
    if (_roomNumView == nil) {
        _roomNumView = [[WRCellView alloc] initWithLineStyle:WRCellStyleLabel_IconIndicator];
        _roomNumView.leftLabel.text = @"头像";
        [_roomNumView.rightIcon sd_setImageWithURL:[NSURL URLWithString:[UserManager manager].user.headImage]
                                  placeholderImage:kImage(@"mine_headiphone")];
    }
    return _roomNumView;
}

- (WRCellView *)livePersonView {
    if (_livePersonView == nil) {
        _livePersonView = [[WRCellView alloc] initWithLineStyle:WRCellStyleLabel_LabelIndicator];
        _livePersonView.leftLabel.text = @"姓名";
        _livePersonView.rightLabel.text = [UserManager manager].user.name;
    }
    return _livePersonView;
}

- (WRCellView *)phoneNumView {
    if (_phoneNumView == nil) {
        _phoneNumView = [[WRCellView alloc] initWithLineStyle:WRCellStyleLabel_LabelIndicator];
        _phoneNumView.leftLabel.text = @"出生日期";
        [_phoneNumView setLineStyleWithLeftZero];
        _phoneNumView.rightLabel.text = [UserManager manager].user.birthdate;
    }
    return _phoneNumView;
}

- (WRCellView *)arriveTimeView {
    if (_arriveTimeView == nil) {
        _arriveTimeView = [[WRCellView alloc] initWithLineStyle:WRCellStyleLabel_LabelIndicator];
        _arriveTimeView.leftLabel.text = @"手机";
        _arriveTimeView.rightLabel.text = [UserManager manager].user.mobilePhone;
    }
    return _arriveTimeView;
}

- (WRCellView *)invoiceView {
    if (_invoiceView == nil) {
        _invoiceView = [[WRCellView alloc] initWithLineStyle:WRCellStyleLabel_LabelIndicator];
        _invoiceView.leftLabel.text = @"证件号码";
        _invoiceView.rightLabel.text = [UserManager manager].user.idNo;
    }
    return _invoiceView;
}

- (WRCellView *)remarkView {
    if (_remarkView == nil) {
        _remarkView = [[WRCellView alloc] initWithLineStyle:WRCellStyleLabel_LabelIndicator];
        _remarkView.leftLabel.text = @"邮箱";
        _remarkView.rightLabel.text = [UserManager manager].user.email;
        [_remarkView setLineStyleWithLeftZero];
    }
    return _remarkView;
}





@end
