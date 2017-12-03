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
        self.layer.cornerRadius = 4.0f;
        self.layer.borderWidth = 0.5f;
        self.layer.borderColor = [UIColor lightGrayColor].CGColor;
        
        self.layer.shadowColor = [UIColor darkGrayColor].CGColor;
        self.layer.shadowOffset = CGSizeMake(1, 1);
        self.layer.shadowRadius = 2.0f;
        self.layer.shadowOpacity = 0.5f;
        self.layer.masksToBounds = YES;
        
        self.backgroundColor = [UIColor lightGrayColor];
        _nameBgView = [UIView new];
        _nameBgView.backgroundColor = [UIColor whiteColor];
        [self addSubview:_nameBgView];
        [_nameBgView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(0, 0, 0, 0) excludingEdge:ALEdgeBottom];
        [_nameBgView autoSetDimension:ALDimensionHeight toSize:20];
        
        // 标题
        _nameLabel = [RTLabel new];
        _nameLabel.font = [UIFont systemFontOfSize:12];
        _nameLabel.textColor = ThemeColor;
        _nameLabel.text = @"中式 0.01";
        [_nameBgView addSubview:_nameLabel];
        [_nameLabel autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(0, 8, 0, 0)];
        
        // 缩略图
        _imageView = [UIImageView new];
        //_imageView.highlightedImage = [UIImage imageNamed:@"activity02"];
        _imageView.contentMode = UIViewContentModeScaleAspectFill;
        _imageView.clipsToBounds = YES;
        _imageView.userInteractionEnabled = YES;
        [self addSubview:_imageView];
        [_imageView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(20, 0, 30, 0)];
        
        UITapGestureRecognizer *imageTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageTap:)];
        [_imageView addGestureRecognizer:imageTap];
        
        // 分数选择及勾选
        UIView *selectBgView = [UIView new];
        selectBgView.backgroundColor = [UIColor whiteColor];
        [self addSubview:selectBgView];
        [selectBgView autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_imageView];
        [selectBgView autoPinEdgeToSuperviewEdge:ALEdgeLeft];
        [selectBgView autoPinEdgeToSuperviewEdge:ALEdgeRight];
        [selectBgView autoSetDimension:ALDimensionHeight toSize:30];
        
        _numberBtn = [PPNumberButton numberButtonWithFrame:CGRectMake(10, 7.5, 60, 15)];
        // 初始化时隐藏减按钮
        _numberBtn.delegate = self;
        _numberBtn.defaultNumber = 1;
        _numberBtn.minValue = 1;
        _numberBtn.maxValue = 200;
        //_numberBtn.decreaseHide = YES;
        _numberBtn.increaseImage = [UIImage imageNamed:@"order_add_iciphone"];
        _numberBtn.decreaseImage = [UIImage imageNamed:@"order_minus_ic_scopyiphone"];
        [selectBgView addSubview:_numberBtn];
        [_numberBtn setHidden:YES];
        
        _selectedBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_selectedBtn addTarget:self action:@selector(selectedBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [_selectedBtn setBackgroundImage:kImage(@"unselected") forState:UIControlStateNormal];
        [_selectedBtn setBackgroundImage:kImage(@"selected") forState:UIControlStateSelected];
        [selectBgView addSubview:_selectedBtn];
        
        [_selectedBtn autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:3];
        [_selectedBtn autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:3.5];
        [_selectedBtn autoSetDimensionsToSize:CGSizeMake(23, 23)];
    }
    return self;
}


- (void)setSelectedBtnStatus:(BOOL)selected {
    
    _selectedBtn.selected = selected;
}


#pragma mark - PPNumberButtonDelegate

- (void)pp_numberButton:(PPNumberButton *)numberButton number:(NSInteger)number increaseStatus:(BOOL)increaseStatus {
    
    if (self.didSelectedBreakfastConfigNum && _selectedBtn.selected) {
        self.didSelectedBreakfastConfigNum(self.breakfast, number);
    }
    
    if (_didSelectedWineConfigNum && _selectedBtn.selected) {
        self.didSelectedWineConfigNum(self.wine, number);
    }
}


#pragma mark - UIButton Action

- (void)imageTap:(UITapGestureRecognizer*)gesture {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(hotelConfigItemCellTapImageDidSelectedIndex:configTpe:view:)]) {
        NSInteger index = 0;
        if (self.configType == HotelConfigTypeBreakfast || self.configType == HotelConfigTypeWine) {
            index = self.tag;
        } else {
            index = self.tag - 100;
        }
        [self.delegate hotelConfigItemCellTapImageDidSelectedIndex:index
                                                         configTpe:self.configType
                                                              view:gesture.view];
    }
}

- (void)selectedBtnClick:(UIButton *)btn {
   
    btn.selected = !btn.selected;
    if (self.didChangeSelectedBtnStatus) {
        self.didChangeSelectedBtnStatus(self.tag, _selectedBtn.selected, _numberBtn.currentNumber);
    }
}


#pragma mark - Setter

- (void)setAroma:(Aroma *)aroma {
    
    [_numberBtn setHidden:YES];
    [_imageView sd_setImageWithURL:[NSURL URLWithString:aroma.img] placeholderImage:kImage(@"blank_default_nomal_bg")];
    _nameLabel.text = [NSString stringWithFormat:@"%@ <font color=#1B5B5E>%@</font>", aroma.name, aroma.price];
    _aroma = aroma;
}

- (void)setBreakfast:(Breakfast *)breakfast {
    
    [_numberBtn setHidden:NO];
    [_imageView sd_setImageWithURL:[NSURL URLWithString:breakfast.img] placeholderImage:kImage(@"blank_default_nomal_bg")];
    _nameLabel.text = [NSString stringWithFormat:@"%@ <font color=#1B5B5E>%@</font>", breakfast.name, breakfast.price];
    _breakfast = breakfast;
}

- (void)setFivePiece:(FivePiece *)fivePiece {
    
    [_numberBtn setHidden:YES];
    [_imageView sd_setImageWithURL:[NSURL URLWithString:fivePiece.img] placeholderImage:kImage(@"blank_default_nomal_bg")];
    _nameLabel.text = [NSString stringWithFormat:@"%@ <font color=#1B5B5E>%@</font>", fivePiece.name, fivePiece.price];
    _fivePiece = fivePiece;
}

- (void)setRoomLayout:(RoomLayout *)roomLayout {
    
    [_numberBtn setHidden:YES];
    [_imageView sd_setImageWithURL:[NSURL URLWithString:roomLayout.img] placeholderImage:kImage(@"blank_default_nomal_bg")];
    _nameLabel.text = [NSString stringWithFormat:@"%@ <font color=#1B5B5E>%@</font>", roomLayout.name, roomLayout.price];
    _roomLayout = roomLayout;
}

- (void)setWine:(Wine *)wine {
    
    [_numberBtn setHidden:NO];
    [_imageView sd_setImageWithURL:[NSURL URLWithString:wine.img] placeholderImage:kImage(@"evaluate_blankiphone")];
    _nameLabel.text = [NSString stringWithFormat:@"%@ <font color=#1B5B5E>%@</font>", wine.name, wine.price];
    _wine = wine;
}



@end
