//
//  MBProgressHUD+CWGJ.m
//  CWGJCarOwner
//
//  Created by renxinwei on 2017/5/8.
//  Copyright © 2017年 CheWeiGuanJia. All rights reserved.
//

#import "MBProgressHUD+CWGJ.h"
#import "MBProgressHUD+gjMB.h"
#import "UIViewController+CWGJ.h"

@implementation MBProgressHUD (CWGJ)

+ (void)cwgj_showProgressHUDWithText:(NSString *)text {
    [self cwgj_showProgressHUDWithText:text clear:NO];
}

+ (void)cwgj_showProgressHUDWithText:(NSString *)text clear:(BOOL)clear {
    [MBProgressHUD showProgressHUDWithText:text view:[UIViewController currentViewControlloer].view clear:clear];
}

+ (void)cwgj_showHUDWithText:(NSString *)text {
   [MBProgressHUD showHUDWithText:text view:[UIViewController currentViewControlloer].view];
}

+ (void)cwgj_hideHUD {
    [MBProgressHUD hideHUDForView:[UIViewController currentViewControlloer].view animated:YES];
}



@end
