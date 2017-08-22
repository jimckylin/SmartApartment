//
//  ShareManager.m
//  SmartApartment
//
//  Created by jimcky on 2017/8/22.
//  Copyright © 2017年 Jimcky Lin. All rights reserved.
//

#import "ShareManager.h"
#import <UShareUI/UShareUI.h>

@interface ShareManager ()<UMSocialShareMenuViewDelegate>

@end

@implementation ShareManager

+ (instancetype)manager {
    
    static ShareManager *instance = nil;
    static dispatch_once_t once;
    dispatch_once(&once, ^ { instance = [[ShareManager alloc] init]; });
    return instance;
}


- (void)startShare {
    
    //设置用户自定义的平台
    [UMSocialUIManager setPreDefinePlatforms:@[@(UMSocialPlatformType_WechatSession),
                                               @(UMSocialPlatformType_WechatTimeLine),
                                               @(UMSocialPlatformType_Sina),
                                               ]];
    
    [UMSocialShareUIConfig shareInstance].sharePageGroupViewConfig.sharePageGroupViewPostionType = UMSocialSharePageGroupViewPositionType_Bottom;
    [UMSocialShareUIConfig shareInstance].sharePageScrollViewConfig.shareScrollViewPageItemStyleType = UMSocialPlatformItemViewBackgroudType_None;
    
    [UMSocialUIManager showShareMenuViewInWindowWithPlatformSelectionBlock:^(UMSocialPlatformType platformType, NSDictionary *userInfo) {
        
        //在回调里面获得点击的
        if (platformType == UMSocialPlatformType_WechatSession) {
            
        }
    }];
}


@end
