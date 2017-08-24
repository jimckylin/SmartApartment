//
//  RechargeButton.m
//  SmartApartment
//
//  Created by Jimcky Lin on 2017/8/25.
//  Copyright © 2017年 Jimcky Lin. All rights reserved.
//

#import "RechargeButton.h"

@interface RechargeButton ()

@property (nonatomic, strong) UIButton *chargeBtn;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *subTitleLabel;

@end

@implementation RechargeButton

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        [self initView];
    }
    return self;
}

- (void)initView {
    
    _chargeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _chargeBtn.frame = CGRectMake(21, 20, kScreenWidth-42, 44);
    _chargeBtn.backgroundColor = [UIColor colorWithHexString:@"#FCF742"];
    _chargeBtn.layer.cornerRadius = 8;
    _chargeBtn.layer.masksToBounds = YES;
    _chargeBtn.layer.borderWidth = 1;
    _chargeBtn.layer.borderColor = [UIColor colorWithHexString:@"#FCF742"].CGColor;
    [self addSubview:_chargeBtn];
    [_chargeBtn setFrame:self.bounds];
    
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 15, self.width, 25)];
    _titleLabel.font = [UIFont boldSystemFontOfSize:16];
    _titleLabel.textColor = [UIColor darkTextColor];
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    _titleLabel.text = @"充600元";
    [self addSubview:_titleLabel];
    
    _subTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, _titleLabel.bottom, self.width, 20)];
    _subTitleLabel.font = [UIFont boldSystemFontOfSize:14];
    _subTitleLabel.textAlignment = NSTextAlignmentCenter;
    _subTitleLabel.textColor = ThemeColor;
    _subTitleLabel.text = @"赠送50元";
    [self addSubview:_subTitleLabel];
}

- (void)addAction:(SEL)sel addTarget:(id)target {
    [_chargeBtn addTarget:target action:sel forControlEvents:UIControlEventTouchUpInside];
}

- (void)setSelected:(BOOL)selected {
    
    _chargeBtn.selected = selected;
    if (_chargeBtn.selected) {
        _chargeBtn.backgroundColor = [UIColor colorWithHexString:@"#FCF742"];
    }else {
        _chargeBtn.backgroundColor = [UIColor whiteColor];
    }
    _selected = selected;
}


@end
