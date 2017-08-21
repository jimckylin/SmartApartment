//
//  MyOrderCell.m
//  SmartApartment
//
//  Created by Jimcky Lin on 2017/8/22.
//  Copyright © 2017年 Jimcky Lin. All rights reserved.
//

#import "MyOrderCell.h"

@interface MyOrderCell ()

@property (nonatomic, strong) IBOutlet UIView   *bgView;
@property (nonatomic, strong) IBOutlet UIButton *cancelOrderBtn;
@property (nonatomic, strong) IBOutlet UIButton *payOrderBtn;
@end

@implementation MyOrderCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    self.cancelOrderBtn.layer.borderWidth = 1;
    self.cancelOrderBtn.layer.borderColor = [UIColor grayColor].CGColor;
    
    self.payOrderBtn.layer.borderWidth = 1;
    self.payOrderBtn.layer.borderColor = [UIColor redColor].CGColor;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
