//
//  YouthTabBarController.m
//  Youth
//
//  Created by Jimcky on 15/5/19.
//  Copyright (c) 2015年 Fujian Wisdom Cloud Technology Co.,Ltd. All rights reserved.
//

#import "RootTabBarController.h"
#import "PageControlView.h"

#define LeftViewWidth 175.0     //(kScreenWidth * 2.0 / 3.0)

@interface RootTabBarController ()

@end

@implementation RootTabBarController {
    UIImageView *_avatarView;
    
    UILabel *_nameLabel;
    UILabel *_occupationLabel;
    UILabel *_placeLabel;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.showSeparateLines = YES;
    
    _homeVC = [HomeViewController new];
    _homeVC.view.backgroundColor = [UIColor whiteColor];

    _mineVC = [MineViewController new];
    _mineVC.view.backgroundColor = [UIColor whiteColor];
    
    _actVC = [ActivityViewController new];
    _homeVC.view.backgroundColor = [UIColor whiteColor];
    
    _tripVC = [TripHelperViewController new];
    _mineVC.view.backgroundColor = [UIColor whiteColor];

    
    self.tabBarImages = @[@"home_tab_home_ic~iphone",
                          @"home_tab_activity_ic~iphone",
                          @"home_tab_trip_ic~iphone",
                          @"home_tab_mine_ic~iphone"];
    
    self.tabBarSelectedImages = @[@"home_tab_home_ic_s~iphone",
                                  @"home_tab_ctivity_ic_s~iphone",
                                  @"home_tab_trip_ic_s~iphone",
                                  @"home_tab_mine_ic_s~iphone"];
    
    

    self.viewControllers = @[_homeVC, _actVC, _tripVC, _mineVC];
    self.selectedIndex = 0;
    
    // 设置角标
//    [self setIndex:2 badgeNum:arc4random_uniform(20)];
    
    
    if(![[NSUserDefaults standardUserDefaults] objectForKey:@"isFirstInstall"]) {
        [[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:@"isFirstInstall"];
        [self addGuide];
    }
}

- (void)addGuide {
    
    NSArray *imgs = @[@"loading_1", @"loading_2", @"loading_3", @"loading_4", @"loading_5"];
    PageControlView *pageControlV = [[PageControlView instance] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) andImageList:imgs];
    [self.view addSubview:pageControlV];
}


@end
