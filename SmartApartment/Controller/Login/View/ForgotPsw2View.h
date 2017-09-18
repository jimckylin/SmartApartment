//
//  ForgotPsw2View.h
//  SmartApartment
//
//  Created by jimcky on 2017/9/18.
//  Copyright © 2017年 Jimcky Lin. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ForgotPsw2ViewDelegate <NSObject>

- (void)forgotPsw2ViewDidClickResetBtnAction:(NSString *)pwd;

@end


@interface ForgotPsw2View : UIView

@property (nonatomic, weak) id<ForgotPsw2ViewDelegate> delegate;

@end
