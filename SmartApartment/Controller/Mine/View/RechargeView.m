//
//  RechargeView.m
//  SmartApartment
//
//  Created by Jimcky Lin on 2017/8/25.
//  Copyright © 2017年 Jimcky Lin. All rights reserved.
//

#import "RechargeView.h"
#import "WRCellView.h"
#import <RTLabel/RTLabel.h>
#import "RechargeButton.h"

#define WRCellViewHeight  44
#define CustomViewX       110
#define CustomViewWidth   150

@interface RechargeView ()

@property (nonatomic, strong) UIScrollView  *containerView;
@property (nonatomic, strong) UIView        *headerView;

@property (nonatomic, strong) WRCellView    *aliPayView;
@property (nonatomic, strong) WRCellView    *wechatPayView;
@property (nonatomic, strong) UIView        *footerView;

@property (nonatomic, strong) NSMutableArray *chargeBtns;

@end


@implementation RechargeView

- (instancetype)init {
    
    self = [super initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight-64)];
    if (self) {
        [self initData];
        [self initView];
        [self addViews];
        [self setCellFrame];
        [self onClickEvent];
    }
    return self;
}

- (void)initData {
    
    _chargeBtns = [[NSMutableArray alloc] initWithCapacity:1];
}

- (void)initView {
    
    self.containerView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-64)];
    [self addSubview:self.containerView];
}

- (void)addViews {
    
    [self.containerView addSubview:self.headerView];
    
    [self.containerView addSubview:self.aliPayView];
    [self.containerView addSubview:self.wechatPayView];
    [self.containerView addSubview:self.footerView];
}

- (void)setCellFrame {
    self.headerView.frame = CGRectMake(0, 0, kScreenWidth, 265);
    
    self.aliPayView.frame = CGRectMake(0, _headerView.bottom, kScreenWidth, WRCellViewHeight);
    self.wechatPayView.frame = CGRectMake(0, _aliPayView.bottom, kScreenWidth, WRCellViewHeight);
    self.footerView.frame = CGRectMake(0, _wechatPayView.bottom, kScreenWidth, 100);
    
    if (self.footerView.bottom< (kScreenHeight -64)) {
        self.containerView.contentSize = CGSizeMake(0, (kScreenHeight -64 + 20));
    }else {
        self.containerView.contentSize = CGSizeMake(0, self.footerView.bottom + 50);
    }
    self.footerView.height = self.containerView.contentSize.height - self.wechatPayView.bottom;
}

- (void)onClickEvent {
    
    //__weak typeof(self) weakSelf = self;
    self.aliPayView.tapBlock = ^ {
        
    };
    self.wechatPayView.tapBlock = ^ {
        
    };
}


#pragma mark - UIButton Click

- (void)chargeBtnClick:(RechargeButton *)sender {
    
    for (NSInteger index = 0; index < 4; index++) {
        
        RechargeButton *chargeBtn = _chargeBtns[index];
        chargeBtn.selected = sender.superview.tag == index? YES:NO;
    }
    
}

- (void)payBtnClick:(id)sender {
    
    
}



#pragma mark - getter

- (UIView *)headerView {
    
    if (!_headerView) {
        _headerView = [UIView new];
        _headerView.backgroundColor = [UIColor whiteColor];
        
        UILabel *chargeLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 10, 100, 20)];
        chargeLabel.font = [UIFont boldSystemFontOfSize:14];
        chargeLabel.textColor = [UIColor darkTextColor];
        chargeLabel.text = @"充值金额";
        [_headerView addSubview:chargeLabel];
        
        CGFloat padding = 10;
        CGFloat btnWidth = (kScreenWidth- padding*3)/2;
        CGFloat btnHeight = 74;
        for (NSInteger index = 0; index < 4; index++) {
            
            NSInteger shang = index/2;
            NSInteger yushu = index%2;
            
            CGFloat x = (yushu+1)*padding+yushu*btnWidth;
            CGFloat y = (shang+1)*padding + shang*btnHeight + chargeLabel.bottom+10;
            
            RechargeButton *chargeBtn = [[RechargeButton alloc] initWithFrame:CGRectMake(x, y, btnWidth, btnHeight)];
            [chargeBtn addAction:@selector(chargeBtnClick:) addTarget:self];
            chargeBtn.tag = index;
            chargeBtn.selected = index == 0?YES:NO;
            [_headerView addSubview:chargeBtn];
            [_chargeBtns addObject:chargeBtn];
        }
        
        RechargeButton *lastBtn = _chargeBtns.lastObject;
        UILabel *typeLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, lastBtn.bottom + 25, 100, 20)];
        typeLabel.font = [UIFont boldSystemFontOfSize:14];
        typeLabel.textColor = [UIColor darkTextColor];
        typeLabel.text = @"选择支付方式";
        [_headerView addSubview:typeLabel];
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
        [payBtn setTitle:@"充值" forState:UIControlStateNormal];
        [payBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [payBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
        [payBtn.titleLabel setFont:[UIFont systemFontOfSize:15]];
        payBtn.layer.cornerRadius = 44/2;
        payBtn.layer.masksToBounds = YES;
        [_footerView addSubview:payBtn];
    }
    return _footerView;
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




@end
