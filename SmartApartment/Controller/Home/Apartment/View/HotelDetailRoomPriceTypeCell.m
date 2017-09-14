//
//  HotelDetailRoomPriceTypeCell.m
//  SmartApartment
//
//  Created by jimcky on 2017/8/17.
//  Copyright © 2017年 Jimcky Lin. All rights reserved.
//

#import "HotelDetailRoomPriceTypeCell.h"
#import <BAButton/BAButton.h>
#import "DayRoom.h"
#import "HourRoom.h"

@interface HotelDetailRoomPriceTypeCell ()

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIButton *questionBtn;
@property (nonatomic, strong) UIButton *bookBtn;
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
    bgView.backgroundColor = [UIColor colorWithHexString:@"#EAEEF1"];
    [self addSubview:bgView];
    [bgView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(0, 10, 0, 10)];
    
    
    _titleLabel = [UILabel new];
    _titleLabel.font = [UIFont systemFontOfSize:14];
    _titleLabel.textColor = [UIColor grayColor];
    _titleLabel.text = @"网客价";
    [bgView addSubview:_titleLabel];
    
    
    _questionBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_questionBtn setImage:kImage(@"xq_wenhaoiphone") forState:UIControlStateNormal];
    [_questionBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    _questionBtn.tag = HotelRoomListBtnTypeQustion;
    [bgView addSubview:_questionBtn];

    _bookBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _bookBtn.backgroundColor = [UIColor redColor];
    [_bookBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [_bookBtn setTitle:@"预订" forState:UIControlStateNormal];
    [_bookBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_bookBtn.titleLabel setFont:[UIFont systemFontOfSize:12]];
    _bookBtn.layer.cornerRadius = 4;
    _bookBtn.tag = HotelRoomListBtnTypeBook;
    [bgView addSubview:_bookBtn];
    
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

- (void)setDayRoom:(DayRoom *)dayRoom {
    
    _priceLabel.text = [NSString stringWithFormat:@"¥%@", dayRoom.customerTotalMoney];
}

- (void)setHourRoom:(HourRoom *)hourRoom {
    
    _priceLabel.text = [NSString stringWithFormat:@"¥%@", hourRoom.customerTotalMoney];
}


#pragma mark - UIButton Action 

- (void)btnClick:(UIButton *)sender {
    
    if ([self.delegate respondsToSelector:@selector(hotelDetailRoomPriceTypeCellDidClickBtn:cell:)]) {
        [self.delegate hotelDetailRoomPriceTypeCellDidClickBtn:sender.tag cell:self];
    }
}


- (void)updateConstraints {
    
    [_titleLabel autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:25];
    [_titleLabel autoAlignAxisToSuperviewMarginAxis:ALAxisHorizontal];
    [_titleLabel autoSetDimension:ALDimensionWidth toSize:50];
    
    [_questionBtn autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:_titleLabel];
    [_questionBtn autoAlignAxisToSuperviewMarginAxis:ALAxisHorizontal];
    [_questionBtn autoSetDimensionsToSize:CGSizeMake(30, 30)];
    
    [_bookBtn autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:16];
    [_bookBtn autoAlignAxisToSuperviewMarginAxis:ALAxisHorizontal];
    [_bookBtn autoSetDimensionsToSize:CGSizeMake(40, 29)];
    
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
    
    [_priceLabel autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:68];
    [_priceLabel autoAlignAxisToSuperviewMarginAxis:ALAxisHorizontal];
    [_priceLabel autoSetDimensionsToSize:CGSizeMake(80, 20)];
    
    [super updateConstraints];
}


@end
