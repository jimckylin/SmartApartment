//
//  NavManager.h
//  NavManager
//
//  Created by suyushen on 14-10-14.
//  Copyright (c) 2014年 suyushen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@interface NavManager : NSObject{
}

//share Instance of NavManager
+ (NavManager *)shareInstance;

- (void)goToMainVC;
- (void)goToTabbarHome;

- (void)setLoginRootController;
- (void)setHomeRootController;
- (void)setRootController:(UIViewController*)controller;

- (void)showViewController:(UIViewController*)controller isAnimated:(BOOL)isAnimated;     //默认使用ControllerShowModePush

- (void)returnToFrontView:(BOOL)isAnimated;

- (void)returnToLoginView:(BOOL)isAnimated;

- (void)returnToMainView:(BOOL)isAnimated;

- (UIViewController*)getMainViewController;

- (UINavigationController*)rootNavigationController;

#pragma mark 返回当前显示controller
- (UIViewController*)curViewController;

- (void)setNavController:(UINavigationController *)navController;

@end
