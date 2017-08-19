//
//  BookSuccessViewController.m
//  SmartApartment
//
//  Created by Jimcky Lin on 2017/8/19.
//  Copyright © 2017年 Jimcky Lin. All rights reserved.
//

#import "BookSuccessViewController.h"
#import "OrderDetailViewController.h"
#import "UseCouponListViewController.h"

#import "WRCellView.h"
#import "BookBottomView.h"
#import <RTLabel/RTLabel.h>

#define WRCellViewHeight  44
#define CustomViewX       110
#define CustomViewWidth   150

@interface BookSuccessViewController ()<BookBottomViewDelegate>

@property (nonatomic, strong) UIScrollView  *containerView;
@property (nonatomic, strong) UIView        *headerView;
@property (nonatomic, strong) WRCellView    *orderDetailView;
@property (nonatomic, strong) WRCellView    *couponView;

@property (nonatomic, strong) WRCellView    *payTypeView;  // 支付方式
@property (nonatomic, strong) WRCellView    *aliPayView;
@property (nonatomic, strong) WRCellView    *wechatPayView;
@property (nonatomic, strong) WRCellView    *walletView;
@property (nonatomic, strong) UIView        *footerView;

@property (nonatomic, strong) UILabel       *roomNumLabel;
@property (nonatomic, strong) UITextField   *livePersonTF;
@property (nonatomic, strong) UITextField   *phoneNumTF;
@property (nonatomic, strong) UILabel       *arriveTimeLabel;

@property (nonatomic, strong) UILabel       *invoiceLabel;
@property (nonatomic, strong) UITextField   *remarkTF;
@property (nonatomic, strong) UILabel       *tipLabel;

@end


@implementation BookSuccessViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
    [self addViews];
    [self setCellFrame];
    [self onClickEvent];
}

- (void)initView {
    
    _naviLabel.text = @"预订成功";
    self.containerView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, kScreenWidth, self.view.bounds.size.height-64)];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.view addSubview:self.containerView];
}

- (void)addViews {
    
    [self.containerView addSubview:self.headerView];
    
    [self.containerView addSubview:self.orderDetailView];
    [self.containerView addSubview:self.couponView];
    [self.containerView addSubview:self.payTypeView];
    [self.containerView addSubview:self.aliPayView];
    [self.containerView addSubview:self.wechatPayView];
    [self.containerView addSubview:self.walletView];
    [self.containerView addSubview:self.footerView];
}

- (void)setCellFrame {
    self.headerView.frame = CGRectMake(0, 0, kScreenWidth, 175);
    self.orderDetailView.frame = CGRectMake(0, _headerView.bottom + 10, kScreenWidth, WRCellViewHeight);
    self.couponView.frame = CGRectMake(0, _orderDetailView.bottom + 10, kScreenWidth, WRCellViewHeight);
    self.payTypeView.frame = CGRectMake(0, _couponView.bottom + 10, kScreenWidth, WRCellViewHeight);
    
    self.aliPayView.frame = CGRectMake(0, _payTypeView.bottom, kScreenWidth, WRCellViewHeight);
    self.wechatPayView.frame = CGRectMake(0, _aliPayView.bottom, kScreenWidth, WRCellViewHeight);
    self.walletView.frame = CGRectMake(0, _wechatPayView.bottom, kScreenWidth, WRCellViewHeight);
    self.footerView.frame = CGRectMake(0, _walletView.bottom, kScreenWidth, 100);
    
    if (self.footerView.bottom< (kScreenHeight -64)) {
        self.containerView.contentSize = CGSizeMake(0, (kScreenHeight -64 + 20));
    }else {
        self.containerView.contentSize = CGSizeMake(0, self.footerView.bottom + 50);
    }
    self.footerView.height = self.containerView.contentSize.height - self.walletView.bottom;
}

- (void)onClickEvent {
    
    //__weak typeof(self) weakSelf = self;
    self.orderDetailView.tapBlock = ^ {
        OrderDetailViewController *vc = [OrderDetailViewController new];
        [[NavManager shareInstance] showViewController:vc isAnimated:YES];
    };
    self.couponView.tapBlock = ^ {
        UseCouponListViewController *vc = [UseCouponListViewController new];
        [[NavManager shareInstance] showViewController:vc isAnimated:YES];
    };
}


