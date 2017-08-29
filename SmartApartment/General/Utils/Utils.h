//
//  Utils.h
//  SmartApartment
//
//  Created by Jimcky Lin on 2017/8/29.
//  Copyright © 2017年 Jimcky Lin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Utils : NSObject

+ (CGFloat)getContentMaxWidth:(NSString *)content FontSize:(int)fontsize;
+ (CGFloat)getContentHeight:(NSString *)content Width:(float)width FontSize:(int)fontsize;
+ (CGFloat)getBlodContentHeight:(NSString *)content Width:(float)width FontSize:(int)fontsize;

@end
