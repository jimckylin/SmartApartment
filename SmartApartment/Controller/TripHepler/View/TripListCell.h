//
//  TripListCell.h
//  SmartApartment
//
//  Created by Jimcky Lin on 2017/8/20.
//  Copyright © 2017年 Jimcky Lin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TripListCell : UITableViewCell

@property (nonatomic, copy) void(^tripListCellBlock)(NSInteger tag);

- (void)setButtonStyleHistoryTrip;

@end
