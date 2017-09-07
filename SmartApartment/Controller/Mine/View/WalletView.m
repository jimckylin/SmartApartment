//
//  WalletView.m
//  SmartApartment
//
//  Created by Jimcky Lin on 2017/8/22.
//  Copyright © 2017年 Jimcky Lin. All rights reserved.
//

#import "WalletView.h"

@interface WalletView ()

@property (nonatomic, strong) UIImageView *bgImgView;

@property (nonatomic, strong) UILabel     *balance;           // 总余额
@property (nonatomic, strong) UILabel     *balanceLabel;

@property (nonatomic, strong) UILabel     *recharge;
@property (nonatomic, strong) UILabel     *rechargeLabel;     // 充值余额

@property (nonatomic, strong) UILabel     *give;              // 赠送余额
@property (nonatomic, strong) UILabel     *giveLabel;         //

@end


@implementation WalletView

- (instancetype)init {
    
    self = [super initWithFrame:CGRectMake(0, 64, kScreenWidth, 280)];
    if (self) {
        [self initView];
    }
    return self;
}


+ (BOOL)requiresConstraintBasedLayout {
    return YES;
}

- (void)initView {
    
    _bgImgView = [UIImageView new];
    _bgImgView.image = [UIImage imageNamed:@"mine_hand_bgiphone"];
    _bgImgView.contentMode = UIViewContentModeScaleAspectFill;
    _bgImgView.clipsToBounds = YES;
    [self addSubview:_bgImgView];
    
    _balance = [UILabel new];
    _balance.font = [UIFont systemFontOfSize:26];
    _balance.textColor = [UIColor whiteColor];
    _balance.textAlignment = NSTextAlignmentCenter;
    _balance.text = [UserManager manager].user.cardMoney;
    [self addSubview:_balance];
    
    _balanceLabel = [UILabel new];
    _balanceLabel.font = [UIFont systemFontOfSize:16];
    _balanceLabel.textColor = [UIColor whiteColor];
    _balanceLabel.textAlignment = NSTextAlignmentCenter;
    _balanceLabel.text = @"总余额(元)";
    [self addSubview:_balanceLabel];
    
    
    _recharge = [UILabel new];
    _recharge.font = [UIFont systemFontOfSize:14];
    _recharge.textColor = [UIColor whiteColor];
    _recharge.textAlignment = NSTextAlignmentCenter;
    _recharge.text = [UserManager manager].user.pechargeMoney;
    [self addSubview:_recharge];
    
    _rechargeLabel = [UILabel new];
    _rechargeLabel.font = [UIFont systemFontOfSize:14];
    _rechargeLabel.textColor = [UIColor whiteColor];
    _rechargeLabel.textAlignment = NSTextAlignmentCenter;
    _rechargeLabel.text = @"充值余额(元)";
    [self addSubview:_rechargeLabel];
    
    
    
    _give = [UILabel new];
    _give.font = [UIFont systemFontOfSize:14];
    _give.textColor = [UIColor whiteColor];
    _give.textAlignment = NSTextAlignmentCenter;
    _give.textAlignment = NSTextAlignmentCenter;
    _give.text = [UserManager manager].user.giveMoney;
    [self addSubview:_give];
    
    _giveLabel = [UILabel new];
    _giveLabel.font = [UIFont systemFontOfSize:14];
    _giveLabel.textColor = [UIColor whiteColor];
    _giveLabel.textAlignment = NSTextAlignmentCenter;
    _giveLabel.textAlignment = NSTextAlignmentCenter;
    _giveLabel.text = @"赠送余额";
    [self addSubview:_giveLabel];
    
}


#pragma mark - Layout

- (void)updateConstraints {
    
    CGFloat width = kScreenWidth/2;
    [_bgImgView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
    
    [_balance autoAlignAxisToSuperviewMarginAxis:ALAxisVertical];
    [_balance autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:CGRectGetHeight(self.frame)/2 - 70];
    [_balance autoSetDimensionsToSize:CGSizeMake(kScreenWidth, 60)];
    
    [_balanceLabel autoPinEdgeToSuperviewEdge:ALEdgeLeft];
    [_balanceLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_balance];
    [_balanceLabel autoSetDimensionsToSize:CGSizeMake(kScreenWidth, 14)];
    
    [_rechargeLabel autoPinEdgeToSuperviewEdge:ALEdgeLeft];
    [_rechargeLabel autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:10];
    [_rechargeLabel autoSetDimensionsToSize:CGSizeMake(width, 25)];
    
    [_recharge autoPinEdgeToSuperviewEdge:ALEdgeLeft];
    [_recharge autoPinEdge:ALEdgeBottom toEdge:ALEdgeTop ofView:_rechargeLabel];
    [_recharge autoSetDimensionsToSize:CGSizeMake(width, 20)];
    
    
    [_giveLabel autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:_rechargeLabel];
    [_giveLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:_rechargeLabel];
    [_giveLabel autoSetDimensionsToSize:CGSizeMake(width, 25)];
    
    [_give autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:_recharge];
    [_give autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:_recharge];
    [_give autoSetDimensionsToSize:CGSizeMake(width, 20)];
    
    [super updateConstraints];
}

@end
