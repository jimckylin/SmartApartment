//
//  UIButton+countDown.h
//  CarFriend
//
//  Created by mac on 16/4/2.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^TimeOutBlock)(void);

@interface UIButton (countDown)

@property (nonatomic, strong) UIColor *disableBackGroundColor;

@property (nonatomic, strong) NSString *timeoutText;

- (void)startCountDown:(NSInteger)count;

- (void)startCountDown:(NSInteger)count timeOut:(TimeOutBlock)timeout;

@end
