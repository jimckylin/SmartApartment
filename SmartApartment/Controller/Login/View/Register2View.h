//
//  Register2View.h
//  SmartApartment
//
//  Created by jimcky on 2017/8/29.
//  Copyright © 2017年 Jimcky Lin. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol Register2ViewDelegate <NSObject>

- (void)register2ViewVerifyCodeBtnClick;
- (void)register2ViewBtnClick:(NSString *)verifyCode;
@end

@interface Register2View : UIView
@property (nonatomic, weak) id<Register2ViewDelegate> delegate;

@end
