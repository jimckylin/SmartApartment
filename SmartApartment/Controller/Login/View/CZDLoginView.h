//
//  CZDLoginView.h
//  CWGJCarOwner
//
//  Created by jimcky on 2017/7/18.
//  Copyright © 2017年 CheWeiGuanJia. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, CZDLoginAction) {
    
    CZDLoginActionVerifyCodeSend,             // 短信验证码
    CZDLoginActionVoiceVerifyCodeSend,        // 语音验证码
    CZDLoginActionLogin,                      // 登录操作
    
    CZDLoginActionWXOAuthVerifyCodeSend,      // 微信登录短信验证码
    CZDLoginActionWXOAuthVoiceVerifyCodeSend, // 微信登录语音验证码
    CZDLoginActionWXOAuthLogin,               // 微信登录
    CZDLoginActionProtocol                    // 注册协议
};


@protocol CZDLoginViewDelegate <NSObject>

- (void)loginViewDidClickBtnAction:(CZDLoginAction)action param:(NSDictionary *)param;

@end


@interface CZDLoginView : UIView

@property (nonatomic, weak) id<CZDLoginViewDelegate> delegate;
@property (nonatomic, strong) NSDictionary *userInfo;

- (void)startCountDown;
- (void)setVerifyBtnEnabled:(BOOL)enabled;
- (void)phoneTextFieldBecomeFirstResponse;

@end
