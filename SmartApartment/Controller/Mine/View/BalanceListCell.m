//
//  TableViewCell.m
//  SmartApartment
//
//  Created by Jimcky Lin on 2017/8/24.
//  Copyright © 2017年 Jimcky Lin. All rights reserved.
//

#import "BalanceListCell.h"

@interface BalanceListCell ()

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;

@end

@implementation BalanceListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    UIView *line = [UIView new];
    line.backgroundColor = [UIColor lightGrayColor];
    [self addSubview:line];
    
    [line autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(0, 15, 0, 0) excludingEdge:ALEdgeTop];
    [line autoSetDimension:ALDimensionHeight toSize:0.5];
}

- (void)setConsumeDict:(NSDictionary *)consumeDict {
    
    self.titleLabel.text = consumeDict[@"consumeTitle"];
    self.priceLabel.text = [NSString stringWithFormat:@"-%@元", consumeDict[@"consumePrice"]];
    self.dateLabel.text = consumeDict[@"consumeDate"];
}

- (void)setRechargeDict:(NSDictionary *)rechargeDict {
    
    self.titleLabel.text = rechargeDict[@"rechargeTitle"];
    self.priceLabel.text = [NSString stringWithFormat:@"+%@元", rechargeDict[@"rechargePrice"]];
    self.dateLabel.text = rechargeDict[@"rechargeDate"];
}

@end
