//
//  BookSuccessViewController.m
//  SmartApartment
//
//  Created by Jimcky Lin on 2017/8/19.
//  Copyright © 2017年 Jimcky Lin. All rights reserved.
//

#import "BookSuccessViewController.h"
#import "ConsumeListViewController.h"
#import "UseCouponListViewController.h"
#import "PaySuccessViewController.h"

#import "WRCellView.h"
#import "BookBottomView.h"
#import <RTLabel/RTLabel.h>
#import "HotelViewModel.h"
#import "WXPayRContent.h"
#import "PayManager.h"

#define WRCellViewHeight  44
#define CustomViewX       110
#define CustomViewWidth   150

@interface BookSuccessViewController ()<BookBottomViewDelegate, UIAlertViewDelegate>

@property (nonatomic, strong) UIScrollView  *containerView;
@property (nonatomic, strong) UIView        *headerView;
@property (nonatomic, strong) WRCellView    *orderDetailView;
@property (nonatomic, strong) WRCellView    *couponView;

@property (nonatomic, strong) WRCellView    *payTypeView;  // 支付方式
@property (nonatomic, strong) WRCellView    *aliPayView;
@property (nonatomic, strong) WRCellView    *wechatPayView;
//@property (nonatomic, strong) WRCellView    *walletView;
@property (nonatomic, strong) UIView        *footerView;

@property (nonatomic, strong) UILabel *couponLabel;

@property (nonatomic, strong) HotelViewModel *viewModel;

@property (nonatomic, copy) NSString *payType;
@property (nonatomic, strong) CouponList *couponList;

@end


@implementation BookSuccessViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
    [self addViews];
    [self setCellFrame];
    [self onClickEvent];
    [self iniData];
}

- (void)initView {
    
    _naviLabel.text = @"支付";
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
    //[self.containerView addSubview:self.walletView];
    [self.containerView addSubview:self.footerView];
    
    [self.couponView addSubview:self.couponLabel];
}

- (void)setCellFrame {
    self.headerView.frame = CGRectMake(0, 0, kScreenWidth, 175);
    self.orderDetailView.frame = CGRectMake(0, _headerView.bottom + 10, kScreenWidth, WRCellViewHeight);
    self.couponView.frame = CGRectMake(0, _orderDetailView.bottom + 10, kScreenWidth, WRCellViewHeight);
    self.payTypeView.frame = CGRectMake(0, _couponView.bottom + 10, kScreenWidth, WRCellViewHeight);
    
    self.aliPayView.frame = CGRectMake(0, _payTypeView.bottom, kScreenWidth, WRCellViewHeight);
    self.wechatPayView.frame = CGRectMake(0, _aliPayView.bottom, kScreenWidth, WRCellViewHeight);
    //self.walletView.frame = CGRectMake(0, _wechatPayView.bottom, kScreenWidth, WRCellViewHeight);
    self.footerView.frame = CGRectMake(0, _wechatPayView.bottom, kScreenWidth, 100);
    
    if (self.footerView.bottom< (kScreenHeight -64)) {
        self.containerView.contentSize = CGSizeMake(0, (kScreenHeight -64 + 20));
    }else {
        self.containerView.contentSize = CGSizeMake(0, self.footerView.bottom + 50);
    }
    self.footerView.height = self.containerView.contentSize.height - self.wechatPayView.bottom;
}

- (void)onClickEvent {
    
    __weak typeof(self) weakSelf = self;
    self.orderDetailView.tapBlock = ^ {
        ConsumeListViewController *vc = [ConsumeListViewController new];
        vc.consumeList = weakSelf.orderDict[@"consumeList"];
        [[NavManager shareInstance] showViewController:vc isAnimated:YES];
    };
    self.couponView.tapBlock = ^ {
        UseCouponListViewController *vc = [UseCouponListViewController new];
        vc.storeId = weakSelf.storeId;
        vc.roomTypeId = weakSelf.roomTypeId;
        
        vc.didSelectedCoupon = ^(CouponList *couponList){
            if (couponList) {
                weakSelf.couponList = couponList;
                weakSelf.couponLabel.textColor = ThemeColor;
                weakSelf.couponLabel.text = [NSString stringWithFormat:@"%@(%@)元", couponList.couponName, couponList.couponMoney];
            }else {
                weakSelf.couponLabel.textColor = [UIColor lightGrayColor];
                weakSelf.couponLabel.text = @"不使用";
            }
        };
        [[NavManager shareInstance] showViewController:vc isAnimated:YES];
    };
    
    
    // 支付选择
    self.aliPayView.tapBlock = ^ {
        weakSelf.payType = @"1";
        weakSelf.aliPayView.rightIndicator.image = kImage(@"reserve_pay_siphone");
        weakSelf.wechatPayView.rightIndicator.image = kImage(@"reserve_payiphone");
        //weakSelf.walletView.rightIndicator.image = kImage(@"reserve_payiphone");
    };
    self.wechatPayView.tapBlock = ^ {
        weakSelf.payType = @"0";
        weakSelf.aliPayView.rightIndicator.image = kImage(@"reserve_payiphone");
        weakSelf.wechatPayView.rightIndicator.image = kImage(@"reserve_pay_siphone");
        //weakSelf.walletView.rightIndicator.image = kImage(@"reserve_payiphone");
    };
//    self.walletView.tapBlock = ^ {
//        weakSelf.payType = @"3";
//        weakSelf.aliPayView.rightIndicator.image = kImage(@"reserve_payiphone");
//        weakSelf.wechatPayView.rightIndicator.image = kImage(@"reserve_payiphone");
//        weakSelf.walletView.rightIndicator.image = kImage(@"reserve_pay_siphone");
//    };
    
}

