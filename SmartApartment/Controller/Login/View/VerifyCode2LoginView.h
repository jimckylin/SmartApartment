//
//  VerifyCode2LoginView.h
//  SmartApartment
//
//  Created by jimcky on 2017/8/31.
//  Copyright © 2017年 Jimcky Lin. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol VerifyCode2LoginViewDelegate <NSObject>

- (void)verifyCode2ViewVerifyCodeBtnClick;
- (void)verifyCode2LoginView:(NSString *)code;
@end

@interface VerifyCode2LoginView : UIView

@property (nonatomic, copy) NSString *phone;
@property (nonatomic, weak) id<VerifyCode2LoginViewDelegate> delegate;

@end
