//
//  AddPassengerViewController.m
//  SmartApartment
//
//  Created by Jimcky Lin on 2017/8/20.
//  Copyright © 2017年 Jimcky Lin. All rights reserved.
//

#import "AddPassengerViewController.h"
#import "WRCellView.h"
#import "BookBottomView.h"

#define WRCellViewHeight  50
#define CustomViewX       110
#define CustomViewWidth   150

@interface AddPassengerViewController ()<BookBottomViewDelegate>

@property (nonatomic, strong) UIScrollView  *containerView;
@property (nonatomic, strong) WRCellView    *roomNumView;
@property (nonatomic, strong) WRCellView    *livePersonView;
@property (nonatomic, strong) WRCellView    *phoneNumView;
@property (nonatomic, strong) WRCellView    *arriveTimeView;
@property (nonatomic, strong) WRCellView    *invoiceView;  // 发票
@property (nonatomic, strong) WRCellView    *remarkView;
@property (nonatomic, strong) WRCellView    *tipView;

@property (nonatomic, strong) UITextField   *nameTF;
@property (nonatomic, strong) UITextField   *phoneNumTF;
@property (nonatomic, strong) UITextField   *emailTF;
@property (nonatomic, strong) UILabel       *arriveTimeLabel;
@property (nonatomic, strong) UITextField   *idCarnumTF;

@property (nonatomic, strong) UIView        *footerView;


@end


@implementation AddPassengerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
    [self addViews];
    [self setCellFrame];
}

- (void)initView {
    
    _naviLabel.text = @"新增常用旅客";
    self.containerView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, kScreenWidth, self.view.bounds.size.height-64 - 50)];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.view addSubview:self.containerView];
}

- (void)addViews {
    [self.containerView addSubview:self.roomNumView];
    [self.containerView addSubview:self.livePersonView];
    [self.containerView addSubview:self.phoneNumView];
    [self.containerView addSubview:self.arriveTimeView];
    [self.containerView addSubview:self.invoiceView];
    [self.containerView addSubview:self.remarkView];
    [self.containerView addSubview:self.tipView];
    [self.containerView addSubview:self.footerView];
    
    [self.roomNumView addSubview:self.nameTF];
    [self.livePersonView addSubview:self.phoneNumTF];
    [self.phoneNumView addSubview:self.emailTF];
    [self.arriveTimeView addSubview:self.arriveTimeLabel];
    
    [self.invoiceView addSubview:self.idCarnumTF];

    

}

- (void)setCellFrame {
    self.roomNumView.frame = CGRectMake(0, 30, kScreenWidth, WRCellViewHeight);
    self.livePersonView.frame = CGRectMake(0, _roomNumView.bottom, kScreenWidth, WRCellViewHeight);
    self.phoneNumView.frame = CGRectMake(0, _livePersonView.bottom, kScreenWidth, WRCellViewHeight);
    
    self.arriveTimeView.frame = CGRectMake(0, _phoneNumView.bottom , kScreenWidth, WRCellViewHeight);
    
    self.invoiceView.frame = CGRectMake(0, _arriveTimeView.bottom, kScreenWidth, WRCellViewHeight);
    self.remarkView.frame = CGRectMake(0, _invoiceView.bottom, kScreenWidth, WRCellViewHeight);
    self.tipView.frame = CGRectMake(0, _remarkView.bottom, kScreenWidth, WRCellViewHeight);
    self.footerView.frame = CGRectMake(0, _invoiceView.bottom, kScreenWidth, 100);
    
    if (self.tipView.bottom< (kScreenHeight -64-50)) {
        self.containerView.contentSize = CGSizeMake(0, (kScreenHeight -64-50 + 20));
    }else {
        self.containerView.contentSize = CGSizeMake(0, self.remarkView.top + WRCellViewHeight + 50);
    }
}

- (void)onClickEvent {
    
    __weak typeof(self) weakSelf = self;
    self.arriveTimeView.tapBlock = ^ {
        __strong typeof(self) pThis = weakSelf;
        
    };
}


#pragma mark - BookBottomViewDelegate

- (void)bookBottomViewDickBtn:(HotelBookBtnType)type {
    
    
}



#pragma mark - getter

