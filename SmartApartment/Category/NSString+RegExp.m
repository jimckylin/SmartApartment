//
//  NSString+RegExp.m
//  Fashion
//
//  Created by wuqiang on 14/12/5.
//  Copyright (c) 2014年 com.newbie.circle. All rights reserved.
//

#import "NSString+RegExp.h"

@implementation NSString (RegExp)


- (BOOL)isPhoneNumber
{
//    NSString *phoneNumRegExp = @"^(13|14|15|17|18|19)\\d{9}$";
//    NSPredicate *test = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", phoneNumRegExp];
//    return [test evaluateWithObject:self];
    
    /**
     * 手机号码
     * 移动：134[0-8],135,136,137,138,139,147,150,151，152,157,158,159,178,182,183,184,187,188
     * 联通：130,131,132,145,152,155,156,176,185,186
     * 电信：133,1349,153,170,177,180,181,189
     */
    
    NSString *MOBILE = @"^1(3[0-9]|5[0-35-9]|4[57]|7[0678]|8[0-9])\\d{8}$";
    /**
     * 中国移动：China Mobile
     * 2G号段（GSM网络）有134x（0-8）、135、136、137、138、139、150、151、152、158、159、182、183、184。
     * 3G号段（TD-SCDMA网络）有157、187、188
     * 3G上网卡 147
     * 4G号段 178
     */
    //    NSString * CM = @"^1(34[0-8]|(3[5-9]|47|5[0-27-9]|78|8[2-478])\\d)\\d{7}$";
    
    /**
     * 中国联通：China Unicom
     * 2G号段（GSM网络）130、131、132、155、156
     * 3G上网卡145
     * 3G号段（WCDMA网络）185、186
     * 4G号段 176
     */
    //    NSString * CU = @"^1(3[0-2]|45|5[256]|76|8[56])\\d{8}$";
    
    /**
     * 中国电信：China Telecom
     * 2G/3G号段（CDMA2000网络）133、1349、153、180、181、189
     * 4G号段 177
     */
    //    NSString * CT = @"^1((33|53|8[09])[0-9]|349)\\d{7}$";
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    return [regextestmobile evaluateWithObject:self];
}

- (BOOL)isNumber {
    
    NSString *regExp = @"^[1-9]d*$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regExp];
    return [predicate evaluateWithObject:self];
}

- (BOOL)isUpcasecharacter {
    
    NSString *regExp = @"^[A-Z]+$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regExp];
    return [predicate evaluateWithObject:self];
}

- (BOOL)isSpecialCharacter {
    
    NSString *regExp = @"\\b";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regExp];
    return [predicate evaluateWithObject:self];
}



@end
