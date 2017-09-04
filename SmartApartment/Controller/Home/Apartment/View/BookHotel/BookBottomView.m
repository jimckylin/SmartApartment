//
//  BookBottomView.m
//  SmartApartment
//
//  Created by Jimcky Lin on 2017/8/19.
//  Copyright © 2017年 Jimcky Lin. All rights reserved.
//

#import "BookBottomView.h"
#import <BAButton/BAButton.h>

@interface BookBottomView ()

@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, strong) UILabel *priceLabel;

@property (nonatomic, strong) UIButton *detailBtn;
@property (nonatomic, strong) UIButton *bookBtn;

@end

@implementation BookBottomView

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
    self.backgroundColor = [UIColor whiteColor];
    
    _bgView = [UIView new];
    _bgView.backgroundColor = [UIColor whiteColor];
    [self addSubview:_bgView];
    
    
    
    _priceLabel = [UILabel new];
    _priceLabel.font = [UIFont systemFontOfSize:18];
    _priceLabel.textColor = [UIColor redColor];
    _priceLabel.numberOfLines = 0;
    _priceLabel.text = @"￥215";
    [_bgView addSubview:_priceLabel];
    
    // 时间选择
    _detailBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_detailBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [_detailBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateSelected];
    [_detailBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [_detailBtn.titleLabel setFont:[UIFont systemFontOfSize:12]];
    [_detailBtn setTitle:@"明细" forState:UIControlStateNormal];
    [_detailBtn setImage:kImage(@"order_up_iciphone") forState:UIControlStateNormal];
    _detailBtn.tag = HotelSelectBtnTypeDetail;
    [_bgView addSubview:_detailBtn];
    [_detailBtn ba_button_setButtonLayoutType:BAKit_ButtonLayoutTypeCenterImageRight padding:10];
    
    _bookBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _bookBtn.backgroundColor = ThemeColor;
    [_bookBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [_bookBtn setTitle:@"确认预订" forState:UIControlStateNormal];
    [_bookBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateSelected];
    [_bookBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_bookBtn.titleLabel setFont:[UIFont systemFontOfSize:16]];
    _bookBtn.tag = HotelSelectBtnTypeBook;
    [_bgView addSubview:_bookBtn];
}

- (void)setRoomPrice:(NSString *)roomPrice {
    
    _priceLabel.text = [NSString stringWithFormat:@"￥%@", roomPrice];
}


#pragma mark - UIButton Action

- (void)btnClick:(UIButton *)sender {
    
    HotelBookBtnType type = sender.tag;
    if (type == HotelSelectBtnTypeDetail) {
        _detailBtn.selected = !_detailBtn.selected;
        [UIView animateWithDuration:0.2 animations:^{
            if (_detailBtn.selected) {
                [_detailBtn.imageView setTransform:CGAffineTransformMakeRotation(M_PI)];
                self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
                
            }else {
                [_detailBtn.imageView setTransform:CGAffineTransformMakeRotation(0)];
                self.backgroundColor = [UIColor whiteColor];
            }
        }];
    }
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(bookBottomViewDickBtn:detailShow:)]) {
        [self.delegate bookBottomViewDickBtn:type detailShow:sender.selected];
    }
}


#pragma mark - Update Constraints

- (void)updateConstraints {

    [_bgView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(0, 0, 0, 0) excludingEdge:ALEdgeTop];
    [_bgView autoSetDimension:ALDimensionHeight toSize:50];
    
    [_priceLabel autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:15];
    [_priceLabel autoPinEdgeToSuperviewEdge:ALEdgeTop];
    [_priceLabel autoSetDimensionsToSize:CGSizeMake(80, 50)];
    
    [_bookBtn autoPinEdgeToSuperviewEdge:ALEdgeRight];
    [_bookBtn autoPinEdgeToSuperviewEdge:ALEdgeTop];
    [_bookBtn autoSetDimensionsToSize:CGSizeMake(140, 50)];
    
    [_detailBtn autoPinEdge:ALEdgeRight toEdge:ALEdgeLeft ofView:_bookBtn];
    [_detailBtn autoPinEdgeToSuperviewEdge:ALEdgeTop];
    [_detailBtn autoSetDimensionsToSize:CGSizeMake(70, 50)];
    
    [super updateConstraints];
}

@end


