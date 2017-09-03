//
//  HotelDetailRoomListCell.m
//  SmartApartment
//
//  Created by Jimcky Lin on 2017/8/15.
//  Copyright © 2017年 Jimcky Lin. All rights reserved.
//

#import "HotelDetailRoomListCell.h"
#import "RTLabel.h"
#import "DayRoom.h"
#import "HourRoom.h"

@interface HotelDetailRoomListCell ()

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *remainLabel;
@property (nonatomic, strong) UIImageView *sArrowIconV;
@property (nonatomic, strong) RTLabel *priceLabel;
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
    
    _remainLabel = [UILabel new];
    _remainLabel.font = [UIFont systemFontOfSize:10];
    _remainLabel.textColor = ThemeColor;
    _remainLabel.text = @"仅剩0间客房";
    [bgView addSubview:_remainLabel];
    
    _priceLabel = [RTLabel new];
    _priceLabel.font = [UIFont systemFontOfSize:16];
    _priceLabel.textColor = [UIColor redColor];
    _priceLabel.textAlignment = RTTextAlignmentRight;
    _priceLabel.text = @"¥168起";
    [bgView addSubview:_priceLabel];
    
    _sArrowIconV = [[UIImageView alloc] initWithImage:kImage(@"detail_more_iciphone")];
    _sArrowIconV.contentMode = UIViewContentModeScaleAspectFill;
    [bgView addSubview:_sArrowIconV];
    
    _bArrowIconV = [[UIImageView alloc] initWithImage:kImage(@"home_arrow_iconiphone")];
    _bArrowIconV.contentMode = UIViewContentModeScaleAspectFill;
    [bgView addSubview:_bArrowIconV];
}

- (void)setDayRoom:(DayRoom *)dayRoom {
    
    _titleLabel.text = dayRoom.roomTypeName;
    _remainLabel.text = [NSString stringWithFormat:@"仅剩%@间客房", dayRoom.roomNum];
    _priceLabel.text = [NSString stringWithFormat:@"¥%@<font size=12 color=lightGray>(门市价)</font>", dayRoom.shopPrice];
}

- (void)setHourRoom:(HourRoom *)hourRoom {
    
    _titleLabel.text = hourRoom.roomTypeName;
    _priceLabel.text = [NSString stringWithFormat:@"¥%@", hourRoom.shopPrice];
}


- (void)updateConstraints {
    
    [_titleLabel autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:25];
    [_titleLabel autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:20];
    [_titleLabel autoSetDimension:ALDimensionWidth toSize:55];
    
    [_remainLabel autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:25];
    [_remainLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_titleLabel withOffset:3];
    [_remainLabel autoSetDimension:ALDimensionWidth toSize:90];
    
    
    [_priceLabel autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:37];
    [_priceLabel autoAlignAxisToSuperviewMarginAxis:ALAxisHorizontal];
    [_priceLabel autoSetDimensionsToSize:CGSizeMake(110, 20)];
    
    [_sArrowIconV autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:_titleLabel];
    [_sArrowIconV autoAlignAxis:ALAxisHorizontal toSameAxisOfView:_titleLabel];
    
    [_bArrowIconV autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:20];
    [_bArrowIconV autoAlignAxisToSuperviewMarginAxis:ALAxisHorizontal];
    
    [super updateConstraints];
}

@end
