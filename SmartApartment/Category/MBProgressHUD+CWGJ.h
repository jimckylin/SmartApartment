//
//  MBProgressHUD+CWGJ.h
//  CWGJCarOwner
//
//  Created by renxinwei on 2017/5/8.
//  Copyright © 2017年 CheWeiGuanJia. All rights reserved.
//

#import "MBProgressHUD.h"

@interface MBProgressHUD (CWGJ)

+ (void)cwgj_showProgressHUDWithText:(NSString *)text;
+ (void)cwgj_showProgressHUDWithText:(NSString *)text clear:(BOOL)clear;    // clear:是否禁止交互
+ (void)cwgj_showHUDWithText:(NSString *)text;
+ (void)cwgj_hideHUD;

@end
