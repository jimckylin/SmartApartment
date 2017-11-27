//
//  HotelConfigHeaderView.m
//  SmartApartment
//
//  Created by Jimcky Lin on 2017/9/4.
//  Copyright © 2017年 Jimcky Lin. All rights reserved.
//

#import "HotelConfigHeaderView.h"
#import <PPNumberButton/PPNumberButton.h>

@interface HotelConfigHeaderView ()<PPNumberButtonDelegate>

@property (nonatomic, strong) UILabel      *nameLabel;
//@property (nonatomic, strong) PPNumberButton *roomNumBtn;
@end

@implementation HotelConfigHeaderView

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor colorWithHexString:@"#F1F2F6"];
        
        _nameLabel = [UILabel new];
        _nameLabel.font = [UIFont systemFontOfSize:15];
        _nameLabel.textColor = [UIColor colorWithHexString:@"#545253"];
        _nameLabel.text = @"中式 0.01";
        [self addSubview:_nameLabel];
        [_nameLabel autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(0, 8, 0, 0)];
        
//        _roomNumBtn = [PPNumberButton numberButtonWithFrame:CGRectMake(kScreenWidth-50 - 117, 19.5, 100, 15)];
//        // 初始化时隐藏减按钮
//        _roomNumBtn.delegate = self;
//        _roomNumBtn.defaultNumber = 1;
//        _roomNumBtn.minValue = 1;
//        _roomNumBtn.maxValue = 200;
//        _roomNumBtn.decreaseHide = YES;
//        _roomNumBtn.increaseImage = [UIImage imageNamed:@"order_add_iciphone"];
//        _roomNumBtn.decreaseImage = [UIImage imageNamed:@"order_minus_ic_scopyiphone"];
//        [self addSubview:_roomNumBtn];
    }
    
    return self;
}

- (void)setTitle:(NSString *)title {
    
    _nameLabel.text = title;
//    if ([title isEqualToString:@"早餐"]) {
//        _roomNumBtn.hidden = NO;
//    }else {
//        _roomNumBtn.hidden = YES;
//    }
}


#pragma mark - PPNumberButtonDelegate

- (void)pp_numberButton:(PPNumberButton *)numberButton number:(NSInteger)number increaseStatus:(BOOL)increaseStatus {
    
    if (self.didSelectedBreakfastNum) {
        self.didSelectedBreakfastNum(number);
    }
}


@end
