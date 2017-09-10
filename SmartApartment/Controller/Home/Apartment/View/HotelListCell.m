//
//  HotelListCell.m
//  SmartApartment
//
//  Created by Jimcky Lin on 2017/8/14.
//  Copyright © 2017年 Jimcky Lin. All rights reserved.
//

#import "HotelListCell.h"
#import "Hotel.h"

@interface HotelListCell ()

@property (nonatomic, strong) UIImageView *thumbImgV;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *scoreLabel;
@property (nonatomic, strong) UIImageView *flagImgV;
@property (nonatomic, strong) UILabel *tagLabel;
@property (nonatomic, strong) UILabel *remainLabel;
@property (nonatomic, strong) UILabel *priceLabel;

@end


@implementation HotelListCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self initSubView];
    }
    return self;
}

+ (BOOL)requiresConstraintBasedLayout {
    return YES;
}

- (void)initSubView {
    
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 220/2)];
    bgView.backgroundColor = [UIColor whiteColor];
    [self addSubview:bgView];
    
    UIView *thumbBgView = [[UIView alloc] initWithFrame:CGRectZero];
    thumbBgView.backgroundColor = [UIColor lightGrayColor];
    [self addSubview:thumbBgView];
    
    [thumbBgView autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:5];
    [thumbBgView autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:8];
    [thumbBgView autoSetDimensionsToSize:CGSizeMake(110, 94)];
    
    _thumbImgV = [UIImageView new];
    _thumbImgV.contentMode = UIViewContentModeScaleAspectFill;
    _thumbImgV.image = [UIImage imageNamed:@"activity02"];
    _thumbImgV.clipsToBounds = YES;
    [thumbBgView addSubview:_thumbImgV];
    
    _titleLabel = [UILabel new];
    _titleLabel.font = [UIFont systemFontOfSize:16];
    _titleLabel.textColor = [UIColor darkTextColor];
    _titleLabel.text = @"优客酒店北京朝阳区双桥东路店";
    [self addSubview:_titleLabel];
    
    _scoreLabel = [UILabel new];
    _scoreLabel.font = [UIFont systemFontOfSize:10];
    _scoreLabel.textColor = [UIColor redColor];
    _scoreLabel.text = @"4.8分 超级棒";
    [self addSubview:_scoreLabel];
    
    _flagImgV = [UIImageView new];
    _flagImgV.contentMode = UIViewContentModeScaleAspectFill;
    _flagImgV.image = [UIImage imageNamed:@"xq_xinyongzhuiphone"];
    [self addSubview:_flagImgV];
    
    _tagLabel = [UILabel new];
    _tagLabel.font = [UIFont systemFontOfSize:11];
    _tagLabel.textColor = [UIColor redColor];
    _tagLabel.layer.cornerRadius = 2;
    _tagLabel.text = @"很安静";
    [self addSubview:_tagLabel];
    
    _remainLabel = [UILabel new];
    _remainLabel.font = [UIFont systemFontOfSize:12];
    _remainLabel.textColor = [UIColor redColor];
    _remainLabel.text = @"仅剩4间客房";
    [self addSubview:_remainLabel];
    
    _priceLabel = [UILabel new];
    _priceLabel.font = [UIFont systemFontOfSize:13];
    _priceLabel.textColor = [UIColor redColor];
    _priceLabel.textAlignment = NSTextAlignmentRight;
    _priceLabel.text = @"¥99起";
    [self addSubview:_priceLabel];
}

- (void)setHotel:(Hotel *)hotel {
    
    NSString *urlStr = @"";
    if ([hotel.storeImageList count] > 0) {
        urlStr = hotel.storeImageList[0][@"storeImage"];
    }
    [_thumbImgV sd_setImageWithURL:[NSURL URLWithString:urlStr] placeholderImage:kImage(@"home_list_blankiphone")];
    _titleLabel.text = hotel.storeName;
    _scoreLabel.text = hotel.storeScore;
    _priceLabel.text = [NSString stringWithFormat:@"¥%@起", hotel.storeRoomMinPrice];
}


- (void)updateConstraints {
    
    [_thumbImgV autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(3, 3, 3, 3)];
    
    [_titleLabel autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:_thumbImgV withOffset:7.5];
    [_titleLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:_thumbImgV];
    [_titleLabel autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:5];
    
    [_scoreLabel autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:_titleLabel];
    [_scoreLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_titleLabel];
    [_scoreLabel autoSetDimensionsToSize:CGSizeMake(100, 17)];
    
    [_flagImgV autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:_titleLabel];
    [_flagImgV autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_scoreLabel];
    [_flagImgV autoSetDimensionsToSize:CGSizeMake(34, 12)];
    
    [_tagLabel autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:_titleLabel];
    [_tagLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_flagImgV];
    [_tagLabel autoSetDimensionsToSize:CGSizeMake(50, 20)];
    
    [_remainLabel autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:_tagLabel];
    [_remainLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_flagImgV];
    [_remainLabel autoSetDimensionsToSize:CGSizeMake(120, 20)];
    
    [_priceLabel autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:10];
    [_priceLabel autoPinEdge:ALEdgeBottom toEdge:ALEdgeBottom ofView:_thumbImgV];
    [_priceLabel autoSetDimensionsToSize:CGSizeMake(80, 20)];
    
    [super updateConstraints];
}


@end
