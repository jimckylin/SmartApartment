//
//  LaunchAdView.h
//  CWGJCarOwner
//
//  Created by QingGeMac on 17/2/13.
//  Copyright © 2017年 mutouren. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LaunchAdViewDelegate <NSObject>

- (void)launchAdViewClickAdImage;
- (void)launchAdViewClickJump;

@end

@interface LaunchAdView : UIView

@property (nonatomic,weak) id<LaunchAdViewDelegate>delegate;
@property (nonatomic,strong)UIImageView *adImgView;

@end
