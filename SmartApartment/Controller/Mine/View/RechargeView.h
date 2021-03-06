//
//  RechargeView.h
//  SmartApartment
//
//  Created by Jimcky Lin on 2017/8/25.
//  Copyright © 2017年 Jimcky Lin. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol RechargeViewDelegate <NSObject>

- (void)rechargeViewDidClickRechargeBtn:(NSString *)payType rechargeDic:(NSDictionary *)rechargeDic;

@end


@interface RechargeView : UIView

@property (nonatomic, strong) NSArray *moneyList;     // 充值价位信息列表
@property (nonatomic, weak) id <RechargeViewDelegate> delegate;

@end