- (WRCellView *)roomNumView {
    if (_roomNumView == nil) {
        _roomNumView = [[WRCellView alloc] initWithLineStyle:WRCellStyleLabel_];
        _roomNumView.leftLabel.text = @"姓名";
    }
    return _roomNumView;
}

- (WRCellView *)livePersonView {
    if (_livePersonView == nil) {
        _livePersonView = [[WRCellView alloc] initWithLineStyle:WRCellStyleLabel_];
        _livePersonView.leftLabel.text = @"手机号";
    }
    return _livePersonView;
}

- (WRCellView *)phoneNumView {
    if (_phoneNumView == nil) {
        _phoneNumView = [[WRCellView alloc] initWithLineStyle:WRCellStyleLabel_];
        _phoneNumView.leftLabel.text = @"邮箱";
        [_arriveTimeView setLineStyleWithLeftZero];
    }
    return _phoneNumView;
}

- (WRCellView *)arriveTimeView {
    if (_arriveTimeView == nil) {
        _arriveTimeView = [[WRCellView alloc] initWithLineStyle:WRCellStyleLabel_Indicator];
        _arriveTimeView.leftLabel.text = @"证件类型";
    }
    return _arriveTimeView;
}

- (WRCellView *)invoiceView {
    if (_invoiceView == nil) {
        _invoiceView = [[WRCellView alloc] initWithLineStyle:WRCellStyleLabel_];
        _invoiceView.leftLabel.text = @"证件号码";
    }
    return _invoiceView;
}

- (UIView *)footerView {
    if (!_footerView) {
        _footerView  = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 100)];
        
        UIButton *logoutBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [logoutBtn setFrame:CGRectMake(20, 20, kScreenWidth - 40, 44)];
        logoutBtn.backgroundColor = ThemeColor;
        //[logoutBtn addTarget:self action:@selector(logoutBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [logoutBtn setTitle:@"保存" forState:UIControlStateNormal];
        [logoutBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [logoutBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
        [logoutBtn.titleLabel setFont:[UIFont systemFontOfSize:14]];
        logoutBtn.layer.cornerRadius = 3;
        [_footerView addSubview:logoutBtn];
        
        
    }
    return _footerView;
}


// Custom
- (UITextField *)nameTF {
    if (_nameTF == nil) {
        _nameTF = [[UITextField alloc] initWithFrame:CGRectMake(CustomViewX, 0, 175, WRCellViewHeight)];
        _nameTF.font = [UIFont systemFontOfSize:14];
        _nameTF.textColor = [UIColor darkTextColor];
        _nameTF.placeholder = @"请填写姓名";
    }
    return _nameTF;
}

- (UITextField *)phoneNumTF {
    if (_phoneNumTF == nil) {
        _phoneNumTF = [[UITextField alloc] initWithFrame:CGRectMake(CustomViewX, 0, 175, WRCellViewHeight)];
        _phoneNumTF.font = [UIFont systemFontOfSize:14];
        _phoneNumTF.textColor = [UIColor darkTextColor];
        _phoneNumTF.placeholder = @"请填写手机号码";
    }
    return _phoneNumTF;
}

- (UITextField *)emailTF {
    if (_emailTF == nil) {
        _emailTF = [[UITextField alloc] initWithFrame:CGRectMake(CustomViewX, 0, 175, WRCellViewHeight)];
        _emailTF.font = [UIFont systemFontOfSize:14];
        _emailTF.textColor = [UIColor darkTextColor];
        _emailTF.placeholder = @"请填写邮箱";
    }
    return _emailTF;
}

- (UITextField *)idCarnumTF {
    if (_idCarnumTF == nil) {
        _idCarnumTF = [[UITextField alloc] initWithFrame:CGRectMake(CustomViewX, 0, 175, WRCellViewHeight)];
        _idCarnumTF.font = [UIFont systemFontOfSize:14];
        _idCarnumTF.textColor = [UIColor darkTextColor];
        _idCarnumTF.placeholder = @"请填写证件号码";
    }
    return _idCarnumTF;
}


- (UILabel *)arriveTimeLabel {
    if (_arriveTimeLabel == nil) {
        _arriveTimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(CustomViewX, 0, 175, WRCellViewHeight)];
        _arriveTimeLabel.text = @"居民身份证";
    }
    return _arriveTimeLabel;
}

@end
