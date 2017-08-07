//
//  UIViewController+NavBar.h
//  CWGJCarPark
//
//  Created by mutouren on 9/7/15.
//  Copyright (c) 2015 mutouren. All rights reserved.
//

#import <UIKit/UIKit.h>

#define BARHEIGHT 64.0f
#define PAG_Y 15.0f
#define MAIN_PAG_Y 0

@interface UIViewController (NavBar)


@property (nonatomic, strong) UIView *barView;

#pragma mark - 带标题的
- (UIView*)navBarWithTitle:(NSString*)title;

#pragma mark 主页面导航栏
- (UIView*)mainNavBarWithtitle:(NSString *)title RightImage:(UIImage*)rightImage leftImage:(UIImage*)leftImage  rightBtnSEL:(SEL)rightBtnSel leftBtnSEL:(SEL)leftBtnSel;

#pragma mark 带一个返回按钮的导航栏
- (UIView*)returnBtnNavBarWithTitle:(NSString*)title leftBtnSEL:(SEL)leftBtnSel;

#pragma mark 带一个右边按钮的导航栏
- (UIView*)rightBtnNavBarWithTitle:(NSString*)title rightBtnTitle:(NSString*)btnTitle rightBtnImage:(UIImage*)btnImage rightBtnSEL:(SEL)rightBtnSel;

#pragma mark 带一个返回按钮和右边按钮的导航栏
- (UIView*)returnBtnAndRightBtnNavBarWithTitle:(NSString*)title rightBtnTitle:(NSString*)btnTitle rightBtnImage:(UIImage*)btnImage leftBtnSEL:(SEL)leftBtnSel rightBtnSEL:(SEL)rightBtnSel;

#pragma mark 返回bar的高度
- (CGFloat)navBarHeight;

#pragma mark navBar 布局
- (void)navBarUpdateViewConstraints;

#pragma mark 主页面导航栏布局
- (void)mainNavBarUpdateViewConstraints;

#pragma mark 带一个返回按钮导航栏布局
- (void)returnBtnNavBarUpdateViewConstraints;

#pragma mark 带一个返回按钮和右边按钮的导航栏布局
- (void)returnBtnAndRightBtnNavBarUpdateViewConstraints;

#pragma mark 带一个右边按钮的导航栏布局
- (void)rightBtnNavBarUpdateViewConstraints;

#pragma mark 带标题布局
- (void)titleNavBarUpdateViewConstraints;

- (UILabel*)titleLabel;
- (UIButton*)rightBtn;
- (UIButton*)leftBtn;


@end
