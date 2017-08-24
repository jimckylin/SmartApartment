//
//  RequestSign.m
//  SmartApartment
//
//  Created by jimcky on 2017/8/24.
//  Copyright © 2017年 Jimcky Lin. All rights reserved.
//

#import "RequestSign.h"
#include <CommonCrypto/CommonHMAC.h>
#import "Encrypt.h"

NSString *const accessKey = @"NJ6KD5V31D5TZ956";

@implementation RequestSign

+ (NSString *)signCreater:(NSDictionary *)params {
    
    NSArray *signArray = [self dicToString:params];
    NSArray *sortedArray = [signArray sortedArrayUsingComparator:^(id string1, id string2) {
        return [((NSString *)string1) compare:((NSString *)string2) options:NSNumericSearch];
    }];
    
    NSString *string = [sortedArray componentsJoinedByString:@"&"];
    NSString *sign = [NSString stringWithFormat:@"%@&key=%@", string, accessKey];
    sign = [Encrypt MD5ForLower32Bate:sign].uppercaseString;
    
    return sign;
}

+ (NSArray *)dicToString:(NSDictionary *)dic {
    
    NSMutableArray *array = [NSMutableArray array];
    for (NSString *key in [dic allKeys]) {
        id vaule = [dic objectForKey:key];
        if (![vaule isKindOfClass:[NSDictionary class]]) {
            [array addObject:[NSString stringWithFormat:@"%@=%@", key, vaule]];
        }else {
            [array addObjectsFromArray:[self dicToString:vaule]];
        }
    }
    return array;
}


//密码进行hmac-md5加密
+ (NSString *)getHmacmd5:(NSString *)clearText withSecret:(NSString *)secret{
    
    CCHmacContext ctx;
    
    //使用GBK编码
    unsigned long encode = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
    const char *key = [secret cStringUsingEncoding:encode];
    const char *str = [clearText cStringUsingEncoding:encode];
    
    unsigned char mac[CC_MD5_DIGEST_LENGTH];
    char hexmac[2 * CC_MD5_DIGEST_LENGTH + 1];

    char *p;
    CCHmacInit(&ctx, kCCHmacAlgMD5, key, strlen(key));
    CCHmacUpdate(&ctx, str, strlen(str));
    CCHmacFinal(&ctx, mac);
    p = hexmac;
    
    for (int i = 0; i < CC_MD5_DIGEST_LENGTH;i++) {
        snprintf(p,3,"%02x", mac[ i ]);
        p += 2;
    }
    
    return [NSString stringWithCString:hexmac encoding:encode];
}

@end