#pragma mark - UIButton Click

- (void)payBtnClick:(UIButton *)sender {
    
    
}



#pragma mark - getter

- (UIView *)headerView {
    
    if (!_headerView) {
        _headerView = [UIView new];
        _headerView.backgroundColor = [UIColor whiteColor];
        
        UIImageView *icon = [[UIImageView alloc] initWithImage:kImage(@"reserve_illustrationiphone")];
        icon.center = CGPointMake(kScreenWidth/2, 55);
        [_headerView addSubview:icon];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, icon.bottom+16, kScreenWidth, 20)];
        label.font = [UIFont systemFontOfSize:14];
        label.textColor = [UIColor darkTextColor];
        label.textAlignment = NSTextAlignmentCenter;
        label.text = @"恭喜您预订成功!";
        [_headerView addSubview:label];
        
        RTLabel *priceLabel = [[RTLabel alloc] initWithFrame:CGRectMake(0, label.bottom + 10, kScreenWidth, 40)];
        priceLabel.font = [UIFont systemFontOfSize:13];
        priceLabel.textColor = [UIColor grayColor];
        priceLabel.textAlignment = RTTextAlignmentCenter;
        priceLabel.text = [NSString stringWithFormat:@"待付款 ￥<font size=20 color=red>394</font>"];
        [_headerView addSubview:priceLabel];
    }
    return _headerView;
}

