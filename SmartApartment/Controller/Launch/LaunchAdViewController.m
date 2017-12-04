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
#import "PageControlView.h"

@interface LaunchAdViewController () <LaunchAdViewDelegate>

@property (nonatomic, assign) NSInteger adShowSecond;
@property (nonatomic, strong) NSTimer *adTimer;

@end

@implementation LaunchAdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self requestData];
    if(![[NSUserDefaults standardUserDefaults] objectForKey:@"isFirstInstall"]) {
        [[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:@"isFirstInstall"];
        [self addGuide];
    } else {
        NSString *homeAdImage = [[NSUserDefaults standardUserDefaults] objectForKey:@"homeAdImage"];
        if (homeAdImage) {
            [self showLaunchAd:homeAdImage];
        } else {
            [self enterMainVC];
        }
    }
}


#pragma mark - HttpRequest

- (void)requestData {
    
    [SAHttpRequest requestWithFuncion:@"getStartUpAd" params:nil class:nil success:^(id response) {
        if (response) {
            NSString *homeAdImage = response[@"homeAdImage"];
            [[NSUserDefaults standardUserDefaults] setObject:homeAdImage forKey:@"homeAdImage"];
            [[NSUserDefaults standardUserDefaults] synchronize];
        }
    } failure:^(NSError *error) {
    }];
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

- (void)addGuide {
    
    NSArray *imgs = @[@"loading_1", @"loading_2", @"loading_3", @"loading_4", @"loading_5"];
    PageControlView *pageControlV = [[PageControlView instance] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) andImageList:imgs];
    
    __WeakObj(self)
    pageControlV.didRemoveGuideViewBlock = ^{
        [selfWeak enterMainVC];
    };
    [self.view addSubview:pageControlV];
}

- (void)showLaunchAd:(NSString *)homeAdImage {
    
    if (homeAdImage) {
        // 设置广告图片开启倒计时
        LaunchAdView *launchAdView = [[LaunchAdView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        [launchAdView.adImgView sd_setImageWithPreviousCachedImageWithURL:[NSURL URLWithString:homeAdImage] placeholderImage:nil options:SDWebImageRetryFailed progress:^(NSInteger receivedSize, NSInteger expectedSize, NSURL * _Nullable targetURL) {
            
        } completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
            
        }];
        launchAdView.delegate = self;
        [self.view addSubview:launchAdView];
        
        self.adShowSecond = 4;
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
        [[NavManager shareInstance] setHomeRootController];
    }else {
        [[NavManager shareInstance] setLoginRootController];
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
