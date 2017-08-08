//
//  UIImage+iconfont.h
//  CarOwner
//
//  Created by cwgj on 16/11/10.
//  Copyright © 2016年 卢椿庆. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (iconfont)

+ (UIImage*)imageWithIcon:(NSString*)iconCode inFont:(NSString*)fontName size:(NSUInteger)size color:(UIColor*)color ;

+ (UIImage*)imageWithIcon:(NSString*)iconCode size:(NSUInteger)size color:(UIColor*)color;

+(UIImage*)captureScreen:(UIView*)viewToCapture;

+(UIImage *)coreBlurImage:(UIImage *)image withBlurNumber:(CGFloat)blur;

+(UIImage*)imageWithColor:(UIColor*)color;


@end
