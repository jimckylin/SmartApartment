//
//  GJWXPayRContent.h
//
//  Created by   on 15/6/2
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface WXPayRContent : NSObject <NSCoding, NSCopying>

@property (nonatomic, copy) NSString *appkey;
@property (nonatomic, copy) NSString *packagevalue;
@property (nonatomic, copy) NSString *partnerid;
@property (nonatomic, copy) NSString *appid;
@property (nonatomic, copy) NSString *noncestr;
@property (nonatomic, copy) NSString *timestamp;
@property (nonatomic, copy) NSString *prepayid;
@property (nonatomic, copy) NSString *sign;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
