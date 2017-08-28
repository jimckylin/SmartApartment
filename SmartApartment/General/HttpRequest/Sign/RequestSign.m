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

//#import "SecurityUtil.h"
//#import "NSData+AES128.h"

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


+ (NSString *)byteToHexString:(NSData *)encryptedData {
    
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

+ (NSString *)AES256EncryptWithJson:(NSString *)json  //加密
{
    NSData *jsonData = [json dataUsingEncoding:NSUTF8StringEncoding];
    NSData *encryptData = [self AES256EncryptWithKey:accessKey data:jsonData];
    NSString *hexString = [self byteToHexString:encryptData];
    
    return hexString.uppercaseString;
}

+ (NSData *)AES256EncryptWithKey:(NSString *)key data:(NSData *)data  //加密

{
    
    char keyPtr[kCCKeySizeAES128+1];
    
    bzero(keyPtr, sizeof(keyPtr));
    
    [key getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];
    
    NSUInteger dataLength = [data length];
    
    size_t bufferSize = dataLength + kCCBlockSizeAES128;
    
    void *buffer = malloc(bufferSize);
    
    size_t numBytesEncrypted = 0;
    
    CCCryptorStatus cryptStatus = CCCrypt(kCCEncrypt, kCCAlgorithmAES128,
                                          
                                          kCCOptionPKCS7Padding | kCCOptionECBMode,
                                          
                                          keyPtr, kCCBlockSizeAES128,
                                          
                                          NULL,
                                          
                                          [data bytes], dataLength,
                                          
                                          buffer, bufferSize,
                                          
                                          &numBytesEncrypted);
    
    if (cryptStatus == kCCSuccess) {
        
        return [NSData dataWithBytesNoCopy:buffer length:numBytesEncrypted];
        
    }
    
    free(buffer);
    
    return nil;
    
}

@end


@interface NSData (Encypt)

@end

@implementation NSData (Encypt)


#pragma mark -






@end




