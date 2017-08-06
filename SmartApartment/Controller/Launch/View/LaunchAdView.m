//
//  LaunchAdView.m
//  CWGJCarOwner
//
//  Created by QingGeMac on 17/2/13.
//  Copyright © 2017年 mutouren. All rights reserved.
//

#import "LaunchAdView.h"
#import "PureLayout.h"

@interface LaunchAdView ()

@property (nonatomic,strong)UIView *logoBgView;

@property (nonatomic,strong)UIImageView *logoImgView;

@property (nonatomic,strong)UIButton *jumpBtn;



@end


@implementation LaunchAdView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self layoutLaunchAdView];
    }
    return self;
}

- (void)adClick:(UITapGestureRecognizer *)sender
{
    if ([self.delegate respondsToSelector:@selector(launchAdViewClickAdImage)]) {
        [self.delegate launchAdViewClickAdImage];
    }
}

- (void)jumpBtnClick:(UIButton *)sender
{
    if ([self.delegate respondsToSelector:@selector(launchAdViewClickJump)]) {
        [self.delegate launchAdViewClickJump];
    }
}

- (void)layoutLaunchAdView
{
    [self addSubview:self.adImgView];
    [self.adImgView autoPinEdgesToSuperviewEdges];

    [self addSubview:self.jumpBtn];
    [self.jumpBtn autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:20];
    [self.jumpBtn autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:20];
    
}


- (UIButton *)jumpBtn
{
    if (!_jumpBtn) {
        _jumpBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_jumpBtn setImage:kImage(@"LaunchAdJump") forState:UIControlStateNormal];
        [_jumpBtn addTarget:self action:@selector(jumpBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _jumpBtn;
}

- (UIImageView *)adImgView
{
    if (!_adImgView) {
        _adImgView = [[UIImageView alloc]initWithFrame:CGRectZero];
        _adImgView.contentMode = UIViewContentModeScaleAspectFill;
        _adImgView.backgroundColor = [UIColor whiteColor];
        //手势
        _adImgView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(adClick:)];
        [_adImgView addGestureRecognizer:tap];
    }
    return _adImgView;
}

@end
