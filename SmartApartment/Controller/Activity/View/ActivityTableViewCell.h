//
//  ActivityTableViewCell.h
//  SmartApartment
//
//  Created by Jimcky Lin on 2017/8/12.
//  Copyright © 2017年 Jimcky Lin. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Activity;

@interface ActivityTableViewCell : UITableViewCell

@property (nonatomic, strong) Activity *activity;
@end
