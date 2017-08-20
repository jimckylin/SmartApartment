//
//  COAboutMeViewController.m
//  CWGJCarOwner
//  左抽屉->设置->关于我们
//  Created by mutouren on 9/23/15.
//  Copyright (c) 2015 mutouren. All rights reserved.
//

#import "AboutViewController.h"


@interface AboutViewController ()

@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, strong) UIImageView *logoImageView;
@property (nonatomic, strong) UILabel *versionLabel;

@property (nonatomic, assign) BOOL didSetupConstraints;

@end

@implementation AboutViewController


- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self loadUI];
}

#pragma mark loadView 调用
- (void)loadUI
{
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    _naviLabel.text = @"关于蔓心宿";
    [self.view addSubview:self.contentView];
    [self.contentView addSubview:self.logoImageView];
    [self.contentView addSubview:self.versionLabel];

    [self.view setNeedsUpdateConstraints];
}

#pragma mark viewDidLoad 调用
- (void)loadData
{
    
}

#pragma mark 设置版本号
- (void)setVersionLabelText:(NSString*)text
{
    NSString *content = [NSString stringWithFormat:@"蔓心宿智能公寓\nV%@",text];
    [self.versionLabel setText:content];
}

- (UIImageView*)logoImageView
{
    if (!_logoImageView) {
        _logoImageView = [[UIImageView alloc] initWithImage:kImage(@"mine_about_qrcodeiphone")];
        [_logoImageView setBackgroundColor:[UIColor clearColor]];
    }
    
    return _logoImageView;
}

- (UILabel*)versionLabel
{
    if (!_versionLabel) {
        _versionLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _versionLabel.numberOfLines = 0;
        [_versionLabel setTextAlignment:NSTextAlignmentCenter];
        [_versionLabel setTextColor:RGBA(133, 133, 133, 1.0f)];
        [_versionLabel setFont:[UIFont systemFontOfSize:18.0f]];
        
    }
    
    return _versionLabel;
}


- (UIView*)contentView
{
    if (!_contentView) {
        _contentView = [[UIView alloc] initWithFrame:CGRectZero];
        [_contentView setBackgroundColor:[UIColor whiteColor]];
    }
    
    return _contentView;
}



#pragma mark - AutoLayout
- (void)updateViewConstraints
{
    if (!self.didSetupConstraints) {
        [self.contentView setTranslatesAutoresizingMaskIntoConstraints:NO];
        [self.logoImageView setTranslatesAutoresizingMaskIntoConstraints:NO];
        [self.versionLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
        
         [self.contentView autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:64];
        [self.contentView autoPinEdgeToSuperviewEdge:ALEdgeLeft];
        [self.contentView autoPinEdgeToSuperviewEdge:ALEdgeRight];
        [self.contentView autoPinEdgeToSuperviewEdge:ALEdgeBottom];
        [self.view sendSubviewToBack:self.contentView];
        
        [self.logoImageView autoSetDimensionsToSize:CGSizeMake(self.logoImageView.image.size.width, self.logoImageView.image.size.height)];
        [self.logoImageView autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:50];
        [self.logoImageView autoAlignAxisToSuperviewAxis:ALAxisVertical];
        
        [self.versionLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.logoImageView withOffset:8.0f];
        [self.versionLabel autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:16.0f];
        [self.versionLabel autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:16.0f];
        [self.versionLabel autoSetDimension:ALDimensionHeight toSize:60];
        
        self.didSetupConstraints = TRUE;
        [self setVersionLabelText:@"1.0"];
    }
    
    [super updateViewConstraints];
}

@end
