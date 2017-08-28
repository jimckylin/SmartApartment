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

+ (NSString *)AES256EncryptWithJson:(NSString *)json;

@end
