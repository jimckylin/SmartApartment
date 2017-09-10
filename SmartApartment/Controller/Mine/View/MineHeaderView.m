//
//  MineHeaderView.m
//  SmartApartment
//
//  Created by jimcky on 2017/8/10.
//  Copyright © 2017年 Jimcky Lin. All rights reserved.
//

#import "MineHeaderView.h"

@interface MineHeaderView ()

@property (nonatomic, strong) UIImageView *headImgView;

@property (nonatomic, strong) UILabel     *nickNameLabel;
@property (nonatomic, strong) UIImageView *vipIconV;
@property (nonatomic, strong) UILabel     *levelLabel;

@property (nonatomic, strong) UILabel *balanceLabel;    // 余额
@property (nonatomic, strong) UILabel *couponLabel;     // 优惠券
@property (nonatomic, strong) UILabel *integralLabel;   // 积分

@property (nonatomic, strong) UILabel *balance;     // 余额
@property (nonatomic, strong) UILabel *coupon;      // 优惠券
@property (nonatomic, strong) UILabel *integral;    // 积分

// 按钮
@property (nonatomic, strong) UIButton *profileBtn;
@property (nonatomic, strong) UIButton *balanceBtn;
@property (nonatomic, strong) UIButton *couponBtn;
@property (nonatomic, strong) UIButton *integralBtn;

@end


@implementation MineHeaderView

- (instancetype)init {
    
    self = [super initWithFrame:CGRectMake(0, 0, kScreenWidth, 346/2)];
    if (self) {
        [self initView];
    }
    return self;
}

