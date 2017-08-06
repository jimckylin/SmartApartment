//
//  JKTabbarController.m
//  SmartApartment
//
//  Created by Jimcky Lin on 2017/8/6.
//  Copyright © 2017年 Jimcky Lin. All rights reserved.
//

#import "JKTabbarController.h"

@interface JKTabbarController ()

@end

@implementation JKTabbarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _homeVC = [HomeViewController new];
    _homeVC.view.backgroundColor = [UIColor whiteColor];
    _homeVC.tabBarItem.image = [UIImage imageNamed:@"home_tab_home_ic~iphone"];
    _homeVC.tabBarItem.selectedImage = [UIImage imageNamed:@"home_tab_home_ic_s~iphone"];
    
    _mineVC = [MineViewController new];
    _mineVC.view.backgroundColor = [UIColor whiteColor];
    _mineVC.tabBarItem.image = [UIImage imageNamed:@"home_tab_mine_ic~iphone"];
    _mineVC.tabBarItem.selectedImage = [UIImage imageNamed:@"home_tab_mine_ic_s~iphone"];
    
    self.viewControllers = @[_homeVC, _mineVC];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
