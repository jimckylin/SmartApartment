//
//  CZDLoginView.h
//  CWGJCarOwner
//
//  Created by jimcky on 2017/7/18.
//  Copyright © 2017年 CheWeiGuanJia. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, CZDLoginAction) {
    
    CZDLoginActionLogin,                      // 登录操作
    CZDLoginActionViewPassword,               // 检查密码
    
    CZDLoginActionVerifyCodeLoginJump,        // 短信验证码
    CZDLoginActionForgotPwd,                  // 忘记密码操作
    CZDLoginActionRegister,                   // 注册操作
};


@protocol CZDLoginViewDelegate <NSObject>

- (void)loginViewDidClickBtnAction:(CZDLoginAction)action param:(NSDictionary *)param;

@end


@interface LoginView : UIView

@property (nonatomic, weak) id<CZDLoginViewDelegate> delegate;

- (void)phoneTextFieldBecomeFirstResponse;

@end
