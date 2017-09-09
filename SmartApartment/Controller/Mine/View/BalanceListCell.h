//
//  BalanceListCell.h
//  SmartApartment
//
//  Created by Jimcky Lin on 2017/8/24.
//  Copyright © 2017年 Jimcky Lin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BalanceListCell : UITableViewCell

@property (nonatomic, strong) NSDictionary *consumeDict;   // 消费列表
@property (nonatomic, strong) NSDictionary *rechargeDict;  // 充值列表

@end
