//
//  UIButton+actionBlock.h
//  
//
//  Created by Alpha Yu on 10/10/15.
//
//

#import <UIKit/UIKit.h>

@interface UIButton (AYActionBlock)

@property (nonatomic, readonly) void (^ay_actionBlock)(void);

- (void)ay_setActionBlock:(void (^)(void))actionBlock;

@end
