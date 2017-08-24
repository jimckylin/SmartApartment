//
//  RechargeButton.h
//  SmartApartment
//
//  Created by Jimcky Lin on 2017/8/25.
//  Copyright © 2017年 Jimcky Lin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RechargeButton : UIView

@property (nonatomic, assign) BOOL selected;

- (void)addAction:(SEL)sel addTarget:(id)target;

@end
