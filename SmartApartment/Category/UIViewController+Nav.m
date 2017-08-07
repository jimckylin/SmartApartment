//
//  UIViewController+Nav.m
//  CarFriend
//
//  Created by mac on 15/11/11.
//  Copyright © 2015年 mac. All rights reserved.
//

#import "UIViewController+Nav.h"
#import "PureLayout.h"
#import <objc/runtime.h>
#import <objc/message.h>

@implementation UIViewController (Nav)

- (void)setCustomNavBar:(UINavigationBar *)customNavBar
{
    objc_setAssociatedObject(self, @selector(customNavBar), customNavBar, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UINavigationBar *)customNavBar
{
    return objc_getAssociatedObject(self, @selector(customNavBar));
}

- (void)setCustomNavItem:(UINavigationItem *)customNavItem
{
    objc_setAssociatedObject(self, @selector(customNavItem), customNavItem, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UINavigationItem *)customNavItem
{
    return objc_getAssociatedObject(self, @selector(customNavItem));
}

- (void)addNavigationBar
{
    UINavigationBar *navBar = [[UINavigationBar alloc] init];
    navBar.backgroundColor = [UIColor whiteColor];
    navBar.barStyle = UIBarStyleDefault;
    navBar.translucent = YES;
    navBar.barTintColor = [UIColor whiteColor];
    [self.view addSubview:navBar];
    self.customNavBar = navBar;
    [navBar autoPinEdgeToSuperviewEdge:ALEdgeTop];
    [navBar autoPinEdgeToSuperviewEdge:ALEdgeLeading];
    [navBar autoPinEdgeToSuperviewEdge:ALEdgeTrailing];
    [navBar autoSetDimension:ALDimensionHeight toSize:64];
    
    UINavigationItem *navItem = [[UINavigationItem alloc] initWithTitle:@""];
    [self.customNavBar pushNavigationItem:navItem animated:NO];
    self.customNavItem = navItem;
}

- (void)setMiddleTitle:(NSString*)title
{
    self.customNavItem.title = title;
}

- (void)setRightNavBtn:(NSString*)title
{
    UIBarButtonItem* editItem = [[UIBarButtonItem alloc] initWithTitle:title style:UIBarButtonItemStylePlain target:self action:@selector(rightBtnClick)];
    self.customNavItem.rightBarButtonItem = editItem;
}

- (void)setRightNavBtn:(NSString*)title titleColor:(UIColor *)color
{
//    UIBarButtonItem* editItem = [[UIBarButtonItem alloc] initWithTitle:title style:UIBarButtonItemStylePlain target:self action:@selector(rightBtnClick)];
    
    UIButton *rBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [rBtn setTitle:title forState:UIControlStateNormal];
    [rBtn setTitleColor:color forState:UIControlStateNormal];
    rBtn.frame = [self returnLeftBtnFrame];
    [rBtn addTarget:self action:@selector(rightBtnClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *editItem = [[UIBarButtonItem alloc] initWithCustomView:rBtn];
    self.customNavItem.rightBarButtonItem = editItem;
}

- (void)setRightNavBtnWithImg:(NSString *)img
{
//    UIBarButtonItem* editItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:img] style:UIBarButtonItemStylePlain target:self action:@selector(rightBtnClick)];
    
    UIButton *rBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [rBtn setImage:[UIImage imageNamed:img] forState:UIControlStateNormal];
    rBtn.frame = [self returnLeftBtnFrame];
    [rBtn addTarget:self action:@selector(rightBtnClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *editItem = [[UIBarButtonItem alloc] initWithCustomView:rBtn];
    
    self.customNavItem.rightBarButtonItem = editItem;
}


- (void)setCustomLeftBtn:(UIButton *)lBtn Title:(NSString *)title
{
    [self addNavigationBar];
//    [lBtn setFrame:[self returnLeftBtnFrame]];
    [self setMiddleTitle:title];
    [self setDefaultLeftBtnTarget:lBtn];
}

- (CGRect)returnLeftBtnFrame
{
    return CGRectMake(0, 0, 44, 44);
}

- (void)setDefaultLeftBtn
{
    UIImage* backImg = [UIImage imageNamed:@"nav_back.png"];
    
    UIButton* backBtn = [[UIButton alloc] init];
    [backBtn setImage:backImg forState:UIControlStateNormal];
    [backBtn setFrame:[self returnLeftBtnFrame]];
    [backBtn setImageEdgeInsets:UIEdgeInsetsMake(0, -20, 0, 0)];
    
    [self setDefaultLeftBtnTarget:backBtn];
}

- (void)setDefaultLeftBtnTarget:(UIButton *)lbtn
{
    if ([self respondsToSelector:@selector(leftBtnClick)]) {
        [lbtn addTarget:self action:@selector(leftBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    else {
        [lbtn addTarget:self action:@selector(defaultBackBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    
    UIBarButtonItem* backItem = [[UIBarButtonItem alloc] initWithCustomView:lbtn];
  
    self.customNavItem.leftBarButtonItem = backItem;
}

- (void)setDefaultLeftBtnAndTitle:(NSString *)title
{
    [self addNavigationBar];
    [self setDefaultLeftBtn];
    [self setMiddleTitle:title];
}

- (void)setDefaultLeftBtnAndTitle:(NSString *)title right:(NSString *)right
{
    [self setDefaultLeftBtnAndTitle:title];
    [self setRightNavBtn:right];
}

- (void)setDefaultNavTitle:(NSString *)title rightBtnTitle:(NSString *)rightTitle
{
    [self addNavigationBar];
    [self setMiddleTitle:title];
    [self setRightNavBtn:rightTitle];
}

//默认返回按钮响应
- (void)defaultBackBtnClick
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
