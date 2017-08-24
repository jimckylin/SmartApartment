//
//  Encrypt.h
//  SmartApartment
//
//  Created by jimcky on 2017/8/24.
//  Copyright © 2017年 Jimcky Lin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Encrypt : NSObject

/**
 *  MD5加密, 32位 小写
 *
 *  @param str 传入要加密的字符串
 *
 *  @return 返回加密后的字符串
 */
+(NSString *)MD5ForLower32Bate:(NSString *)str;

/**
 *  MD5加密, 32位 大写
 *
 *  @param str 传入要加密的字符串
 *
 *  @return 返回加密后的字符串
 */
+(NSString *)MD5ForUpper32Bate:(NSString *)str;

/**
 *  MD5加密, 16位 小写
 *
 *  @param str 传入要加密的字符串
 *
 *  @return 返回加密后的字符串
 */
+(NSString *)MD5ForLower16Bate:(NSString *)str;

/**
 *  MD5加密, 16位 大写
 *
 *  @param str 传入要加密的字符串
 *
 *  @return 返回加密后的字符串
 */
+(NSString *)MD5ForUpper16Bate:(NSString *)str;


/**
 13  *  AES128加密
 14  *
 15  *  @param plainText 原文
 16  *
 17  *  @return 加密好的字符串
 18  */
+ (NSString *)AES128Encrypt:(NSString *)plainText;
/**
    21  *  AES128解密
    22  *
    23  *  @param encryptText 密文
    24  *
    25  *  @return 明文
    26  */
+ (NSString *)AES128Decrypt:(NSString *)encryptText;

@end
