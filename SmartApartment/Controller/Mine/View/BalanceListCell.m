//
//  TableViewCell.m
//  SmartApartment
//
//  Created by Jimcky Lin on 2017/8/24.
//  Copyright © 2017年 Jimcky Lin. All rights reserved.
//

#import "BalanceListCell.h"

@implementation BalanceListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    UIView *line = [UIView new];
    line.backgroundColor = [UIColor lightGrayColor];
    [self addSubview:line];
    
    [line autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(0, 15, 0, 0) excludingEdge:ALEdgeTop];
    [line autoSetDimension:ALDimensionHeight toSize:0.5];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
