//
//  HotelSelectView.h
//  SmartApartment
//
//  Created by jimcky on 2017/8/7.
//  Copyright © 2017年 Jimcky Lin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HotelSelectSubView.h"

@interface HotelSelectView : UIView

@property (nonatomic, weak) id<HotelSelectViewDelegate> deletegate;
@property (nonatomic, strong) NSDate *checkinDate;
@property (nonatomic, strong) NSDate *checkoutDate;

- (instancetype)initWithDelegate:(id<HotelSelectViewDelegate>)delegate;

@end
