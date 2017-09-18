//
//  ForgotPsw1View.h
//  SmartApartment
//
//  Created by jimcky on 2017/9/18.
//  Copyright © 2017年 Jimcky Lin. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ForgotPsw1ViewDelegate <NSObject>

- (void)forgotPsw1ViewVerifyCodeBtnClick:(NSString *)phone;
- (void)forgotPsw1ViewDidClickBtnAction:(NSString *)phone code:(NSString *)code;

@end


@interface ForgotPsw1View : UIView

@property (nonatomic, weak) id<ForgotPsw1ViewDelegate> delegate;

@end
