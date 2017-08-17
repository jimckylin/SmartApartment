//
//  HotelDetailRoomListCell.m
//  SmartApartment
//
//  Created by Jimcky Lin on 2017/8/15.
//  Copyright © 2017年 Jimcky Lin. All rights reserved.
//

#import "HotelDetailRoomListCell.h"

@interface HotelDetailRoomListCell ()

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIImageView *sArrowIconV;
@property (nonatomic, strong) UILabel *priceLabel;
@property (nonatomic, strong) UIImageView *bArrowIconV;

@end

@implementation HotelDetailRoomListCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor clearColor];
        [self initSubView];
    }
    return self;
}

+ (BOOL)requiresConstraintBasedLayout {
    return YES;
}

- (void)initSubView {
    
    UIView *bgView = [UIView new];
    bgView.backgroundColor = [UIColor whiteColor];
    [self addSubview:bgView];
    [bgView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(0, 10, 0, 10)];
    
    _titleLabel = [UILabel new];
    _titleLabel.font = [UIFont systemFontOfSize:15];
    _titleLabel.textColor = [UIColor darkTextColor];
    _titleLabel.text = @"普通房";
    [bgView addSubview:_titleLabel];
    
    _priceLabel = [UILabel new];
    _priceLabel.font = [UIFont systemFontOfSize:13];
    _priceLabel.textColor = [UIColor redColor];
    _priceLabel.textAlignment = NSTextAlignmentRight;
    _priceLabel.text = @"¥168起";
    [bgView addSubview:_priceLabel];
    
    _sArrowIconV = [[UIImageView alloc] initWithImage:kImage(@"detail_more_iciphone")];
    _sArrowIconV.contentMode = UIViewContentModeScaleAspectFill;
    [bgView addSubview:_sArrowIconV];
    
    _bArrowIconV = [[UIImageView alloc] initWithImage:kImage(@"home_arrow_iconiphone")];
    _bArrowIconV.contentMode = UIViewContentModeScaleAspectFill;
    [bgView addSubview:_bArrowIconV];
}

- (void)setRoomPriceDic:(NSDictionary *)roomPriceDic {
    
    
}

- (void)updateConstraints {
    
    [_titleLabel autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:25];
    [_titleLabel autoAlignAxisToSuperviewMarginAxis:ALAxisHorizontal];
    [_titleLabel autoSetDimension:ALDimensionWidth toSize:55];
    
    [_priceLabel autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:37];
    [_priceLabel autoAlignAxisToSuperviewMarginAxis:ALAxisHorizontal];
    [_priceLabel autoSetDimension:ALDimensionWidth toSize:80];
    
    [_sArrowIconV autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:_titleLabel];
    [_sArrowIconV autoAlignAxisToSuperviewMarginAxis:ALAxisHorizontal];
    
    [_bArrowIconV autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:20];
    [_bArrowIconV autoAlignAxisToSuperviewMarginAxis:ALAxisHorizontal];
    
    [super updateConstraints];
}

@end
