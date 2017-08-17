//
//  HotelDetailRoomPriceTypeCell.m
//  SmartApartment
//
//  Created by jimcky on 2017/8/17.
//  Copyright © 2017年 Jimcky Lin. All rights reserved.
//

#import "HotelDetailRoomPriceTypeCell.h"


@interface HotelDetailRoomPriceTypeCell ()

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIImageView *flagImgV;
@property (nonatomic, strong) UILabel *scoreLabel;

@property (nonatomic, strong) UILabel *tagLabel;
@property (nonatomic, strong) UILabel *remainLabel;
@property (nonatomic, strong) UILabel *priceLabel;

@end


@implementation HotelDetailRoomPriceTypeCell

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

- (void)setDic:(NSDictionary *)dic {
    
    _titleLabel.text = @"金卡价";
}

- (void)initSubView {
    
    
    UIView *bgView = [UIView new];
    bgView.backgroundColor = [UIColor lightGrayColor];
    [self addSubview:bgView];
    [bgView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(0, 10, 0, 10)];
    
    
    _titleLabel = [UILabel new];
    _titleLabel.font = [UIFont systemFontOfSize:12];
    _titleLabel.textColor = [UIColor darkTextColor];
    _titleLabel.text = @"金卡价";
    [bgView addSubview:_titleLabel];
    
    _flagImgV = [UIImageView new];
    _flagImgV.contentMode = UIViewContentModeScaleAspectFill;
    _flagImgV.image = [UIImage imageNamed:@"detail_vip_goldiphone"];
    [bgView addSubview:_flagImgV];

    
//    _scoreLabel = [UILabel new];
//    _scoreLabel.font = [UIFont systemFontOfSize:10];
//    _scoreLabel.textColor = [UIColor redColor];
//    _scoreLabel.text = @"4.8分 超级棒";
//    [bgView addSubview:_scoreLabel];
//    
//
//    _tagLabel = [UILabel new];
//    _tagLabel.font = [UIFont systemFontOfSize:11];
//    _tagLabel.textColor = [UIColor redColor];
//    _tagLabel.layer.cornerRadius = 2;
//    _tagLabel.text = @"很安静";
//    [bgView addSubview:_tagLabel];
//    
//    _remainLabel = [UILabel new];
//    _remainLabel.font = [UIFont systemFontOfSize:12];
//    _remainLabel.textColor = [UIColor redColor];
//    _remainLabel.text = @"仅剩4间客房";
//    [bgView addSubview:_remainLabel];
    
    _priceLabel = [UILabel new];
    _priceLabel.font = [UIFont systemFontOfSize:13];
    _priceLabel.textColor = [UIColor redColor];
    _priceLabel.textAlignment = NSTextAlignmentRight;
    _priceLabel.text = @"¥99起";
    [bgView addSubview:_priceLabel];
}


- (void)updateConstraints {
    
    [_titleLabel autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:15];
    [_titleLabel autoAlignAxisToSuperviewMarginAxis:ALAxisHorizontal];
    [_titleLabel autoSetDimension:ALDimensionWidth toSize:80];
    
    [_flagImgV autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:_titleLabel];
    [_flagImgV autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_titleLabel];
    [_flagImgV autoSetDimensionsToSize:CGSizeMake(23, 15)];
    
//    [_scoreLabel autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:_titleLabel];
//    [_scoreLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_titleLabel];
//    [_scoreLabel autoSetDimensionsToSize:CGSizeMake(100, 17)];
    
    
    
//    [_tagLabel autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:_titleLabel];
//    [_tagLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_flagImgV];
//    [_tagLabel autoSetDimensionsToSize:CGSizeMake(50, 20)];
//    
//    [_remainLabel autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:_tagLabel];
//    [_remainLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_flagImgV];
//    [_remainLabel autoSetDimensionsToSize:CGSizeMake(120, 20)];
    
    [_priceLabel autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:10];
    [_priceLabel autoAlignAxisToSuperviewMarginAxis:ALAxisHorizontal];
    [_priceLabel autoSetDimensionsToSize:CGSizeMake(80, 20)];
    
    [super updateConstraints];
}


@end
