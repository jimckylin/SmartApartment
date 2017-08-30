//
//  RequestSign.m
//  SmartApartment
//
//  Created by jimcky on 2017/8/24.
//  Copyright © 2017年 Jimcky Lin. All rights reserved.
//

#import "RequestSign.h"
#import "Encrypt.h"
#import <CommonCrypto/CommonCrypto.h>

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


//------------------------------------

+ (NSString *)byte2HexString:(NSData *)encryptedData {
    
    //下面是Byte 转换为16进制。
    NSString *hexStr=@"";
    Byte *bytes = (Byte *)[encryptedData bytes];
    for(int i=0; i<[encryptedData length]; i++)
    {
        NSString *newHexStr = [NSString stringWithFormat:@"%x",bytes[i]&0xff];///16进制数
        if([newHexStr length]==1)
            hexStr = [NSString stringWithFormat:@"%@0%@",hexStr,newHexStr];
        else
            hexStr = [NSString stringWithFormat:@"%@%@",hexStr,newHexStr];
    }
    NSLog(@"%@", hexStr);
    NSLog(@"%@", hexStr.uppercaseString);
    return hexStr.uppercaseString;
}

+ (NSData *)hexString2byte:(NSString *)hex {
    NSMutableData *data = [NSMutableData dataWithCapacity:hex.length / 2];
    unsigned char whole_byte;
    char byte_chars[3] = {'\0','\0','\0'};
    int i;
    for (i=0; i < hex.length / 2; i++) {
        byte_chars[0] = [hex characterAtIndex:i*2];
        byte_chars[1] = [hex characterAtIndex:i*2+1];
        whole_byte = strtol(byte_chars, NULL, 16);
        [data appendBytes:&whole_byte length:1];
    }
    return data;
}



@end





