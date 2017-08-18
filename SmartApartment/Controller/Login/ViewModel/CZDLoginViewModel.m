//
//  CZDLoginViewModel.m
//  CWGJCarOwner
//
//  Created by jimcky on 2017/7/19.
//  Copyright © 2017年 CheWeiGuanJia. All rights reserved.
//

#import "CZDLoginViewModel.h"
#import "CZDLoginView.h"
#import "MBProgressHUD+CWGJ.h"


@interface CZDLoginViewModel ()


@property (nonatomic, copy) void(^verifyCodeRequestComplete)(void);
@property (nonatomic, copy) void(^voiceVerifyCodeRequestComplete)(void);

@end

@implementation CZDLoginViewModel

- (void)requestVerifyCode:(NSString *)phone type:(int)type complete:(void (^)(void))complete {
    
    self.verifyCodeRequestComplete = complete;
    [MBProgressHUD cwgj_showProgressHUDWithText:@""];
    
}

- (void)requestVoiceVerifyCode:(NSString *)phone
                          type:(int)type
                      complete:(void (^)(void))complete {
    
    self.voiceVerifyCodeRequestComplete = complete;
    [MBProgressHUD cwgj_showProgressHUDWithText:@""];
}

- (void)requestLoginWithPhone:(NSString *)phone verifyCode:(NSString *)code {
    
    [MBProgressHUD cwgj_showProgressHUDWithText:@"登录中..."];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [MBProgressHUD cwgj_hideHUD];
        [[NavManager shareInstance] setHomeRootController];
    });
}

- (void)requestWeChatLoginWithPhone:(NSDictionary *)param {
    
    [MBProgressHUD cwgj_showProgressHUDWithText:@""];
    
}

#pragma mark - Private

- (void)gotoMainVc {
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"LoginSuccess" object:nil];
}


@end
