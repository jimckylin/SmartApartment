//
//  HotelConfigHeaderView.m
//  SmartApartment
//
//  Created by Jimcky Lin on 2017/9/4.
//  Copyright © 2017年 Jimcky Lin. All rights reserved.
//

#import "HotelConfigHeaderView.h"

@interface HotelConfigHeaderView ()

@property (nonatomic, strong) UILabel      *nameLabel;
@end

@implementation HotelConfigHeaderView

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithHexString:@"#F1F2F6"];
        
        _nameLabel = [UILabel new];
        _nameLabel.font = [UIFont systemFontOfSize:15];
        _nameLabel.textColor = [UIColor colorWithHexString:@"#545253"];
        _nameLabel.text = @"中式 0.01";
        [self addSubview:_nameLabel];
        [_nameLabel autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(0, 8, 0, 0)];
    }
    
    return self;
}

- (void)setTitle:(NSString *)title {
    
    _nameLabel.text = title;
}

@end
