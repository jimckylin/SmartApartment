//
//  HomeViewModel.m
//  SmartApartment
//
//  Created by jimcky on 2017/8/16.
//  Copyright © 2017年 Jimcky Lin. All rights reserved.
//

#import "HomeViewModel.h"
#import "LocationManager.h"
#import "Activity.h"

@implementation HomeViewModel

- (void)requestGetTopAd:(void (^)(NSArray *))getTopBlock {
    
    [MBProgressHUD cwgj_showProgressHUDWithText:@""];
    [SAHttpRequest requestWithFuncion:@"getActivity" params:nil class:[Activity class] success:^(id response) {
        if (getTopBlock) {
            getTopBlock(response);
        }
        [MBProgressHUD cwgj_hideHUD];
    } failure:^(NSError *error) {
        [MBProgressHUD cwgj_hideHUD];
        [MBProgressHUD cwgj_showHUDWithText:error.localizedDescription];
    }];
}

@end
