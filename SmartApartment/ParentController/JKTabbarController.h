//
//  JKTabbarController.h
//  SmartApartment
//
//  Created by Jimcky Lin on 2017/8/6.
//  Copyright © 2017年 Jimcky Lin. All rights reserved.
//

#import "LCTabBarController.h"
#import "HomeViewController.h"
#import "MineViewController.h"


@interface JKTabbarController : LCTabBarController

@property (nonatomic, strong) HomeViewController *homeVC;
@property (nonatomic, strong) MineViewController *mineVC;

@end
