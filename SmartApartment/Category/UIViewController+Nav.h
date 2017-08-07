//
//  UIViewController+Nav.h
//  CarFriend
//
//  Created by mac on 15/11/11.
//  Copyright © 2015年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol UIViewControllerNavProtocol <NSObject>

@optional

//左边按钮回调
- (void)leftBtnClick;

//右边返回按钮回调
- (void)rightBtnClick;

@end

@interface UIViewController (Nav)

@property (nonatomic, strong) UINavigationBar *customNavBar;

@property (nonatomic, strong) UINavigationItem *customNavItem;

- (void)setCustomLeftBtn:(UIButton *)lBtn Title:(NSString *)title;

- (void)addNavigationBar;

- (void)setMiddleTitle:(NSString*)title;

- (void)setRightNavBtn:(NSString*)title;

- (void)setRightNavBtnWithImg:(NSString *)img;

- (void)setDefaultLeftBtn;

- (void)setRightNavBtn:(NSString*)title titleColor:(UIColor *)color;

- (void)setDefaultLeftBtnAndTitle:(NSString *)title;

- (void)setDefaultLeftBtnAndTitle:(NSString *)title right:(NSString *)title;

- (void)setDefaultNavTitle:(NSString *)title rightBtnTitle:(NSString *)rightTitle;

@end
