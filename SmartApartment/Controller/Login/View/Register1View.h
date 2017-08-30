//
//  Register1View.h
//  SmartApartment
//
//  Created by jimcky on 2017/8/29.
//  Copyright © 2017年 Jimcky Lin. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol Register1ViewDelegate <NSObject>

- (void)register1ViewBtnClick:(NSString *)phone name:(NSString *)name;

@end

@interface Register1View : UIView

@property (nonatomic, weak) id<Register1ViewDelegate> delegate;

@end
