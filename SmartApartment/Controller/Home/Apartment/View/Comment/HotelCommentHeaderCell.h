//
//  HotelDetailCommentHeaderCell.h
//  SmartApartment
//
//  Created by jimcky on 2017/8/18.
//  Copyright © 2017年 Jimcky Lin. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, CommentType) {
    
    CommentTypeAll = 0,      // 全部评价
    CommentTypeGood,         // 好评
    CommentTypeNotbad,       // 中评
    CommentTypeBad,          // 差评
};


@protocol HotelCommentHeaderCellDelegate <NSObject>

- (void)hotelCommentHeaderCellDidClick:(CommentType)type;
@end


@interface HotelCommentHeaderCell : UITableViewCell

@property (nonatomic, weak) id<HotelCommentHeaderCellDelegate> delegate;

- (void)setCommentHeaderDic:(NSDictionary*)commentDic;

@end