- (void)iniData {
    self.payType = @"1";
    _viewModel = [HotelViewModel new];
}


#pragma mark - UIButton Click

- (void)payBtnClick:(UIButton *)sender {
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:@"点击确认支付后，不能再次修改优惠券，是否继续支付" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定支付", nil];
    [alertView show];
}


#pragma mark - UIAlertView Delegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    if (buttonIndex == 1) {
        __WeakObj(self)
        [_viewModel requestConfirmPay:self.payType
                             couponId:self.couponList.couponId
                              orderNo:self.orderDict[@"orderNo"]
                             complete:^(NSDictionary *orderDict) {
                                 
                                 if ([selfWeak.payType isEqualToString:@"1"]) {
                                     [[PayManager getInstance] requestZFBV2:orderDict[@"orderStr"]];
                                     
                                 } else if ([selfWeak.payType isEqualToString:@"0"]) {
                                     
                                     WXPayRContent *content = [WXPayRContent modelObjectWithDictionary:orderDict[@"wxpayinfo"]];
                                     [[PayManager getInstance] requestWX:content];
                                 }
                                 [PayManager getInstance].didPayCompleteBlock = ^{
                                     // 跳转支付成功页面
                                     PaySuccessViewController *vc = [PaySuccessViewController new];
                                     vc.checkinNo = selfWeak.orderDict[@"checkInNo"];
                                     [[NavManager shareInstance] showViewController:vc isAnimated:YES];
                                     
                                     [[NSNotificationCenter defaultCenter] postNotificationName:@"kRefreshTripHelper" object:nil];
                                 };
                             }];
    }
}



#pragma mark - getter

- (UIView *)headerView {
    
    if (!_headerView) {
        _headerView = [UIView new];
        _headerView.backgroundColor = [UIColor whiteColor];
        
        UIImageView *icon = [[UIImageView alloc] initWithImage:kImage(@"reserve_illustrationiphone")];
        icon.center = CGPointMake(kScreenWidth/2, 55);
        [_headerView addSubview:icon];
        
        //UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, icon.bottom+16, kScreenWidth, 20)];
        //label.font = [UIFont systemFontOfSize:14];
        //label.textColor = [UIColor darkTextColor];
        //label.textAlignment = NSTextAlignmentCenter;
        //label.text = @"恭喜您预订成功!";
        //[_headerView addSubview:label];
        
        RTLabel *priceLabel = [[RTLabel alloc] initWithFrame:CGRectMake(0, icon.bottom + 30, kScreenWidth, 40)];
        priceLabel.font = [UIFont systemFontOfSize:13];
        priceLabel.textColor = [UIColor grayColor];
        priceLabel.textAlignment = RTTextAlignmentCenter;
        priceLabel.text = [NSString stringWithFormat:@"待付款 ￥<font size=20 color=#1B5B5E>%@</font>", self.orderDict[@"consumeTotalPrice"]];
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
        payBtn.backgroundColor = ThemeColor;
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
        _orderDetailView.leftLabel.text = @"付款清单";
    }
    return _orderDetailView;
}

- (WRCellView *)couponView {
    if (_couponView == nil) {
        _couponView = [[WRCellView alloc] initWithLineStyle:WRCellStyleLabel_LabelIndicator];
        _couponView.leftLabel.font = [UIFont systemFontOfSize:14];
        _couponView.leftLabel.text = @"优惠券";
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

//- (WRCellView *)walletView {
//    if (_walletView == nil) {
//        _walletView = [[WRCellView alloc] initWithLineStyle:WRCellStyleIconLabel_Indicator];
//        _walletView.leftIcon.image = kImage(@"reserve_pay_1_iciphone");
//        _walletView.rightIndicator.image = kImage(@"reserve_payiphone");
//        _walletView.leftLabel.text = @"钱包支付";
//        [_walletView setLineStyleWithLeftZero];
//    }
//    return _walletView;
//}


// Custom
- (UILabel *)couponLabel {
    if (_couponLabel == nil) {
        _couponLabel = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth-190, 0, 160, WRCellViewHeight)];
        _couponLabel.font = [UIFont systemFontOfSize:13];
        _couponLabel.textColor = [UIColor lightGrayColor];
        _couponLabel.textAlignment = NSTextAlignmentRight;
        _couponLabel.text = @"不使用";
    }
    return _couponLabel;
}


@end
