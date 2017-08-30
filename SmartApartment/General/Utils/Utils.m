//
//  Utils.m
//  SmartApartment
//
//  Created by Jimcky Lin on 2017/8/29.
//  Copyright © 2017年 Jimcky Lin. All rights reserved.
//

#import "Utils.h"

@implementation Utils

//计算字符串一行的长度，当字符串不换行的情况下
+ (CGFloat)getContentMaxWidth:(NSString *)content FontSize:(int)fontsize {
    if (content.length == 0 || content == nil) {
        return 0;
    }
    UIFont *font = [UIFont systemFontOfSize:fontsize];
    NSAttributedString *attributedText = [[NSAttributedString alloc]initWithString:content attributes:@{NSFontAttributeName:font}];
    CGRect rect = [attributedText boundingRectWithSize:(CGSize){10000, CGFLOAT_MAX} options:NSStringDrawingUsesLineFragmentOrigin context:nil];
    CGSize size = rect.size;
    
    return size.width;
}

//计算字符串在给定宽度下的高度
+ (CGFloat)getContentHeight:(NSString *)content Width:(float)width FontSize:(int)fontsize {
    if (content.length == 0 || content == nil) {
        return 0;
    }
    UIFont *font = [UIFont systemFontOfSize:fontsize];
    NSDictionary *attribute = @{NSFontAttributeName:font};
    CGSize retSize = [content boundingRectWithSize:(CGSize){width, CGFLOAT_MAX}
                                           options:\
                      NSStringDrawingTruncatesLastVisibleLine |
                      NSStringDrawingUsesLineFragmentOrigin |
                      NSStringDrawingUsesFontLeading
                                        attributes:attribute
                                           context:nil].size;
    CGFloat height = retSize.height + 0.5;
    return height;
}

//计算字符串在给定宽度下的高度 ----粗体
+ (CGFloat)getBlodContentHeight:(NSString *)content Width:(float)width FontSize:(int)fontsize {
    if (content.length == 0) {
        return 0;
    }
    UIFont *font = [UIFont boldSystemFontOfSize:fontsize];
    NSDictionary *attribute = @{NSFontAttributeName:font};
    CGSize retSize = [content boundingRectWithSize:(CGSize){width, CGFLOAT_MAX}
                                           options:\
                      NSStringDrawingTruncatesLastVisibleLine |
                      NSStringDrawingUsesLineFragmentOrigin |
                      NSStringDrawingUsesFontLeading
                                        attributes:attribute
                                           context:nil].size;
    CGFloat height = retSize.height + 0.5;
    return height;
}


@end
