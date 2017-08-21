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

@property (nonatomic, strong) UILabel *priceLabel;

@property (nonatomic, strong) UIButton *hotelDetailBtn;
@property (nonatomic, strong) UIButton *hotelTelBtn;

@property (nonatomic, strong) UIView *line;

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
    
    _priceLabel = [UILabel new];
    _priceLabel.font = [UIFont systemFontOfSize:16];
    _priceLabel.textColor = ThemeColor;
    _priceLabel.textAlignment = NSTextAlignmentRight;
    _priceLabel.text = @"¥99起";
    [bgView addSubview:_priceLabel];
    
    
    _hotelDetailBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _hotelDetailBtn.backgroundColor = [UIColor lightTextColor];
    [_hotelDetailBtn setImage:kImage(@"detail_listiphone") forState:UIControlStateNormal];
    [_hotelDetailBtn setTitleColor:[UIColor darkTextColor] forState:UIControlStateNormal];
    [_hotelDetailBtn.titleLabel setFont:[UIFont systemFontOfSize:13]];
    [_hotelDetailBtn setTitle:@"酒店详情" forState:UIControlStateNormal];
    _hotelDetailBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 10);
    _hotelDetailBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    _hotelDetailBtn.tag = HotelDetailHeaderTypeHotelDetail;
    [_hotelDetailBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_hotelDetailBtn];
    
    _hotelTelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _hotelTelBtn.backgroundColor = [UIColor lightTextColor];
    [_hotelTelBtn setImage:kImage(@"detail_phone_iciphone") forState:UIControlStateNormal];
    [_hotelTelBtn setTitle:@"咨询酒店" forState:UIControlStateNormal];
    [_hotelTelBtn setTitleColor:[UIColor darkTextColor] forState:UIControlStateNormal];
    [_hotelTelBtn.titleLabel setFont:[UIFont systemFontOfSize:13]];
    _hotelTelBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 10);
    _hotelTelBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    _hotelTelBtn.tag = HotelDetailHeaderTypeTelBtn;
    [_hotelTelBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_hotelTelBtn];
    
    _line = [UIView new];
    _line.backgroundColor = [UIColor lightGrayColor];
    [self addSubview:_line];
}


#pragma mark - UIButton Action

- (void)btnClick:(UIButton *)sender {
    
    HotelDetailHeaderType type = sender.tag;
    if (self.delegate && [self.delegate respondsToSelector:@selector(hotelDetailHeaderCellDidClickBtn:)]) {
        [self.delegate hotelDetailHeaderCellDidClickBtn:type];
    }
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
    [_flagImgV autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_scoreLabel withOffset:30];
    [_flagImgV autoSetDimensionsToSize:CGSizeMake(34, 12)];
    
    [_priceLabel autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:10];
    [_priceLabel autoPinEdge:ALEdgeBottom toEdge:ALEdgeBottom ofView:_flagImgV];
    [_priceLabel autoSetDimensionsToSize:CGSizeMake(80, 20)];
    
    [_hotelDetailBtn autoPinEdgeToSuperviewEdge:ALEdgeLeft];
    [_hotelDetailBtn autoPinEdgeToSuperviewEdge:ALEdgeBottom];
    [_hotelDetailBtn autoSetDimensionsToSize:CGSizeMake(kScreenWidth/2, 57)];
    
    [_hotelTelBtn autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:_hotelDetailBtn];
    [_hotelTelBtn autoPinEdgeToSuperviewEdge:ALEdgeBottom];
    [_hotelTelBtn autoSetDimensionsToSize:CGSizeMake(kScreenWidth/2, 57)];
    
    [_line autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:_hotelDetailBtn];
    [_line autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:_hotelDetailBtn withOffset:10];
    [_line autoSetDimensionsToSize:CGSizeMake(0.5, 37)];
    
    
    [super updateConstraints];
}


@end
