//
//  AddPassengerViewController.h
//  SmartApartment
//
//  Created by Jimcky Lin on 2017/8/20.
//  Copyright © 2017年 Jimcky Lin. All rights reserved.
//

#import "ParentViewController.h"

@interface AddPassengerViewController : ParentViewController

@property (nonatomic, assign) BOOL modify;
@property (nonatomic, strong) NSDictionary *contact;

@property (nonatomic, copy) void(^didAddOrModifyUserInfo)();

@end
