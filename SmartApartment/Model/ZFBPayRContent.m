//
//  GJZFBPayRContent.m
//
//  Created by   on 15/6/2
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "ZFBPayRContent.h"


NSString *const kGJZFBPayRContentSubject = @"subject";
NSString *const kGJZFBPayRContentBody = @"body";
NSString *const kGJZFBPayRContentRsaPrivate = @"rsa_private";
NSString *const kGJZFBPayRContentNotifyUrl = @"notify_url";
NSString *const kGJZFBPayRContentInputCharset = @"input_charset";
NSString *const kGJZFBPayRContentPaymentType = @"payment_type";
NSString *const kGJZFBPayRContentTotalFee = @"total_fee";
NSString *const kGJZFBPayRContentItBPay = @"it_b_pay";
NSString *const kGJZFBPayRContentPartner = @"partner";
NSString *const kGJZFBPayRContentOutTradeNo = @"out_trade_no";
NSString *const kGJZFBPayRContentService = @"service";
NSString *const kGJZFBPayRContentSignType = @"sign_type";
NSString *const kGJZFBPayRContentSellerId = @"seller_id";


@interface ZFBPayRContent ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation ZFBPayRContent

@synthesize subject = _subject;
@synthesize body = _body;
@synthesize rsaPrivate = _rsaPrivate;
@synthesize notifyUrl = _notifyUrl;
@synthesize inputCharset = _inputCharset;
@synthesize paymentType = _paymentType;
@synthesize totalFee = _totalFee;
@synthesize itBPay = _itBPay;
@synthesize partner = _partner;
@synthesize outTradeNo = _outTradeNo;
@synthesize service = _service;
@synthesize signType = _signType;
@synthesize sellerId = _sellerId;


+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict
{
    return [[self alloc] initWithDictionary:dict];
}

- (instancetype)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if(self && [dict isKindOfClass:[NSDictionary class]]) {
            self.subject = [self objectOrNilForKey:kGJZFBPayRContentSubject fromDictionary:dict];
            self.body = [self objectOrNilForKey:kGJZFBPayRContentBody fromDictionary:dict];
            self.rsaPrivate = [self objectOrNilForKey:kGJZFBPayRContentRsaPrivate fromDictionary:dict];
            self.notifyUrl = [self objectOrNilForKey:kGJZFBPayRContentNotifyUrl fromDictionary:dict];
            self.inputCharset = [self objectOrNilForKey:kGJZFBPayRContentInputCharset fromDictionary:dict];
            self.paymentType = [self objectOrNilForKey:kGJZFBPayRContentPaymentType fromDictionary:dict];
            self.totalFee = [self objectOrNilForKey:kGJZFBPayRContentTotalFee fromDictionary:dict];
            self.itBPay = [self objectOrNilForKey:kGJZFBPayRContentItBPay fromDictionary:dict];
            self.partner = [self objectOrNilForKey:kGJZFBPayRContentPartner fromDictionary:dict];
            self.outTradeNo = [self objectOrNilForKey:kGJZFBPayRContentOutTradeNo fromDictionary:dict];
            self.service = [self objectOrNilForKey:kGJZFBPayRContentService fromDictionary:dict];
            self.signType = [self objectOrNilForKey:kGJZFBPayRContentSignType fromDictionary:dict];
            self.sellerId = [self objectOrNilForKey:kGJZFBPayRContentSellerId fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.subject forKey:kGJZFBPayRContentSubject];
    [mutableDict setValue:self.body forKey:kGJZFBPayRContentBody];
    [mutableDict setValue:self.rsaPrivate forKey:kGJZFBPayRContentRsaPrivate];
    [mutableDict setValue:self.notifyUrl forKey:kGJZFBPayRContentNotifyUrl];
    [mutableDict setValue:self.inputCharset forKey:kGJZFBPayRContentInputCharset];
    [mutableDict setValue:self.paymentType forKey:kGJZFBPayRContentPaymentType];
    [mutableDict setValue:self.totalFee forKey:kGJZFBPayRContentTotalFee];
    [mutableDict setValue:self.itBPay forKey:kGJZFBPayRContentItBPay];
    [mutableDict setValue:self.partner forKey:kGJZFBPayRContentPartner];
    [mutableDict setValue:self.outTradeNo forKey:kGJZFBPayRContentOutTradeNo];
    [mutableDict setValue:self.service forKey:kGJZFBPayRContentService];
    [mutableDict setValue:self.signType forKey:kGJZFBPayRContentSignType];
    [mutableDict setValue:self.sellerId forKey:kGJZFBPayRContentSellerId];

    return [NSDictionary dictionaryWithDictionary:mutableDict];
}

