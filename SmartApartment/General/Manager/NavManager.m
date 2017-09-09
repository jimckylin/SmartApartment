//
//  NavManager.m
//  NavManager
//
//  Created by suyushen on 14-10-14.
//  Copyright (c) 2014年 suyushen. All rights reserved.
//

#import "NavManager.h"
#import "RootTabBarController.h"
#import "LoginViewController.h"
#import "AppDelegate.h"

@interface NavManager ()

@property (nonatomic, strong) UINavigationController *navigationCtr;

@end

@implementation NavManager


-(id)init {
    self = [super init];
    if (self) {
        
    }
    return self;
}


//share Instance of ViewManager
+ (NavManager *)shareInstance {
    static NavManager *instance = nil;
    static dispatch_once_t once;
    dispatch_once(&once, ^ { instance = [[NavManager alloc] init]; });
    return instance;
}

- (UINavigationController *)navigationCtr {
    NSAssert(_navigationCtr, @"navigationCtr can not be nil, please set root controller!");
    return _navigationCtr;
}

- (void)setLoginRootController {
    
    UIViewController *vc = [LoginViewController new];
    [self setRootController:vc];
    
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    window.rootViewController = [self rootNavigationController];
}

- (void)setHomeRootController {
    
    UIViewController *vc = [RootTabBarController new];
    [self setRootController:vc];
    
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    window.rootViewController = [self rootNavigationController];
}

- (void)setRootController:(UIViewController*)controller {
//    NSAssert(!_navigationCtr, @"can not set root controller again!");
    
    _navigationCtr = [[UINavigationController alloc] initWithRootViewController:controller];
    _navigationCtr.navigationBarHidden = YES;
    _navigationCtr.interactivePopGestureRecognizer.delegate = (id)self;
}

- (void)setNavController:(UINavigationController *)navController {
    _navigationCtr = navController;
    _navigationCtr.navigationBarHidden = YES;
}

- (void)showViewController:(UIViewController*)controller isAnimated:(BOOL)isAnimated {
    if (![self.curViewController isKindOfClass:[controller class]])
    [self.navigationCtr pushViewController:controller animated:isAnimated];
}


- (void)returnToFrontView:(BOOL)isAnimated {
    [self.navigationCtr popViewControllerAnimated:isAnimated];
}

- (void)returnToLoginView:(BOOL)isAnimated {
    
    __block BOOL exsitLoginVC = NO;
    [[self rootNavigationController].viewControllers enumerateObjectsUsingBlock:^(UIViewController *vc,NSUInteger idx, BOOL *stop){
        if ([vc isKindOfClass:NSClassFromString(@"LoginViewController")]) {
            [[self rootNavigationController] popToViewController:vc animated:isAnimated];
            exsitLoginVC = YES;
            *stop = YES;
        }
    }];
    if (!exsitLoginVC) {
        LoginViewController *vc = [LoginViewController new];
        [self showViewController:vc isAnimated:YES];
    }
}

- (void)returnToMainView:(BOOL)isAnimated {
    [[self rootNavigationController].viewControllers enumerateObjectsUsingBlock:^(UIViewController *vc,NSUInteger idx, BOOL *stop){
        if ([vc isKindOfClass:NSClassFromString(@"RootTabBarController")]) {  //主页的Class为XTSideMenu !!
            [[self rootNavigationController] popToViewController:vc animated:isAnimated];
            *stop = YES;
        }
    }];
}

- (void)goToMainVC {
    [self returnToMainView:NO];
}

- (void)goToTabbarHome {
    
    [[self rootNavigationController].viewControllers enumerateObjectsUsingBlock:^(UIViewController *vc,NSUInteger idx, BOOL *stop){
        if ([vc isKindOfClass:NSClassFromString(@"RootTabBarController")]) {
            RootTabBarController *tabbar = (RootTabBarController*)vc;
            [tabbar setSelectedIndex:0];
            *stop = YES;
        }
    }];
}

- (UIViewController*)getMainViewController {
    __block UIViewController *mainVc = nil;
    [[self rootNavigationController].viewControllers enumerateObjectsUsingBlock:^(UIViewController *vc,NSUInteger idx, BOOL *stop){
        if ([vc isKindOfClass:NSClassFromString(@"RootTabBarController")]) {  //主页的Class为JKTabbarController !!
            mainVc = vc;
            *stop = YES;
        }
    }];
    return mainVc;
}

#pragma mark 返回当前显示controller
- (UIViewController*)curViewController {
    return self.navigationCtr.visibleViewController;
}

- (UINavigationController*)rootNavigationController {
    return self.navigationCtr;
}

- (UINavigationController*)getCurNavigationController {
    return self.navigationCtr;
}

@end