- (void)initView {
    
    _headImgView = [UIImageView new];
    _headImgView.image = [UIImage imageNamed:@"mine_headiphone"];
    _headImgView.contentMode = UIViewContentModeScaleAspectFill;
    _headImgView.layer.cornerRadius = 56/2;
    _headImgView.layer.masksToBounds = YES;
    _headImgView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    _headImgView.layer.borderWidth = 1;
    [self addSubview:_headImgView];
    
    _nickNameLabel = [UILabel new];
    _nickNameLabel.font = [UIFont systemFontOfSize:16];
    _nickNameLabel.textColor = [UIColor whiteColor];
    _nickNameLabel.text = @"15888888888";
    [self addSubview:_nickNameLabel];
    
    _vipIconV = [UIImageView new];
    _vipIconV.image = [UIImage imageNamed:@"mine_vip_1_iciphone"];
    _vipIconV.contentMode = UIViewContentModeScaleAspectFill;
    [self addSubview:_vipIconV];
    
    _levelLabel = [UILabel new];
    _levelLabel.font = [UIFont systemFontOfSize:12];
    _levelLabel.textColor = [UIColor lightTextColor];
    _levelLabel.text = @"网客";
    [self addSubview:_levelLabel];
    
    UIImageView *arrowIconV = [[UIImageView alloc] initWithImage:kImage(@"home_arrow_iconiphone")];
    arrowIconV.center = CGPointMake(kScreenWidth - 25, 78);
    [self addSubview:arrowIconV];
    
    
    // 下半部分
    UIFont *font = [UIFont fontWithName:@"DINCond-Medium.otf" size:10];
    
    _balanceLabel = [UILabel new];
    _balanceLabel.font = font;
    _balanceLabel.textColor = [UIColor whiteColor];
    _balanceLabel.textAlignment = NSTextAlignmentCenter;
    _balanceLabel.text = @"0";
    [self addSubview:_balanceLabel];
    
    _couponLabel = [UILabel new];
    _couponLabel.font = font;
    _couponLabel.textColor = [UIColor whiteColor];
    _couponLabel.textAlignment = NSTextAlignmentCenter;
    _couponLabel.text = @"0";
    [self addSubview:_couponLabel];
    
    _integralLabel = [UILabel new];
    _integralLabel.font = font;
    _integralLabel.textColor = [UIColor whiteColor];
    _integralLabel.textAlignment = NSTextAlignmentCenter;
    _integralLabel.text = @"0";
    [self addSubview:_integralLabel];
    
    _balance = [UILabel new];
    _balance.font = [UIFont systemFontOfSize:13];
    _balance.textColor = [UIColor whiteColor];
    _balance.textAlignment = NSTextAlignmentCenter;
    _balance.text = @"余额";
    [self addSubview:_balance];
    
    _coupon = [UILabel new];
    _coupon.font = [UIFont systemFontOfSize:13];
    _coupon.textColor = [UIColor whiteColor];
    _coupon.textAlignment = NSTextAlignmentCenter;
    _coupon.text = @"优惠券";
    [self addSubview:_coupon];
    
    _integral = [UILabel new];
    _integral.font = [UIFont systemFontOfSize:13];
    _integral.textColor = [UIColor whiteColor];
    _integral.textAlignment = NSTextAlignmentCenter;
    _integral.text = @"积分";
    [self addSubview:_integral];

    // 按钮
    _profileBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _profileBtn.backgroundColor = [UIColor clearColor];
    [_profileBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    _profileBtn.tag = HeaderEventTypeProfile;
    [self addSubview:_profileBtn];
    
    _balanceBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _balanceBtn.backgroundColor = [UIColor clearColor];
    [_balanceBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    _balanceBtn.tag = HeaderEventTypeBalance;
    [self addSubview:_balanceBtn];
    
    _couponBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _couponBtn.backgroundColor = [UIColor clearColor];
    [_couponBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    _couponBtn.tag = HeaderEventTypeCoupon;
    [self addSubview:_couponBtn];
    
    _integralBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _integralBtn.backgroundColor = [UIColor clearColor];
    [_integralBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    _integralBtn.tag = HeaderEventTypeIntegral;
    [self addSubview:_integralBtn];
}


#pragma mark - Pulic

- (void)setHeaderViewData {
    
    User *user = [UserManager manager].user;
    [_headImgView sd_setImageWithURL:[NSURL URLWithString:user.headImage] placeholderImage:kImage(@"mine_headiphone")];
    _nickNameLabel.text = user.name? user.name:@"未登录";
    _balanceLabel.text = user.cardMoney? user.cardMoney:@"-";
    _couponLabel.text = user.couponNum? user.couponNum:@"-";
    _integralLabel.text = user.cardIntegral? user.cardIntegral:@"-";
    
    if ([UserManager manager].isLogin) {
        _vipIconV.hidden = NO;
        _levelLabel.hidden = NO;
    }else {
        _vipIconV.hidden = YES;
        _levelLabel.hidden = YES;
    }
}


#pragma mark - UIButton Action

- (void)btnClick:(UIButton *)sender {
    
    HeaderEventType type = sender.tag;
    if ([self.delegate respondsToSelector:@selector(mineHeaderViewDidClickEvent:)]) {
        [self.delegate mineHeaderViewDidClickEvent:type];
    }
}



#pragma mark - Layout

- (void)updateConstraints {
    
    CGFloat paddingX = 18;
    
    [_headImgView autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:paddingX];
    [_headImgView autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:45];
    [_headImgView autoSetDimensionsToSize:CGSizeMake(56, 56)];
    
    [_nickNameLabel autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:_headImgView withOffset:paddingX];
    [_nickNameLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:_headImgView withOffset:10] ;
    [_nickNameLabel autoSetDimensionsToSize:CGSizeMake(kScreenWidth-100, 20)];
    
    [_vipIconV autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:_nickNameLabel];
    [_vipIconV autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_nickNameLabel withOffset:6];
    [_vipIconV autoSetDimensionsToSize:CGSizeMake(14, 14)];
    
    [_levelLabel autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:_vipIconV withOffset:4];
    [_levelLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_nickNameLabel withOffset:6];
    [_levelLabel autoSetDimensionsToSize:CGSizeMake(50, 14)];

    CGFloat width = kScreenWidth/3;
    [_balanceLabel autoPinEdgeToSuperviewEdge:ALEdgeLeft];
    [_balanceLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_headImgView withOffset:20];
    [_balanceLabel autoSetDimensionsToSize:CGSizeMake(width, 25)];
    
    [_couponLabel autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:_balanceLabel];
    [_couponLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:_balanceLabel];
    [_couponLabel autoSetDimensionsToSize:CGSizeMake(width, 25)];

    [_integralLabel autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:_couponLabel];
    [_integralLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:_balanceLabel];
    [_integralLabel autoSetDimensionsToSize:CGSizeMake(width, 25)];
    
    [_balance autoPinEdgeToSuperviewEdge:ALEdgeLeft];
    [_balance autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_balanceLabel];
    [_balance autoSetDimensionsToSize:CGSizeMake(width, 20)];
    
    [_coupon autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:_balanceLabel];
    [_coupon autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:_balance];
    [_coupon autoSetDimensionsToSize:CGSizeMake(width, 20)];
    
    [_integral autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:_couponLabel];
    [_integral autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:_balance];
    [_integral autoSetDimensionsToSize:CGSizeMake(width, 20)];
    
    // button
    [_profileBtn autoPinEdgeToSuperviewEdge:ALEdgeLeft];
    [_profileBtn autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:43];
    [_profileBtn autoSetDimensionsToSize:CGSizeMake(kScreenWidth, 75)];
    
    [_balanceBtn autoPinEdgeToSuperviewEdge:ALEdgeLeft];
    [_balanceBtn autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:_balanceLabel];
    [_balanceBtn autoSetDimensionsToSize:CGSizeMake(width, 45)];
    
    [_couponBtn autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:_balanceBtn];
    [_couponBtn autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:_balanceBtn];
    [_couponBtn autoSetDimensionsToSize:CGSizeMake(width, 45)];
    
    [_integralBtn autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:_couponBtn];
    [_integralBtn autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:_couponBtn];
    [_integralBtn autoSetDimensionsToSize:CGSizeMake(width, 45)];

//
//    [_liveLabel autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:_liveBtn];
//    [_liveLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_cityBtn];
//    [_liveLabel autoSetDimensionsToSize:CGSizeMake(30, 50)];
//    
//    [_leaveLabel autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:paddingX];
//    [_leaveLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_cityBtn];
//    [_leaveLabel autoSetDimensionsToSize:CGSizeMake(30, 50)];
//    
//    [_countLabel autoAlignAxisToSuperviewAxis:ALAxisVertical];
//    [_countLabel autoAlignAxis:ALAxisHorizontal toSameAxisOfView:_liveLabel];
//    [_countLabel autoSetDimensionsToSize:CGSizeMake(40, 15)];
//    
//    [_extraLabel autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:paddingX];
//    [_extraLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_liveLabel];
//    [_extraLabel autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:paddingX+30];
//    [_extraLabel autoSetDimension:ALDimensionHeight toSize:40];
//    
//    [_arrowIconV autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:paddingX];
//    [_arrowIconV autoAlignAxis:ALAxisHorizontal toSameAxisOfView:_extraLabel];
//    //[_countLabel autoSetDimensionsToSize:CGSizeMake(40, 15)];
//    
//    [_searchBtn autoAlignAxisToSuperviewAxis:ALAxisVertical];
//    [_searchBtn autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_extraLabel withOffset:20];
//    [_searchBtn autoSetDimensionsToSize:CGSizeMake(kScreenWidth-80, 40)];
    
    [super updateConstraints];
}

@end
