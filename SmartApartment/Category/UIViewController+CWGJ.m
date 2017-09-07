//
//  UIViewController+CWGJ.m
//  CWGJCarOwner
//
//  Created by renxinwei on 2017/7/5.
//  Copyright © 2017年 CheWeiGuanJia. All rights reserved.
//

#import "UIViewController+CWGJ.h"

@implementation UIViewController (CWGJ)

+ (UIViewController *)currentViewControlloer {
    UIViewController *rootViewController = [UIApplication sharedApplication].keyWindow.rootViewController;
    return [self getVisibleViewControllerFrom:rootViewController];
}

+ (UIViewController *)getVisibleViewControllerFrom:(UIViewController *)vc {
    if ([vc isKindOfClass:[UINavigationController class]]) {
        return [self getVisibleViewControllerFrom:[((UINavigationController *)vc) visibleViewController]];
    } else {
        if (vc.presentedViewController) {
            return [self getVisibleViewControllerFrom:vc.presentedViewController];
        } else {
            return vc;
        }
    }
//    else if ([vc isKindOfClass:[UITabBarController class]]) {
//        return [self getVisibleViewControllerFrom:[((UITabBarController *)vc) selectedViewController]];
//    }
}

@end
