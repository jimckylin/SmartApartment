//
//  VerifyCode1LoginView.h
//  SmartApartment
//
//  Created by jimcky on 2017/8/31.
//  Copyright © 2017年 Jimcky Lin. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, VerifyCodeLoginAction) {
    
    VerifyCodeLoginActionGetVerifyCode,        // 获取验证码
    VerifyCodeLoginActionNormalLogin,          // 普通登录
    VerifyCodeLoginActionRegitster             // 立即注册
};

@protocol VerifyCode1LoginViewDelegate <NSObject>

- (void)verifyCode1LoginViewBtnClick:(NSString *)phone action:(VerifyCodeLoginAction)action;

@end

@interface VerifyCode1LoginView : UIView

@property (nonatomic, weak) id<VerifyCode1LoginViewDelegate> delegate;

@end
