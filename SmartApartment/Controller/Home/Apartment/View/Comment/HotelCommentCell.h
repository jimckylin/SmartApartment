//
//  HotelDetailCommentCell.h
//  SmartApartment
//
//  Created by jimcky on 2017/8/18.
//  Copyright © 2017年 Jimcky Lin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StoreEvaluate.h"

@interface HotelCommentCell : UITableViewCell

@property (nonatomic, strong) StoreEvaluate *evaluate;

+ (CGFloat)getCellHeightWith:(StoreEvaluate *)evaluate;

@end
