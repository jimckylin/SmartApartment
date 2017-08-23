//
//  GJWXPayRContent.m
//
//  Created by   on 15/6/2
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "WXPayRContent.h"


NSString *const kGJWXPayRContentAppkey = @"appkey";
NSString *const kGJWXPayRContentPackagevalue = @"packagevalue";
NSString *const kGJWXPayRContentPartnerid = @"partnerid";
NSString *const kGJWXPayRContentAppid = @"appid";
NSString *const kGJWXPayRContentNoncestr = @"noncestr";
NSString *const kGJWXPayRContentTimestamp = @"timestamp";
NSString *const kGJWXPayRContentPrepayid = @"prepayid";
NSString *const kGJWXPayRContentSign = @"sign";


@interface WXPayRContent ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation WXPayRContent

@synthesize appkey = _appkey;
@synthesize packagevalue = _packagevalue;
@synthesize partnerid = _partnerid;
@synthesize appid = _appid;
@synthesize noncestr = _noncestr;
@synthesize timestamp = _timestamp;
@synthesize prepayid = _prepayid;
@synthesize sign = _sign;


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
            self.appkey = [self objectOrNilForKey:kGJWXPayRContentAppkey fromDictionary:dict];
            self.packagevalue = [self objectOrNilForKey:kGJWXPayRContentPackagevalue fromDictionary:dict];
            self.partnerid = [self objectOrNilForKey:kGJWXPayRContentPartnerid fromDictionary:dict];
            self.appid = [self objectOrNilForKey:kGJWXPayRContentAppid fromDictionary:dict];
            self.noncestr = [self objectOrNilForKey:kGJWXPayRContentNoncestr fromDictionary:dict];
            self.timestamp = [self objectOrNilForKey:kGJWXPayRContentTimestamp fromDictionary:dict];
            self.prepayid = [self objectOrNilForKey:kGJWXPayRContentPrepayid fromDictionary:dict];
            self.sign = [self objectOrNilForKey:kGJWXPayRContentSign fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.appkey forKey:kGJWXPayRContentAppkey];
    [mutableDict setValue:self.packagevalue forKey:kGJWXPayRContentPackagevalue];
    [mutableDict setValue:self.partnerid forKey:kGJWXPayRContentPartnerid];
    [mutableDict setValue:self.appid forKey:kGJWXPayRContentAppid];
    [mutableDict setValue:self.noncestr forKey:kGJWXPayRContentNoncestr];
    [mutableDict setValue:self.timestamp forKey:kGJWXPayRContentTimestamp];
    [mutableDict setValue:self.prepayid forKey:kGJWXPayRContentPrepayid];
    [mutableDict setValue:self.sign forKey:kGJWXPayRContentSign];

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

    self.appkey = [aDecoder decodeObjectForKey:kGJWXPayRContentAppkey];
    self.packagevalue = [aDecoder decodeObjectForKey:kGJWXPayRContentPackagevalue];
    self.partnerid = [aDecoder decodeObjectForKey:kGJWXPayRContentPartnerid];
    self.appid = [aDecoder decodeObjectForKey:kGJWXPayRContentAppid];
    self.noncestr = [aDecoder decodeObjectForKey:kGJWXPayRContentNoncestr];
    self.timestamp = [aDecoder decodeObjectForKey:kGJWXPayRContentTimestamp];
    self.prepayid = [aDecoder decodeObjectForKey:kGJWXPayRContentPrepayid];
    self.sign = [aDecoder decodeObjectForKey:kGJWXPayRContentSign];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_appkey forKey:kGJWXPayRContentAppkey];
    [aCoder encodeObject:_packagevalue forKey:kGJWXPayRContentPackagevalue];
    [aCoder encodeObject:_partnerid forKey:kGJWXPayRContentPartnerid];
    [aCoder encodeObject:_appid forKey:kGJWXPayRContentAppid];
    [aCoder encodeObject:_noncestr forKey:kGJWXPayRContentNoncestr];
    [aCoder encodeObject:_timestamp forKey:kGJWXPayRContentTimestamp];
    [aCoder encodeObject:_prepayid forKey:kGJWXPayRContentPrepayid];
    [aCoder encodeObject:_sign forKey:kGJWXPayRContentSign];
}

- (id)copyWithZone:(NSZone *)zone
{
    WXPayRContent *copy = [[WXPayRContent alloc] init];
    
    if (copy) {

        copy.appkey = [self.appkey copyWithZone:zone];
        copy.packagevalue = [self.packagevalue copyWithZone:zone];
        copy.partnerid = [self.partnerid copyWithZone:zone];
        copy.appid = [self.appid copyWithZone:zone];
        copy.noncestr = [self.noncestr copyWithZone:zone];
        copy.timestamp = [self.timestamp copyWithZone:zone];
        copy.prepayid = [self.prepayid copyWithZone:zone];
        copy.sign = [self.sign copyWithZone:zone];
    }
    
    return copy;
}


@end
