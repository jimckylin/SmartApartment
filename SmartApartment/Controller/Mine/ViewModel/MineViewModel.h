//
//  MineViewModel.h
//  SmartApartment
//
//  Created by jimcky on 2017/9/6.
//  Copyright © 2017年 Jimcky Lin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MineViewModel : NSObject

@property (nonatomic, strong) NSArray *contacList;    // 联系人列表
@property (nonatomic, strong) NSArray *consumeList;   // 消费列表
@property (nonatomic, strong) NSArray *rechargeList;  // 充值列表
@property (nonatomic, strong) NSArray *moneyList;     // 充值价位信息列表


/* 我的钱包
 */
- (void)requestGetMyWallet:(void(^)(NSArray *))complete;

/* 获取优惠券
 */
- (void)requestGetCoupon:(NSString *)roomTypeId storeId:(NSString *)storeId complete:(void(^)(NSArray *))complete;

/* 获取账户绑定的常用联系人
 */
- (void)requestQueryCommonInfo:(void(^)(NSArray *))complete;

/* 常用联系人信息（增改）
 * @param name 姓名
 * @param idType 证件类型：0-身份证，1-学生证，2-其他证件
 * @param idNo 证件号
 * @param mobilePhone 手机号码
 * @param email 邮箱
 * @param checkInNo 入住人编号，唯一标识，新增操作此列值为空
 */
- (void)requestSaveCommonInfo:(NSString *)name
                       idType:(NSString *)idType
                         idNo:(NSString *)idNo
                  mobilePhone:(NSString *)mobilePhone
                        email:(NSString *)email
                    checkInNo:(NSString *)checkInNo
                     complete:(void(^)(BOOL isSuccess))complete;


/* 消费明细
 */
- (void)requestCardConsumeDetail:(void(^)(NSArray *))complete;

/* 充值明细
 */
- (void)requestCardRechargeDetail:(void(^)(NSArray *))complete;

/* 充值价位
 */
- (void)requestRechargePrice:(void(^)(NSArray *))complete;

/* 立即充值
 */
- (void)requestWalletRecharge:(NSString *)payWay rechargeId:(NSString *)rechargerId complete:(void(^)(NSDictionary *))complete;

@end
