//
//  LaunchAdViewController.m
//  CWGJCarOwner
//
//  Created by renxinwei on 2017/7/19.
//  Copyright © 2017年 CheWeiGuanJia. All rights reserved.
//

#import "LaunchAdViewController.h"
#import "LoginViewController.h"
#import "NavManager.h"
#import "LaunchAdView.h"


@interface LaunchAdViewController () <LaunchAdViewDelegate>

@property (nonatomic, assign) NSInteger adShowSecond;
@property (nonatomic, strong) NSTimer *adTimer;

@end

@implementation LaunchAdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    if (/* DISABLES CODE */ (YES)) {
        [self showLaunchAd];
    } else {
        [self enterMainVC];
    }
}

#pragma mark - LaunchAdViewDelegate

- (void)launchAdViewClickJump {
    [self enterMainVC];
}

- (void)launchAdViewClickAdImage {
    [self enterMainVC];
    
    //CZDWebViewController *vc = [CZDWebViewFactory getDetailWebVcWithUrl:adUrl];
    //[[NavManager shareInstance] showViewController:vc isAnimated:YES];
}

#pragma mark - Private

- (void)showLaunchAd {
    
    UIImage *adImage = [UIImage imageNamed:@"snapshot.png"];
    if (adImage) {
        // 设置广告图片开启倒计时
        LaunchAdView *launchAdView = [[LaunchAdView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        launchAdView.adImgView.image = adImage;
        launchAdView.delegate = self;
        [self.view addSubview:launchAdView];
        
        self.adShowSecond = 5;
        self.adTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(adCountDown) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:self.adTimer forMode:NSRunLoopCommonModes];
    } else {
        [self enterMainVC];
    }
}

- (void)adCountDown {
    self.adShowSecond--;
    if (self.adShowSecond <= 0) {
        [self enterMainVC];
    }
}

- (void)enterMainVC {
    // 关闭定时器,进入主页
    if (self.adTimer.isValid) {
        [self.adTimer invalidate];
    }
    
    if (/* is login */ (YES)) {
        [[NavManager shareInstance] setLoginRootController];
    }else {
        [[NavManager shareInstance] showViewController:[LoginViewController new] isAnimated:NO];
    }
    
    
    /*
    if ([[CODataCacheManager shareInstance] isLogin]) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"LoginSuccess" object:nil];
    } else {
        [[NavManager shareInstance] showViewController:[[MXLoginHomeViewController alloc] init] isAnimated:NO];
        [self removeFromParentViewController];
    }*/
}

@end
