//
//  GJWXPayRContent.h
//
//  Created by   on 15/6/2
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface WXPayRContent : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *appkey;
@property (nonatomic, strong) NSString *packagevalue;
@property (nonatomic, strong) NSString *partnerid;
@property (nonatomic, strong) NSString *appid;
@property (nonatomic, strong) NSString *noncestr;
@property (nonatomic, strong) NSString *timestamp;
@property (nonatomic, strong) NSString *prepayid;
@property (nonatomic, strong) NSString *sign;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
