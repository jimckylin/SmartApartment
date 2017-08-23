//
//  GJZFBPayRContent.h
//
//  Created by   on 15/6/2
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface ZFBPayRContent : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *subject;
@property (nonatomic, strong) NSString *body;
@property (nonatomic, strong) NSString *rsaPrivate;
@property (nonatomic, strong) NSString *notifyUrl;
@property (nonatomic, strong) NSString *inputCharset;
@property (nonatomic, strong) NSString *paymentType;
@property (nonatomic, strong) NSString *totalFee;
@property (nonatomic, strong) NSString *itBPay;
@property (nonatomic, strong) NSString *partner;
@property (nonatomic, strong) NSString *outTradeNo;
@property (nonatomic, strong) NSString *service;
@property (nonatomic, strong) NSString *signType;
@property (nonatomic, strong) NSString *sellerId;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
