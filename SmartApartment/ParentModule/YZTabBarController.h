//
//  YZTabBarController.h
//  CocoaPodsDemo
//
//  Created by Jimcky on 15/5/19.
//  Copyright (c) 2015年 Jimcky. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YZTabBarController : UITabBarController {
    
    NSMutableArray *imageViews;
    NSMutableArray *buttons;
    NSMutableArray *badgeNumLabels;
}

@property (nonatomic, assign) NSUInteger lastSelectedIndex;
@property (nonatomic, assign) NSUInteger currentSelectedIndex;
@property (nonatomic, strong) NSArray    *tabBarTitles;
@property (nonatomic, strong) NSArray    *tabBarImages;
@property (nonatomic, strong) NSArray    *tabBarSelectedImages;
@property (nonatomic, assign) BOOL showSeparateLines;

- (void)setIndex:(NSInteger)index badgeNum:(NSInteger)badgeNum;
- (void)clearBadgeNum:(NSInteger)index;

@end
