//
//  RequestSign.h
//  SmartApartment
//
//  Created by jimcky on 2017/8/24.
//  Copyright © 2017年 Jimcky Lin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RequestSign : NSObject


+ (NSString *)signCreater:(NSDictionary *)params;

/**
 *  使用hmac-md5加密
 *
 *  @param clearText 原文
 *  @param secret    秘钥
 *
 *  @return 密文
 */

+ (NSString *)getHmacmd5:(NSString *)clearText withSecret:(NSString *)secret;

@end
