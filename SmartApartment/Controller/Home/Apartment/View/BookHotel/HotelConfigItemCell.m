//
//  HotelConfigItemCell.m
//  SmartApartment
//
//  Created by Jimcky Lin on 2017/9/4.
//  Copyright © 2017年 Jimcky Lin. All rights reserved.
//

#import "HotelConfigItemCell.h"
#import "RTLabel.h"
#import <PPNumberButton/PPNumberButton.h>

#import "Aroma.h"
#import "Breakfast.h"
#import "FivePiece.h"
#import "RoomLayout.h"
#import "Wine.h"

@interface HotelConfigItemCell ()<PPNumberButtonDelegate>

@property (nonatomic, strong) UIImageView  *imageView;
@property (nonatomic, strong) UIView       *nameBgView;
@property (nonatomic, strong) RTLabel      *nameLabel;
@property (nonatomic, strong) UIButton     *selectedBtn;
@property (nonatomic, strong) PPNumberButton *numberBtn;

@end

@implementation HotelConfigItemCell

-(id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        _nameBgView = [UIView new];
        _nameBgView.backgroundColor = [UIColor whiteColor];
        [self addSubview:_nameBgView];
        [_nameBgView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(0, 0, 0, 0) excludingEdge:ALEdgeBottom];
        [_nameBgView autoSetDimension:ALDimensionHeight toSize:20];
        
        // 标题
        _nameLabel = [RTLabel new];
        _nameLabel.font = [UIFont systemFontOfSize:12];
        _nameLabel.textColor = [UIColor grayColor];
        _nameLabel.text = @"中式 0.01";
        [_nameBgView addSubview:_nameLabel];
        [_nameLabel autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(0, 8, 0, 0)];
        
        // 缩略图
        _imageView = [UIImageView new];
        //_imageView.highlightedImage = [UIImage imageNamed:@"activity02"];
        _imageView.contentMode = UIViewContentModeScaleAspectFill;
        _imageView.clipsToBounds = YES;
        [self addSubview:_imageView];
        [_imageView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(20, 0, 20, 0)];
        
        // 分数选择及勾选
        UIView *selectBgView = [UIView new];
        selectBgView.backgroundColor = [UIColor whiteColor];
        [self addSubview:selectBgView];
        [selectBgView autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_imageView];
        [selectBgView autoPinEdgeToSuperviewEdge:ALEdgeLeft];
        [selectBgView autoPinEdgeToSuperviewEdge:ALEdgeRight];
        [selectBgView autoSetDimension:ALDimensionHeight toSize:20];
        
        _numberBtn = [PPNumberButton numberButtonWithFrame:CGRectMake(10, 2.5, 60, 15)];
        // 初始化时隐藏减按钮
        //_numberBtn.delegate = self;
        _numberBtn.defaultNumber = 1;
        _numberBtn.minValue = 1;
        _numberBtn.maxValue = 200;
        _numberBtn.decreaseHide = YES;
        _numberBtn.increaseImage = [UIImage imageNamed:@"order_add_iciphone"];
        _numberBtn.decreaseImage = [UIImage imageNamed:@"order_minus_ic_scopyiphone"];
        [selectBgView addSubview:_numberBtn];
        [_numberBtn setHidden:YES];
        
        _selectedBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_selectedBtn addTarget:self action:@selector(selectedBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        //[_selectedBtn setImage:kImage(@"reserve_payiphone") forState:UIControlStateNormal];
        [_selectedBtn setImage:kImage(@"Selected_iciphone") forState:UIControlStateSelected];
        [selectBgView addSubview:_selectedBtn];
        
        [_selectedBtn autoPinEdgeToSuperviewEdge:ALEdgeRight];
        [_selectedBtn autoPinEdgeToSuperviewEdge:ALEdgeBottom];
        [_selectedBtn autoSetDimensionsToSize:CGSizeMake(20, 20)];
    }
    return self;
}

- (void)setCellSelected:(BOOL)selected {
    
    _selectedBtn.selected = selected;
}


#pragma mark - PPNumberButtonDelegate

- (void)pp_numberButton:(PPNumberButton *)numberButton number:(NSInteger)number increaseStatus:(BOOL)increaseStatus {
    
    if (self.didSelectedBreakfastNum) {
        self.didSelectedBreakfastNum(number);
    }
}


#pragma mark - UIButton Action

- (void)selectedBtnClick:(UIButton *)btn {
   
    btn.selected = !btn.selected;
}


#pragma mark - Setter

- (void)setAroma:(Aroma *)aroma {
    
    [_numberBtn setHidden:YES];
    [_imageView sd_setImageWithURL:[NSURL URLWithString:@""] placeholderImage:kImage(@"blank_default_nomal_bg")];
    _nameLabel.text = [NSString stringWithFormat:@"%@ <font color=red>%@</font>", aroma.name, aroma.price];
}

- (void)setBreakfast:(Breakfast *)breakfast {
    
    [_numberBtn setHidden:NO];
    [_imageView sd_setImageWithURL:[NSURL URLWithString:breakfast.img] placeholderImage:kImage(@"blank_default_nomal_bg")];
    _nameLabel.text = [NSString stringWithFormat:@"%@ <font color=red>%@</font>", breakfast.name, breakfast.price];
}

- (void)setFivePiece:(FivePiece *)fivePiece {
    
    [_numberBtn setHidden:YES];
    [_imageView sd_setImageWithURL:[NSURL URLWithString:fivePiece.img] placeholderImage:kImage(@"blank_default_nomal_bg")];
    _nameLabel.text = [NSString stringWithFormat:@"%@ <font color=red>%@</font>", fivePiece.name, fivePiece.price];
}

- (void)setRoomLayout:(RoomLayout *)roomLayout {
    
    [_numberBtn setHidden:YES];
    [_imageView sd_setImageWithURL:[NSURL URLWithString:roomLayout.img] placeholderImage:kImage(@"blank_default_nomal_bg")];
    _nameLabel.text = [NSString stringWithFormat:@"%@ <font color=red>%@</font>", roomLayout.name, roomLayout.price];
}

- (void)setWine:(Wine *)wine {
    
    [_numberBtn setHidden:NO];
    [_imageView sd_setImageWithURL:[NSURL URLWithString:wine.img] placeholderImage:kImage(@"evaluate_blankiphone")];
    _nameLabel.text = [NSString stringWithFormat:@"%@ <font color=red>%@</font>", wine.name, wine.price];
}



- (void)setSelected:(BOOL)selected{
    [super setSelected:selected];
    NSLog(@"%@", _numberBtn);
    //_imageView.highlighted = selected;
    //_selectedBtn.selected = selected;
}

@end
