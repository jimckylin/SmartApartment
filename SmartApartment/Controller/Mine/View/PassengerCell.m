//
//  PassengerCell.m
//  SmartApartment
//
//  Created by Jimcky Lin on 2017/8/20.
//  Copyright © 2017年 Jimcky Lin. All rights reserved.
//

#import "PassengerCell.h"

@interface PassengerCell ()

@property (nonatomic, weak) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *phoneLabel;

@end

@implementation PassengerCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}


- (void)setContact:(NSDictionary *)contact {
    
    _nameLabel.text = contact[@"name"];
    _phoneLabel.text = contact[@"mobilePhone"];
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
