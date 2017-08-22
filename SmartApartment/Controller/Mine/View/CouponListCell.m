//
//  CouponListCell.m
//  SmartApartment
//
//  Created by Jimcky Lin on 2017/8/23.
//  Copyright © 2017年 Jimcky Lin. All rights reserved.
//

#import "CouponListCell.h"

@interface CouponListCell ()

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *countLabel;

@property (nonatomic, strong) UILabel *expDateLabel;
@property (nonatomic, strong) UILabel *priceLabel;

@end


@implementation CouponListCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        [self initSubView];
        _countLabel.layer.cornerRadius = 9;
    }
    return self;
}

+ (BOOL)requiresConstraintBasedLayout {
    return YES;
}

- (void)initSubView {
    
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(15, 10, kScreenWidth-30, 82)];
    bgView.backgroundColor = [UIColor clearColor];
    [self addSubview:bgView];
    
    UIImageView *bgImgV = [[UIImageView alloc] initWithFrame:bgView.bounds];
    bgImgV.image = kImage(@"coupon_bgiphone");
    bgImgV.contentMode = UIViewContentModeScaleAspectFill;
    [bgView addSubview:bgImgV];

    
    _titleLabel = [UILabel new];
    _titleLabel.font = [UIFont systemFontOfSize:15];
    _titleLabel.textColor = [UIColor darkTextColor];
    _titleLabel.text = @"通用10元优惠券";
    [bgView addSubview:_titleLabel];
    
    _countLabel = [UILabel new];
    _countLabel.font = [UIFont systemFontOfSize:10];
    _countLabel.textAlignment = NSTextAlignmentCenter;
    _countLabel.textColor = [UIColor lightGrayColor];
    _countLabel.layer.borderColor = [UIColor lightGrayColor].CGColor;
    _countLabel.layer.borderWidth = 0.5;
    _countLabel.text = @"代金券x1";
    [bgView addSubview:_countLabel];
    
    _expDateLabel = [UILabel new];
    _expDateLabel.font = [UIFont systemFontOfSize:11];
    _expDateLabel.textColor = [UIColor lightGrayColor];
    _expDateLabel.layer.cornerRadius = 2;
    _expDateLabel.text = @"有效期: 2018-12-12";
    [bgView addSubview:_expDateLabel];
    
    _priceLabel = [UILabel new];
    _priceLabel.font = [UIFont systemFontOfSize:18];
    _priceLabel.textColor = ThemeColor;
    _priceLabel.textAlignment = NSTextAlignmentRight;
    _priceLabel.text = @"¥10";
    [bgView addSubview:_priceLabel];
}


- (void)updateConstraints {
    
    [_titleLabel autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:15];
    [_titleLabel autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:16];
    [_titleLabel autoSetDimensionsToSize:CGSizeMake(130, 25)];
    
    [_countLabel autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:_titleLabel withOffset:5];
    [_countLabel autoAlignAxis:ALAxisHorizontal toSameAxisOfView:_titleLabel];
    [_countLabel autoSetDimensionsToSize:CGSizeMake(54, 18)];
    
    [_expDateLabel autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:_titleLabel];
    [_expDateLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_titleLabel withOffset:5];
    [_expDateLabel autoSetDimensionsToSize:CGSizeMake(130, 20)];
    
    [_priceLabel autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:12];
    [_priceLabel autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:10];
    [_priceLabel autoSetDimensionsToSize:CGSizeMake(80, 30)];
    
    [super updateConstraints];
}

@end
