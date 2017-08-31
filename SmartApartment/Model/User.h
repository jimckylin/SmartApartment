//
//  User.h
//  SmartApartment
//
//  Created by jimcky on 2017/8/31.
//  Copyright © 2017年 Jimcky Lin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject

@property(nonatomic, copy) NSString *headImage;       // 头像,是URL地址
@property(nonatomic, copy) NSString *birthdate;       // 出生日期

@property(nonatomic, copy) NSString *cardMoney;       // 账户总金额
@property(nonatomic, copy) NSString *giveMoney;       // 赠送金额
@property(nonatomic, copy) NSString *pechargeMoney;   // 充值金额
@property(nonatomic, copy) NSString *cardNo;          // 卡号
@property(nonatomic, copy) NSString *couponNum;       // 优惠券个数
@property(nonatomic, copy) NSString *cardIntegral;    // 积分
@property(nonatomic, copy) NSString *cardLevel;       // 会员等级(0001-金卡，0002-银卡，0003-普卡)

@property(nonatomic, copy) NSString *mobilePhone;     // 手机号码
@property(nonatomic, copy) NSString *name;            // 姓名

@property(nonatomic, copy) NSString *idType;          // 证件类型：0-身份证，1-学生证，2-其他证件
@property(nonatomic, copy) NSString *idNo;            // 身份证
@property(nonatomic, copy) NSString *email;           // 邮箱
@property(nonatomic, copy) NSString *token;           // token唯一标识，用于验证登录状态是否超时

@end
