//
//  Register3View.h
//  SmartApartment
//
//  Created by jimcky on 2017/8/29.
//  Copyright © 2017年 Jimcky Lin. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol Register3ViewDelegate <NSObject>

- (void)register3ViewBtnClick:(NSString *)pwd;
@end

@interface Register3View : UIView

@property (nonatomic, weak) id<Register3ViewDelegate> delegate;

@end