- (NSString *)description 
{
    return [NSString stringWithFormat:@"%@", [self dictionaryRepresentation]];
}

#pragma mark - Helper Method
- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict
{
    id object = [dict objectForKey:aKey];
    return [object isEqual:[NSNull null]] ? nil : object;
}


#pragma mark - NSCoding Methods

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];

    self.subject = [aDecoder decodeObjectForKey:kGJZFBPayRContentSubject];
    self.body = [aDecoder decodeObjectForKey:kGJZFBPayRContentBody];
    self.rsaPrivate = [aDecoder decodeObjectForKey:kGJZFBPayRContentRsaPrivate];
    self.notifyUrl = [aDecoder decodeObjectForKey:kGJZFBPayRContentNotifyUrl];
    self.inputCharset = [aDecoder decodeObjectForKey:kGJZFBPayRContentInputCharset];
    self.paymentType = [aDecoder decodeObjectForKey:kGJZFBPayRContentPaymentType];
    self.totalFee = [aDecoder decodeObjectForKey:kGJZFBPayRContentTotalFee];
    self.itBPay = [aDecoder decodeObjectForKey:kGJZFBPayRContentItBPay];
    self.partner = [aDecoder decodeObjectForKey:kGJZFBPayRContentPartner];
    self.outTradeNo = [aDecoder decodeObjectForKey:kGJZFBPayRContentOutTradeNo];
    self.service = [aDecoder decodeObjectForKey:kGJZFBPayRContentService];
    self.signType = [aDecoder decodeObjectForKey:kGJZFBPayRContentSignType];
    self.sellerId = [aDecoder decodeObjectForKey:kGJZFBPayRContentSellerId];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_subject forKey:kGJZFBPayRContentSubject];
    [aCoder encodeObject:_body forKey:kGJZFBPayRContentBody];
    [aCoder encodeObject:_rsaPrivate forKey:kGJZFBPayRContentRsaPrivate];
    [aCoder encodeObject:_notifyUrl forKey:kGJZFBPayRContentNotifyUrl];
    [aCoder encodeObject:_inputCharset forKey:kGJZFBPayRContentInputCharset];
    [aCoder encodeObject:_paymentType forKey:kGJZFBPayRContentPaymentType];
    [aCoder encodeObject:_totalFee forKey:kGJZFBPayRContentTotalFee];
    [aCoder encodeObject:_itBPay forKey:kGJZFBPayRContentItBPay];
    [aCoder encodeObject:_partner forKey:kGJZFBPayRContentPartner];
    [aCoder encodeObject:_outTradeNo forKey:kGJZFBPayRContentOutTradeNo];
    [aCoder encodeObject:_service forKey:kGJZFBPayRContentService];
    [aCoder encodeObject:_signType forKey:kGJZFBPayRContentSignType];
    [aCoder encodeObject:_sellerId forKey:kGJZFBPayRContentSellerId];
}

- (id)copyWithZone:(NSZone *)zone
{
    ZFBPayRContent *copy = [[ZFBPayRContent alloc] init];
    
    if (copy) {

        copy.subject = [self.subject copyWithZone:zone];
        copy.body = [self.body copyWithZone:zone];
        copy.rsaPrivate = [self.rsaPrivate copyWithZone:zone];
        copy.notifyUrl = [self.notifyUrl copyWithZone:zone];
        copy.inputCharset = [self.inputCharset copyWithZone:zone];
        copy.paymentType = [self.paymentType copyWithZone:zone];
        copy.totalFee = [self.totalFee copyWithZone:zone];
        copy.itBPay = [self.itBPay copyWithZone:zone];
        copy.partner = [self.partner copyWithZone:zone];
        copy.outTradeNo = [self.outTradeNo copyWithZone:zone];
        copy.service = [self.service copyWithZone:zone];
        copy.signType = [self.signType copyWithZone:zone];
        copy.sellerId = [self.sellerId copyWithZone:zone];
    }
    
    return copy;
}


@end
