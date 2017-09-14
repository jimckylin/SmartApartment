//
//  ParentViewController.h
//  Fashion
//
//  Created by Newbie on 14-11-6.
//  Copyright (c) 2014年 com.newbie.circle. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kTopNaviHeight  64

typedef enum{
    
    kNavButtonTag1 = 888,
    kNavButtonTag2
} NavButtonTag;

@interface ParentViewController : UIViewController
{
    UIView      *_naviView;
    UIButton    *_naviBackBtn;
    UILabel     *_naviLabel;
    UIView      *_naviBgView;
}

- (void)backClick:(id)sender;
- (void)hideBackBtn;

-(void)addRightNaviButton:(NSString*)title action:(SEL)action;
- (void)addRightNaviButton:(NSString *)title actionBlock:(void (^)())actionBlcok;

-(void)addRightNaviButton:(UIImage *)image highlight:(UIImage *)highlight action:(SEL)action;
- (void)addRightNaviButton:(UIImage *)image highlight:(UIImage *)highlight actionBlock:(void (^)())actionBlcok;
-(void)addRightNaviButtons:(NSArray *)images highlights:(NSArray *)highlights action:(SEL)action;
-(void)addRightNaviButtons:(NSArray *)images highlights:(NSArray *)highlights action:(SEL)action buttonSpacing:(CGFloat)spacing;

- (void)pushControllerWithName:(NSString *)controllerName properties:(NSDictionary *)properties;
- (void)pushControllerWithClass:(Class)controllerClass properties:(NSDictionary *)properties;

// 测试是否登录 没有则跳转登录
@property (nonatomic, assign) BOOL checkIsLogin;

@end
