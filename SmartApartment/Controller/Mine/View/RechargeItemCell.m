//
//  HotelConfigItemCell.m
//  SmartApartment
//
//  Created by Jimcky Lin on 2017/9/4.
//  Copyright © 2017年 Jimcky Lin. All rights reserved.
//

#import "RechargeItemCell.h"


@interface RechargeItemCell ()

@property (nonatomic, strong) UILabel       *titleLabel;
@property (nonatomic, strong) UILabel       *subTitleLabel;

@end

@implementation RechargeItemCell

-(id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        
        _titleLabel = [UILabel new];
        _titleLabel.font = [UIFont systemFontOfSize:16];
        _titleLabel.textColor = [UIColor darkTextColor];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.text = @"充600元";
        [self addSubview:_titleLabel];
        [_titleLabel autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(0, 0, self.height/2, 0) excludingEdge:ALEdgeTop];
        
        _subTitleLabel = [UILabel new];
        _subTitleLabel.font = [UIFont systemFontOfSize:14];
        _subTitleLabel.textColor = ThemeColor;
        _subTitleLabel.textAlignment = NSTextAlignmentCenter;
        _subTitleLabel.text = @"赠送50元";
        [self addSubview:_subTitleLabel];
        [_subTitleLabel autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(self.height/2, 0, 0, 0) excludingEdge:ALEdgeBottom];
    }
    
    return self;
    
}


- (void)setRechargeDic:(NSDictionary *)rechargeDic {
    
    _titleLabel.text = [NSString stringWithFormat:@"充%@元", rechargeDic[@"rechargeMoney"]];
    _subTitleLabel.text = [NSString stringWithFormat:@"赠送%@元", rechargeDic[@"giveMoney"]];
}


- (void)setSelected:(BOOL)selected{
    [super setSelected:selected];
    UIView *view = [UIView new];
    view.layer.cornerRadius =5;
    view.layer.masksToBounds = YES;
    view.backgroundColor = [UIColor colorWithHexString:@"#FCF742"];
    view.frame = self.bounds;
    
    self.selectedBackgroundView = view;
    
    // Configure the view for the selected state
}

@end