- (UIView *)footerView {
    
    if (!_footerView) {
        _footerView = [UIView new];
        _footerView.backgroundColor = [UIColor whiteColor];
        
        UIButton *payBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        payBtn.frame = CGRectMake(21, 20, kScreenWidth-42, 44);
        payBtn.backgroundColor = [UIColor redColor];
        [payBtn addTarget:self action:@selector(payBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [payBtn setTitle:@"确认支付" forState:UIControlStateNormal];
        [payBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [payBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
        [payBtn.titleLabel setFont:[UIFont systemFontOfSize:15]];
        payBtn.layer.cornerRadius = 3;
        [_footerView addSubview:payBtn];
    }
    return _footerView;
}

- (WRCellView *)orderDetailView {
    if (_orderDetailView == nil) {
        _orderDetailView = [[WRCellView alloc] initWithLineStyle:WRCellStyleLabel_Indicator];
        _orderDetailView.leftLabel.font = [UIFont systemFontOfSize:14];
        _orderDetailView.leftLabel.text = @"订单详情";
    }
    return _orderDetailView;
}

- (WRCellView *)couponView {
    if (_couponView == nil) {
        _couponView = [[WRCellView alloc] initWithLineStyle:WRCellStyleLabel_LabelIndicator];
        _couponView.leftLabel.font = [UIFont systemFontOfSize:14];
        _couponView.leftLabel.text = @"优惠券";
        _couponView.rightLabel.text = @"不使用";
    }
    return _couponView;
}

- (WRCellView *)payTypeView {
    if (_payTypeView == nil) {
        _payTypeView = [[WRCellView alloc] initWithLineStyle:WRCellStyleLabel_];
        _payTypeView.leftLabel.font = [UIFont systemFontOfSize:14];
        _payTypeView.leftLabel.textColor = [UIColor grayColor];
        _payTypeView.leftLabel.text = @"支付方式";
        [_payTypeView setLineStyleWithLeftZero];
    }
    return _payTypeView;
}

- (WRCellView *)aliPayView {
    if (_aliPayView == nil) {
        _aliPayView = [[WRCellView alloc] initWithLineStyle:WRCellStyleIconLabel_Indicator];
        _aliPayView.leftIcon.image = kImage(@"reserve_pay_1_iciphone");
        _aliPayView.rightIndicator.image = kImage(@"reserve_pay_siphone");
        _aliPayView.leftLabel.text = @"支付宝支付";
    }
    return _aliPayView;
}

- (WRCellView *)wechatPayView {
    if (_wechatPayView == nil) {
        _wechatPayView = [[WRCellView alloc] initWithLineStyle:WRCellStyleIconLabel_Indicator];
        _wechatPayView.leftIcon.image = kImage(@"wechat_iciphone");
        _wechatPayView.rightIndicator.image = kImage(@"reserve_payiphone");
        _wechatPayView.leftLabel.text = @"微信支付";
    }
    return _wechatPayView;
}

- (WRCellView *)walletView {
    if (_walletView == nil) {
        _walletView = [[WRCellView alloc] initWithLineStyle:WRCellStyleIconLabel_Indicator];
        _walletView.leftIcon.image = kImage(@"reserve_pay_1_iciphone");
        _walletView.rightIndicator.image = kImage(@"reserve_payiphone");
        _walletView.leftLabel.text = @"钱包支付";
        [_walletView setLineStyleWithLeftZero];
    }
    return _walletView;
}


// Custom
- (UILabel *)roomNumLabel {
    if (_roomNumLabel == nil) {
        _roomNumLabel = [[UILabel alloc] initWithFrame:CGRectMake(CustomViewX, 0, 175, WRCellViewHeight)];
        _roomNumLabel.font = [UIFont systemFontOfSize:14];
        _roomNumLabel.textColor = [UIColor darkTextColor];
        _roomNumLabel.text = @"1间";
    }
    return _roomNumLabel;
}

- (UITextField *)livePersonTF {
    if (_livePersonTF == nil) {
        _livePersonTF = [[UITextField alloc] initWithFrame:CGRectMake(CustomViewX, 0, 175, WRCellViewHeight)];
        _livePersonTF.font = [UIFont systemFontOfSize:14];
        _livePersonTF.textColor = [UIColor darkTextColor];
        _livePersonTF.text = @"Jimcky Lin";
    }
    return _livePersonTF;
}

- (UITextField *)phoneNumTF {
    if (_phoneNumTF == nil) {
        _phoneNumTF = [[UITextField alloc] initWithFrame:CGRectMake(CustomViewX, 0, 175, WRCellViewHeight)];
        _phoneNumTF.font = [UIFont systemFontOfSize:14];
        _phoneNumTF.textColor = [UIColor darkTextColor];
        _phoneNumTF.text = @"15606025989";
    }
    return _phoneNumTF;
}

- (UILabel *)arriveTimeLabel {
    if (_arriveTimeLabel == nil) {
        _arriveTimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(CustomViewX, 0, 175, WRCellViewHeight)];
        _arriveTimeLabel.font = [UIFont systemFontOfSize:14];
        _arriveTimeLabel.textColor = [UIColor darkTextColor];
        _arriveTimeLabel.text = @"19:00前";
    }
    return _arriveTimeLabel;
}

- (UILabel *)invoiceLabel {
    if (_invoiceLabel == nil) {
        _invoiceLabel = [[UILabel alloc] initWithFrame:CGRectMake(CustomViewX, 0, 175, WRCellViewHeight)];
        _invoiceLabel.font = [UIFont systemFontOfSize:14];
        _invoiceLabel.textColor = [UIColor darkTextColor];
        _invoiceLabel.text = @"不需要";
    }
    return _invoiceLabel;
}

- (UITextField *)remarkTF {
    if (_remarkTF == nil) {
        _remarkTF = [[UITextField alloc] initWithFrame:CGRectMake(CustomViewX, 0, 175, WRCellViewHeight)];
        _remarkTF.font = [UIFont systemFontOfSize:14];
        _remarkTF.textColor = [UIColor darkTextColor];
        _remarkTF.placeholder = @"需要告知酒店的特殊要求";
    }
    return _remarkTF;
}

- (UILabel *)tipLabel {
    if (_tipLabel == nil) {
        _tipLabel = [[UILabel alloc] initWithFrame:CGRectMake(CustomViewX, 0, 175, WRCellViewHeight)];
        _tipLabel.text = @"请于入住日中午12:00后办理入住，如提前到店，视酒店空房情况安排";
        _tipLabel.font = [UIFont systemFontOfSize:11];
        _tipLabel.textColor = [UIColor lightGrayColor];
        _tipLabel.numberOfLines = 0;
        _tipLabel.frame = CGRectMake(40, 0, kScreenWidth-72, WRCellViewHeight);
    }
    return _tipLabel;
}

@end
