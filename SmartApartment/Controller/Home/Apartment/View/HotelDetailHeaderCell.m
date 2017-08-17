//
//  HotelDetailHeaderCell.m
//  SmartApartment
//
//  Created by Jimcky Lin on 2017/8/15.
//  Copyright © 2017年 Jimcky Lin. All rights reserved.
//

#import "HotelDetailHeaderCell.h"
#import "SDCycleScrollView.h"

@interface HotelDetailHeaderCell ()

@property (nonatomic, strong) UIImageView *thumbImgV;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *scoreLabel;
@property (nonatomic, strong) UIImageView *flagImgV;
@property (nonatomic, strong) UILabel *tagLabel;
@property (nonatomic, strong) UILabel *remainLabel;
@property (nonatomic, strong) UILabel *priceLabel;

@end


@implementation HotelDetailHeaderCell

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
    
    
    NSArray *imagesURLStrings = @[
                                  @"https://ss2.baidu.com/-vo3dSag_xI4khGko9WTAnF6hhy/super/whfpf%3D425%2C260%2C50/sign=a4b3d7085dee3d6d2293d48b252b5910/0e2442a7d933c89524cd5cd4d51373f0830200ea.jpg",
                                  @"https://ss0.baidu.com/-Po3dSag_xI4khGko9WTAnF6hhy/super/whfpf%3D425%2C260%2C50/sign=a41eb338dd33c895a62bcb3bb72e47c2/5fdf8db1cb134954a2192ccb524e9258d1094a1e.jpg",
                                  @"http://c.hiphotos.baidu.com/image/w%3D400/sign=c2318ff84334970a4773112fa5c8d1c0/b7fd5266d0160924c1fae5ccd60735fae7cd340d.jpg"
                                  ];
    SDCycleScrollView *bannerView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, kScreenWidth, 270) delegate:nil placeholderImage:[UIImage imageNamed:@"snapshot"]];
    bannerView.imageURLStringsGroup = imagesURLStrings;
    bannerView.autoScrollTimeInterval = 6;
    bannerView.autoScroll = NO;
    bannerView.pageControlBottomOffset = 30;
    [self.contentView addSubview:bannerView];
    
    UIView *bgView = [UIView new];
    bgView.backgroundColor = [UIColor whiteColor];
    bgView.layer.cornerRadius = 6;
    [self addSubview:bgView];
    [bgView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(260, 10, 0, 10)];
    
    
    // header
    _titleLabel = [UILabel new];
    _titleLabel.font = [UIFont systemFontOfSize:16];
    _titleLabel.textColor = [UIColor darkTextColor];
    _titleLabel.text = @"优客酒店北京朝阳区双桥东路店";
    [bgView addSubview:_titleLabel];
    
    _thumbImgV = [[UIImageView alloc] initWithImage:kImage(@"detail_brand_iciphone")];
    _thumbImgV.contentMode = UIViewContentModeScaleAspectFill;
    _thumbImgV.clipsToBounds = YES;
    [self addSubview:_thumbImgV];
    
    _scoreLabel = [UILabel new];
    _scoreLabel.font = [UIFont systemFontOfSize:10];
    _scoreLabel.textColor = [UIColor redColor];
    _scoreLabel.text = @"4.8分 超级棒";
    [bgView addSubview:_scoreLabel];
    
    _flagImgV = [UIImageView new];
    _flagImgV.contentMode = UIViewContentModeScaleAspectFill;
    _flagImgV.image = [UIImage imageNamed:@"xq_xinyongzhuiphone"];
    [bgView addSubview:_flagImgV];
    
    _tagLabel = [UILabel new];
    _tagLabel.font = [UIFont systemFontOfSize:11];
    _tagLabel.textColor = [UIColor redColor];
    _tagLabel.layer.cornerRadius = 2;
    _tagLabel.text = @"很安静";
    [bgView addSubview:_tagLabel];
    
    _remainLabel = [UILabel new];
    _remainLabel.font = [UIFont systemFontOfSize:12];
    _remainLabel.textColor = [UIColor redColor];
    _remainLabel.text = @"仅剩4间客房";
    [bgView addSubview:_remainLabel];
    
    _priceLabel = [UILabel new];
    _priceLabel.font = [UIFont systemFontOfSize:13];
    _priceLabel.textColor = [UIColor redColor];
    _priceLabel.textAlignment = NSTextAlignmentRight;
    _priceLabel.text = @"¥99起";
    [bgView addSubview:_priceLabel];
}


- (void)updateConstraints {
    
    [_titleLabel autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:15];
    [_titleLabel autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:10];
    CGSize size =[_titleLabel.text sizeWithAttributes:@{NSFontAttributeName:_titleLabel.font}];
    [_titleLabel autoSetDimension:ALDimensionWidth toSize:size.width];
    
    [_thumbImgV autoAlignAxis:ALAxisHorizontal toSameAxisOfView:_titleLabel];
    [_thumbImgV autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:_titleLabel withOffset:5];
    
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
