//
//  BookDetailView.m
//  SmartApartment
//
//  Created by Jimcky Lin on 2017/8/27.
//  Copyright © 2017年 Jimcky Lin. All rights reserved.
//

#import "BookDetailView.h"

@interface BookDetailView ()

@property (nonatomic, strong) UIView *bgView;

@property (nonatomic, strong) UILabel *dateLabel;
@property (nonatomic, strong) UILabel *priceLabel;

@end

@implementation BookDetailView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initView];
    }
    return self;
}

+ (BOOL)requiresConstraintBasedLayout {
    return YES;
}

- (void)initView {
    self.backgroundColor = RGBA(0, 0, 0, 0.5);
    UIButton *bgBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    bgBtn.frame = self.bounds;
    [bgBtn addTarget:self action:@selector(bgBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:bgBtn];
    
    
    _bgView = [UIView new];
    _bgView.backgroundColor = [UIColor whiteColor];
    [self addSubview:_bgView];
    
    [_bgView autoPinEdgeToSuperviewEdge:ALEdgeLeft];
    [_bgView autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:kScreenHeight-50-75];
    [_bgView autoSetDimensionsToSize:CGSizeMake(kScreenWidth, 75)];
    
    
    UILabel *detailLabel = [UILabel new];
    detailLabel.font = [UIFont systemFontOfSize:12];
    detailLabel.textColor = [UIColor grayColor];
    detailLabel.text = @"明细";
    [_bgView addSubview:detailLabel];
    
    [detailLabel autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:12];
    [detailLabel autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:15];
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 35, kScreenWidth, 0.5)];
    line.backgroundColor = [UIColor lightGrayColor];
    [_bgView addSubview:line];
    
    _dateLabel= [UILabel new];
    _dateLabel.font = [UIFont systemFontOfSize:12];
    _dateLabel.textColor = [UIColor grayColor];
    _dateLabel.text = @"2017.08.19";
    [_bgView addSubview:_dateLabel];
    
    _priceLabel = [UILabel new];
    _priceLabel.font = [UIFont systemFontOfSize:12];
    _priceLabel.textColor = [UIColor grayColor];
    _priceLabel.textAlignment = NSTextAlignmentRight;
    _priceLabel.text = @"￥215";
    [_bgView addSubview:_priceLabel];
    
    UIView *line2 = [UIView new];
    line2.backgroundColor = [UIColor lightGrayColor];
    [_bgView addSubview:line2];
    [line2 autoPinEdgeToSuperviewEdge:ALEdgeLeft];
    [line2 autoPinEdgeToSuperviewEdge:ALEdgeBottom];
    [line2 autoSetDimensionsToSize:CGSizeMake(kScreenWidth, 0.5)];
}

- (void)setCheckInTime:(NSString *)checkInTime {
    _dateLabel.text = [checkInTime stringByReplacingOccurrencesOfString:@"-" withString:@"."];
}

- (void)setRoomPrice:(NSString *)roomPrice {
    _priceLabel.text = [NSString stringWithFormat:@"￥%@", roomPrice];
}


#pragma mark - UIButton Action

- (void)bgBtnClick:(UIButton *)sender {
    
    [UIView animateWithDuration:0.2 animations:^{
        self.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}


#pragma mark - Update Constraints

- (void)updateConstraints {
    
    [_bgView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(0, 0, 0, 0) excludingEdge:ALEdgeTop];
    [_bgView autoSetDimension:ALDimensionHeight toSize:50];
    
    [_dateLabel autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:35];
    [_dateLabel autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:15];
    [_dateLabel autoPinEdgeToSuperviewEdge:ALEdgeBottom];
    
    [_priceLabel autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:15];
    [_priceLabel autoPinEdgeToSuperviewEdge:ALEdgeBottom];
    [_priceLabel autoSetDimensionsToSize:CGSizeMake(80, 30)];
    
    
    
    [super updateConstraints];
}

@end
