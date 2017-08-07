//
//  YZTabBarController.m
//  CocoaPodsDemo
//
//  Created by Jimcky on 15/5/19.
//  Copyright (c) 2015年 Jimcky. All rights reserved.
//

#import "YZTabBarController.h"
#import "Macro.h"

#define MAX_Tabs 4

@interface YZTabBarController () {
    
    
}

@end

@implementation YZTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    UIImage *tabBarImage = [UIImage imageNamed:@"line_nav_bg"];
//    tabBarImage = [CommonUse resizeImageWithCapInsets:UIEdgeInsetsMake(4, 0, 0, 0) withImage:tabBarImage];
    
    UIImageView *tabBarBgView = [[UIImageView alloc]initWithFrame:CGRectMake(0,
                                                                             self.tabBar.frame.origin.y,
                                                                             kScreenWidth,
                                                                             self.tabBar.frame.size.height)];
//    tabBarBgView.image = tabBarImage;
    tabBarBgView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:tabBarBgView];
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 0.5)];
    line.backgroundColor = [UIColor lightGrayColor];
    [tabBarBgView addSubview:line];
    
    NSUInteger viewCount = MAX_Tabs;
    imageViews = [NSMutableArray arrayWithCapacity:viewCount];
    buttons    = [NSMutableArray arrayWithCapacity:viewCount];
    badgeNumLabels = [NSMutableArray arrayWithCapacity:viewCount];
    
    double _width = kScreenWidth / viewCount;
    double _height = self.tabBar.frame.size.height;
    
    for (int i = 0; i < viewCount; i++) {
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.frame = CGRectMake(i*_width,self.tabBar.frame.origin.y, _width, _height);
        imageView.contentMode = UIViewContentModeCenter;
        [self.view addSubview:imageView];
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(i*_width,self.tabBar.frame.origin.y, _width + 1.0, _height);
        [btn addTarget:self action:@selector(selectedTab:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag = i;
        [self.view  addSubview:btn];
        
        UILabel *badgeNum = [[UILabel alloc] init];
        badgeNum.frame = CGRectMake(i*_width + _width/2+10, self.tabBar.frame.origin.y+5, 20, 20);
        badgeNum.backgroundColor = [UIColor colorWithRed:0.970 green:0.419 blue:0.321 alpha:1.000];
        badgeNum.textColor = [UIColor whiteColor];
        badgeNum.textAlignment = NSTextAlignmentCenter;
        badgeNum.font = [UIFont systemFontOfSize:12.f];
        badgeNum.layer.masksToBounds = YES;
        badgeNum.layer.cornerRadius = 10;
        badgeNum.hidden = YES;
        [self.view addSubview:badgeNum];
        
        [imageViews addObject:imageView];
        [buttons addObject:btn];
        [badgeNumLabels addObject:badgeNum];
    }
}


#pragma mark - Private Method

- (void)selectedTab:(UIButton *)button {
    if (self.currentSelectedIndex == button.tag) {
        return;
    }
    [self stateChanged:button.tag];
}

- (void)stateChanged:(NSInteger)selectedIndex {
    for (int index = 0; index < MAX_Tabs; index ++) {
        UIImageView *imageView = imageViews[index];
        UIButton *btn          = buttons[index];
        
        if (selectedIndex == index) {
            [imageView setHighlighted:YES];
            [btn       setSelected:YES];
        }else
        {
            [imageView setHighlighted:NO];
            [btn       setSelected:NO];
        }
    }
    if (self.currentSelectedIndex != 3) {
        self.lastSelectedIndex = self.currentSelectedIndex;
    }
    self.currentSelectedIndex = selectedIndex;
    [self setSelectedViewController:self.viewControllers[selectedIndex]];
}

- (void)hideRealTabBar {
    for(UIView *view in self.view.subviews){
        if([view isKindOfClass:[UITabBar class]]){
            view.hidden = YES;
            break;
        }
    }
}

- (void)setIndex:(NSInteger)index badgeNum:(NSInteger)badgeNum {
    if (index >= badgeNumLabels.count) {
        return;
    }
    UILabel *label = badgeNumLabels[index];
    label.hidden = NO;
    label.text = [NSString stringWithFormat:@"%ld", badgeNum];
}

- (void)clearBadgeNum:(NSInteger)index {
    UILabel *label = badgeNumLabels[index];
    label.hidden = YES;
    label.text = nil;
}


#pragma mark - Setter

- (void)setTabBarTitles:(NSArray *)tabBarTitles {
    _tabBarTitles = tabBarTitles;
    
    for (int index = 0; index < MAX_Tabs; index ++)
    {
        UIButton *btn = buttons[index];
        
        [btn setTitle:tabBarTitles[index] forState:UIControlStateNormal];
        [btn.titleLabel setFont:[UIFont systemFontOfSize:12]];
        [btn setTitleColor:[UIColor colorWithWhite:0.505 alpha:1.000] forState:UIControlStateNormal];
        [btn setTitleColor:ThemeColor forState:UIControlStateSelected];
        btn.contentVerticalAlignment = UIControlContentVerticalAlignmentBottom;
    }
}

- (void)setTabBarImages:(NSArray *)tabBarImages {
    _tabBarImages = tabBarImages;
    
    for (int index = 0; index < MAX_Tabs; index ++) {
        UIImageView *imageView = imageViews[index];
        [imageView setImage:[UIImage imageNamed:tabBarImages[index]]];
    }
}

- (void)setTabBarSelectedImages:(NSArray *)tabBarSelectedImages {
    _tabBarSelectedImages = tabBarSelectedImages;
    
    for (int index = 0; index < MAX_Tabs; index ++) {
        UIImageView *imageView = imageViews[index];
        [imageView setHighlightedImage:[UIImage imageNamed:tabBarSelectedImages[index]]];
    }
}


#pragma mark - override
- (void)setSelectedIndex:(NSUInteger)selectedIndex {
    [self stateChanged:selectedIndex];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
