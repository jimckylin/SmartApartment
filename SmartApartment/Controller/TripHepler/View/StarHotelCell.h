//
//  StarHotelCell.h
//  SmartApartment
//
//  Created by Jimcky Lin on 2017/8/31.
//  Copyright © 2017年 Jimcky Lin. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol StarHotelCellDelegtate <NSObject>

// tag 1:房间卫生 2:周围环境 3:公寓服务 4:设施服务
- (void)starHotelCellStarViewDidGiveScore:(CGFloat)score viewTag:(NSInteger)tag;
- (void)starHotelCellStarViewDidComment:(NSString *)content;


@end

@interface StarHotelCell : UITableViewCell

@property (nonatomic, weak) id<StarHotelCellDelegtate> delegate;

@end
