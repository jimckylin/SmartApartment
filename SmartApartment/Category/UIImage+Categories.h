//
//  UIImage+Categories.h
//  CWGJCarOwner
//
//  Created by QingGeMac on 2017/7/7.
//  Copyright © 2017年 CheWeiGuanJia. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Categories)

+(UIImage*)captureScreen:(UIView*)viewToCapture;

+(UIImage *)coreBlurImage:(UIImage *)image withBlurNumber:(CGFloat)blur;

+(UIImage*)imageWithColor:(UIColor*)color;

+ (UIImage *)generatePhotoThumbnail:(UIImage *)image;

@end
