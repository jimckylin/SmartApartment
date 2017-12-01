//
//  HotelDetailPreviewView.m
//  SmartApartment
//
//  Created by jimcky on 2017/11/30.
//  Copyright © 2017年 Jimcky Lin. All rights reserved.
//

#import "HotelDetailPreviewView.h"
#import "SDCycleScrollView.h"
#import "DayRoom.h"
#import "HourRoom.h"
//#import "RTLabel.h"

@interface HotelDetailPreviewView ()
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) SDCycleScrollView *bannerView;
@property (nonatomic, strong) UILabel *descLabel;
@property (nonatomic, strong) UILabel *priceLabel;
@end


@implementation HotelDetailPreviewView

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    if (self) {
        self.backgroundColor = RGBA(0, 0, 0, 0.4);
        [self initSubView];
    }
    return self;
}

- (void)initSubView {
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = self.bounds;
    [btn addTarget:self action:@selector(hide) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:btn];
    
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(25, 0, kScreenWidth-50, 350)];
    bgView.backgroundColor = RGBA(255, 255, 255, 1);
    bgView.center = self.center;
    bgView.layer.cornerRadius = 5;
    bgView.layer.masksToBounds = YES;
    [self addSubview:bgView];
    
    
    _titleLabel = [UILabel new];
    _titleLabel.font = [UIFont systemFontOfSize:14];
    _titleLabel.textColor = [UIColor darkTextColor];
    _titleLabel.text = @"您可选择的套餐";
    [bgView addSubview:_titleLabel];
    [_titleLabel autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(0, 10, 0, 0) excludingEdge:ALEdgeBottom];
    [_titleLabel autoSetDimension:ALDimensionHeight toSize:44];
    
    _bannerView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(10, 44, bgView.width-20, 180) delegate:nil placeholderImage:[UIImage imageNamed:@"blank_default_nomal_bg"]];
    _bannerView.autoScrollTimeInterval = 5;
    _bannerView.bannerImageViewContentMode = UIViewContentModeScaleAspectFill;
    [bgView addSubview:_bannerView];
    
    _descLabel = [UILabel new];
    _descLabel.font = [UIFont systemFontOfSize:13];
    _descLabel.textColor = [UIColor lightGrayColor];
    _descLabel.numberOfLines = 4;
    [bgView addSubview:_descLabel];
    
    [_descLabel autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:_bannerView];
    [_descLabel autoPinEdge:ALEdgeRight toEdge:ALEdgeRight ofView:_bannerView];
    [_descLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_bannerView withOffset:10];
    
    
    
//    UIButton *confirmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    [confirmBtn setTitle:@"确定" forState:UIControlStateNormal];
//    [confirmBtn setTitleColor:ThemeColor forState:UIControlStateNormal];
//    [confirmBtn.titleLabel setFont:[UIFont systemFontOfSize:13]];
//    [confirmBtn addTarget:self action:@selector(confirmBtnClick:) forControlEvents:UIControlEventTouchUpInside];
//    [bgView addSubview:confirmBtn];
    
    UIView *bottomView = [UIView new];
    [bgView addSubview:bottomView];
    [bottomView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(0, 0, 0, 0) excludingEdge:ALEdgeTop];
    [bottomView autoSetDimension:ALDimensionHeight toSize:40];
    
    UIView *line = [UIView new];
    line.backgroundColor = [UIColor lightGrayColor];
    [bottomView addSubview:line];
    [line autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(0, 0, 0, 0) excludingEdge:ALEdgeBottom];
    [line autoSetDimension:ALDimensionHeight toSize:0.5];
    
    _priceLabel = [UILabel new];
    _priceLabel.font = [UIFont systemFontOfSize:14];
    _priceLabel.textColor = RGBA(230, 30, 48, 1);
    _priceLabel.text = @"在线支付: ¥0";
    _priceLabel.textAlignment = NSTextAlignmentCenter;
    [bottomView addSubview:_priceLabel];
    
    [_priceLabel autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(0, 0, 0, 0) excludingEdge:ALEdgeRight];
    [_priceLabel autoSetDimension:ALDimensionWidth toSize:bgView.width*3/5];
    
    UIButton *bookBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    bookBtn.backgroundColor = RGBA(230, 30, 48, 1);
    [bookBtn setTitle:@"立即预订" forState:UIControlStateNormal];
    [bookBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [bookBtn.titleLabel setFont:[UIFont systemFontOfSize:13]];
    [bookBtn addTarget:self action:@selector(bookBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:bookBtn];
    
    [bookBtn autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(0, 0, 0, 0) excludingEdge:ALEdgeLeft];
    [bookBtn autoSetDimension:ALDimensionWidth toSize:bgView.width*2/5];
}


- (void)setDayRoom:(DayRoom *)dayRoom {
    
    NSMutableArray *images = [NSMutableArray array];
    if ([dayRoom.roomTypeImageList count]) {
        for (NSDictionary *dict in dayRoom.roomTypeImageList) {
            [images addObject:dict[@"roomTypeImage"]];
        }
    }
    _titleLabel.text = dayRoom.roomTypeName;
    _bannerView.imageURLStringsGroup = images;
    _descLabel.text = dayRoom.roomTypeRemark;
    _priceLabel.text = [NSString stringWithFormat:@"在线支付: ¥%@", dayRoom.roomPrice];
    _dayRoom = dayRoom;
}

- (void)setHourRoom:(HourRoom *)hourRoom {
    
    NSMutableArray *images = [NSMutableArray array];
    if ([hourRoom.roomTypeImageList count]) {
        for (NSDictionary *dict in hourRoom.roomTypeImageList) {
            [images addObject:dict[@"roomTypeImage"]];
        }
    }
    _titleLabel.text = hourRoom.roomTypeName;
    _bannerView.imageURLStringsGroup = images;
    _descLabel.text = hourRoom.roomTypeRemark;
    _priceLabel.text = [NSString stringWithFormat:@"在线支付: ¥%@", hourRoom.roomPrice];
    _hourRoom = hourRoom;
}


#pragma mark - Public

- (void)show {
    
    self.hidden = NO;
}

- (void)hide {
    
    self.hidden = YES;
}



#pragma mark - Private

- (void)bookBtnClick:(id)sender {
   
    if (self.bookBtnBlock) {
        self.bookBtnBlock(self.dayRoom, self.hourRoom);
    }
}


@end
