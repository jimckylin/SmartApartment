//
//  HotelConfigCell.m
//  SmartApartment
//
//  Created by Jimcky Lin on 2017/8/28.
//  Copyright © 2017年 Jimcky Lin. All rights reserved.
//

#import "HotelConfigCell.h"
#import "Hotel.h"

@interface HotelConfigCell ()

@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation HotelConfigCell

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

- (void)initSubView {
    
    UIView *bgView = [UIView new];
    bgView.backgroundColor = [UIColor whiteColor];
    [self addSubview:bgView];
    [bgView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
    
    _titleLabel = [UILabel new];
    _titleLabel.font = [UIFont systemFontOfSize:15];
    _titleLabel.textColor = [UIColor darkTextColor];
    _titleLabel.text = @"酒店设施";
    [bgView addSubview:_titleLabel];
}


- (void)setHotel:(Hotel *)hotel {
    
    NSArray *devices = [hotel.storeDevice componentsSeparatedByString:@";"];
    
}


- (void)updateConstraints {
    
    [_titleLabel autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:15];
    [_titleLabel autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:15];
    [_titleLabel autoSetDimension:ALDimensionWidth toSize:kScreenWidth-30];
    
    
    [super updateConstraints];
}

@end
