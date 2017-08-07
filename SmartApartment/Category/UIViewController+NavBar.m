//
//  UIViewController+NavBar.m
//  CWGJCarPark
//
//  Created by mutouren on 9/7/15.
//  Copyright (c) 2015 mutouren. All rights reserved.
//

#import "UIViewController+NavBar.h"
#import "NavManager.h"
#import "UIView+Size.h"
#import "PureLayout.h"
#import <objc/runtime.h>

void *BarViewKey = nil;
void *LayoutSubViewKey = nil;
void *RightBtnKey = nil;
void *LeftBtnKey = nil;
void *TitleLabelKey = nil;



@interface UIViewController ()

@property (nonatomic, strong) UIView *layoutSubView;
@property (nonatomic, strong) UIButton *rightBtn;
@property (nonatomic, strong) UIButton *leftBtn;
@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation UIViewController (NavBar)


- (void)setBarView:(UIView *)barView
{
    objc_setAssociatedObject(self, &BarViewKey, barView, OBJC_ASSOCIATION_RETAIN);
}

- (UIView*)barView
{
    return objc_getAssociatedObject(self, &BarViewKey);
}

- (void)setLayoutSubView:(UIView *)layoutSubView
{
    objc_setAssociatedObject(self, &LayoutSubViewKey, layoutSubView, OBJC_ASSOCIATION_RETAIN);
}

- (UIView*)layoutSubView
{
    return objc_getAssociatedObject(self, &LayoutSubViewKey);
}

- (void)setRightBtn:(UIButton *)rightBtn
{
    objc_setAssociatedObject(self, &RightBtnKey, rightBtn, OBJC_ASSOCIATION_RETAIN);
}

- (UIButton*)rightBtn
{
    return objc_getAssociatedObject(self, &RightBtnKey);
}

- (void)setLeftBtn:(UIButton *)leftBtn
{
    objc_setAssociatedObject(self, &LeftBtnKey, leftBtn, OBJC_ASSOCIATION_RETAIN);
}

- (UIButton*)leftBtn
{
    return objc_getAssociatedObject(self, &LeftBtnKey);
}

- (void)setTitleLabel:(UILabel *)titleLabel
{
    objc_setAssociatedObject(self, &TitleLabelKey, titleLabel, OBJC_ASSOCIATION_RETAIN);
}

- (UILabel*)titleLabel
{
    return objc_getAssociatedObject(self, &TitleLabelKey);
}

#pragma mark 主页面导航栏
- (UIView*)mainNavBarWithtitle:(NSString *)title RightImage:(UIImage*)rightImage leftImage:(UIImage*)leftImage  rightBtnSEL:(SEL)rightBtnSel leftBtnSEL:(SEL)leftBtnSel
{
    UIView *barView = [[UIView alloc] initWithFrame:CGRectZero];//CGRectMake(0, 0, Screen_SIZE.width, BARHEIGHT)
    [barView setBackgroundColor:[UIColor clearColor]];
    
    UIView *layoutView = [[UIView alloc] initWithFrame:CGRectZero];
    [barView addSubview:layoutView];
    self.layoutSubView = layoutView;
    [self.layoutSubView setBackgroundColor:[UIColor clearColor]];
    
    UIButton *leftBtn = [[UIButton alloc] init];
    leftBtn.frame = CGRectZero;
    [leftBtn setBackgroundColor:[UIColor clearColor]];
    if (leftImage) {
        [leftBtn setImage:leftImage forState:UIControlStateNormal];
    }
    
    if (leftBtnSel) {
        [leftBtn addTarget:self action:leftBtnSel forControlEvents:UIControlEventTouchUpInside];
    }
    
    [self.layoutSubView addSubview:leftBtn];
    self.leftBtn = leftBtn;
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    [titleLabel setCenter:CGPointMake(barView.width/2, 20+(barView.height-20)/2)];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = [UIFont boldSystemFontOfSize:19];
    titleLabel.textColor = [UIColor colorWithHexString:@"#2290FE"];
    if (title) {
        [titleLabel setText:title];
    }
    [self.layoutSubView addSubview:titleLabel];
    self.titleLabel = titleLabel;
    
    UIButton *rightBtn = [[UIButton alloc] init];
    rightBtn.frame = CGRectZero;
    [rightBtn setBackgroundColor:[UIColor clearColor]];
    if (rightImage) {
        [rightBtn setImage:rightImage forState:UIControlStateNormal];
    }
    
    if (rightBtnSel) {
        [rightBtn addTarget:self action:rightBtnSel forControlEvents:UIControlEventTouchUpInside];
    }
    
    [self.layoutSubView addSubview:rightBtn];
    self.rightBtn = rightBtn;
    
    
    return barView;
}

#pragma mark 带一个标题的导航栏
- (UIView*)navBarWithTitle:(NSString*)title
{
    UIView *barView = [[UIView alloc] initWithFrame:CGRectZero];
    [barView setBackgroundColor:[UIColor whiteColor]];
    UIView *layoutView = [[UIView alloc] initWithFrame:CGRectZero];
    [barView addSubview:layoutView];
    self.layoutSubView = layoutView;
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    [titleLabel setCenter:CGPointMake(barView.width/2, 20+(barView.height-20)/2)];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = [UIFont boldSystemFontOfSize:18.f];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.textColor = [UIColor blackColor];
    if (title) {
        [titleLabel setText:title];
    }
    [self.layoutSubView addSubview:titleLabel];
    
    self.titleLabel = titleLabel;
    
    return barView;
}


#pragma mark 带一个返回按钮的导航栏
- (UIView*)returnBtnNavBarWithTitle:(NSString*)title leftBtnSEL:(SEL)leftBtnSel
{
    UIView *barView = [[UIView alloc] initWithFrame:CGRectZero];//CGRectMake(0, 0, Screen_SIZE.width, BARHEIGHT)
    [barView setBackgroundColor:RGBA(250, 250, 250, 1.0f)];
    
    UIView *layoutView = [[UIView alloc] initWithFrame:CGRectZero];
    [barView addSubview:layoutView];
    self.layoutSubView = layoutView;
    
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leftBtn.frame = CGRectZero;
    //    [rightBtn setCenter:CGPointMake(0, 20+(barView.height-20)/2)];
    //    rightBtn.frame = CGRectMake(barView.width-rightBtn.width-10.0f, rightBtn.yOrigin, 80.0f, 36.0f);
    leftBtn.backgroundColor = [UIColor clearColor];
    leftBtn.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    [leftBtn.titleLabel setFont:[UIFont systemFontOfSize:14]];
    [leftBtn setImage:kImage(@"nav_back.png") forState:UIControlStateNormal];
    [leftBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    if (leftBtnSel) {
        [leftBtn addTarget:self action:leftBtnSel forControlEvents:UIControlEventTouchUpInside];
    }
    else {
        [leftBtn addTarget:self action:@selector(leftBtnClickExt:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    [self.layoutSubView addSubview:leftBtn];
    self.leftBtn = leftBtn;
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];//CGRectMake(0, 0, 200, BARHEIGHT)
    [titleLabel setCenter:CGPointMake(barView.width/2, 20+(barView.height-20)/2)];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = [UIFont boldSystemFontOfSize:18.f];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.textColor = [UIColor blackColor];
    if (title) {
        [titleLabel setText:title];
    }
    [self.layoutSubView addSubview:titleLabel];
    self.titleLabel = titleLabel;
    
    return barView;
}

#pragma mark 带一个返回按钮和右边按钮的导航栏
- (UIView*)returnBtnAndRightBtnNavBarWithTitle:(NSString*)title rightBtnTitle:(NSString*)btnTitle rightBtnImage:(UIImage*)btnImage leftBtnSEL:(SEL)leftBtnSel rightBtnSEL:(SEL)rightBtnSel
{
    UIView *barView = [[UIView alloc] initWithFrame:CGRectZero];//CGRectMake(0, 0, Screen_SIZE.width, BARHEIGHT)
    [barView setBackgroundColor:RGBA(250, 250, 250, 1.0f)];
    
    UIView *layoutView = [[UIView alloc] initWithFrame:CGRectZero];
    [barView addSubview:layoutView];
    self.layoutSubView = layoutView;
    
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leftBtn.frame = CGRectZero;
    //    [rightBtn setCenter:CGPointMake(0, 20+(barView.height-20)/2)];
    //    rightBtn.frame = CGRectMake(barView.width-rightBtn.width-10.0f, rightBtn.yOrigin, 80.0f, 36.0f);
    leftBtn.backgroundColor = [UIColor clearColor];
    leftBtn.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    [leftBtn.titleLabel setFont:[UIFont systemFontOfSize:14]];
    [leftBtn setImage:kImage(@"nav_back.png") forState:UIControlStateNormal];
    [leftBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    if (leftBtnSel) {
        [leftBtn addTarget:self action:leftBtnSel forControlEvents:UIControlEventTouchUpInside];
    }
    else {
        [leftBtn addTarget:self action:@selector(leftBtnClickExt:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    [self.layoutSubView addSubview:leftBtn];
    self.leftBtn = leftBtn;
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];//CGRectMake(0, 0, 200, BARHEIGHT)
    [titleLabel setCenter:CGPointMake(barView.width/2, 20+(barView.height-20)/2)];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = [UIFont boldSystemFontOfSize:18.f];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.textColor = [UIColor blackColor];
    if (title) {
        [titleLabel setText:title];
    }
    [self.layoutSubView addSubview:titleLabel];
    self.titleLabel = titleLabel;
    
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame = CGRectZero;
    //    [rightBtn setCenter:CGPointMake(0, 20+(barView.height-20)/2)];
    //    rightBtn.frame = CGRectMake(barView.width-rightBtn.width-10.0f, rightBtn.yOrigin, 80.0f, 36.0f);
    rightBtn.backgroundColor = [UIColor clearColor];
    rightBtn.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    [rightBtn.titleLabel setFont:[UIFont systemFontOfSize:14]];
    if (btnImage) {
        [rightBtn setImage:btnImage forState:UIControlStateNormal];
    }
    else if (btnTitle) {
        [rightBtn setTitle:btnTitle forState:UIControlStateNormal];
        [rightBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    }
    
    if (rightBtnSel) {
        [rightBtn addTarget:self action:rightBtnSel forControlEvents:UIControlEventTouchUpInside];
    }
    
    [self.layoutSubView addSubview:rightBtn];
    self.rightBtn = rightBtn;
    
    return barView;
}

#pragma mark 带一个右边按钮的导航栏
- (UIView*)rightBtnNavBarWithTitle:(NSString*)title rightBtnTitle:(NSString*)btnTitle rightBtnImage:(UIImage*)btnImage rightBtnSEL:(SEL)rightBtnSel
{
    UIView *barView = [[UIView alloc] initWithFrame:CGRectZero];//CGRectMake(0, 0, Screen_SIZE.width, BARHEIGHT)
    [barView setBackgroundColor:RGBA(250, 250, 250, 1.0f)];
    
    UIView *layoutView = [[UIView alloc] initWithFrame:CGRectZero];
    [barView addSubview:layoutView];
    self.layoutSubView = layoutView;
    
//    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    leftBtn.frame = CGRectZero;
//    //    [rightBtn setCenter:CGPointMake(0, 20+(barView.height-20)/2)];
//    //    rightBtn.frame = CGRectMake(barView.width-rightBtn.width-10.0f, rightBtn.yOrigin, 80.0f, 36.0f);
//    leftBtn.backgroundColor = [UIColor clearColor];
//    leftBtn.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
//    [leftBtn.titleLabel setFont:[UIFont systemFontOfSize:14]];
//    [leftBtn setImage:kImage(@"nav_back.png") forState:UIControlStateNormal];
//    [leftBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//    
//    if (leftBtnSel) {
//        [leftBtn addTarget:self action:leftBtnSel forControlEvents:UIControlEventTouchUpInside];
//    }
//    else {
//        [leftBtn addTarget:self action:@selector(leftBtnClickExt:) forControlEvents:UIControlEventTouchUpInside];
//    }
//    
//    [self.layoutSubView addSubview:leftBtn];
//    self.leftBtn = leftBtn;
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];//CGRectMake(0, 0, 200, BARHEIGHT)
    [titleLabel setCenter:CGPointMake(barView.width/2, 20+(barView.height-20)/2)];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = [UIFont boldSystemFontOfSize:18.f];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.textColor = [UIColor blackColor];
    if (title) {
        [titleLabel setText:title];
    }
    [self.layoutSubView addSubview:titleLabel];
    self.titleLabel = titleLabel;
    
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame = CGRectZero;
    //    [rightBtn setCenter:CGPointMake(0, 20+(barView.height-20)/2)];
    //    rightBtn.frame = CGRectMake(barView.width-rightBtn.width-10.0f, rightBtn.yOrigin, 80.0f, 36.0f);
    rightBtn.backgroundColor = [UIColor clearColor];
    rightBtn.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    [rightBtn.titleLabel setFont:[UIFont systemFontOfSize:14]];
    if (btnImage) {
        [rightBtn setImage:btnImage forState:UIControlStateNormal];
    }
    else if (btnTitle) {
        [rightBtn setTitle:btnTitle forState:UIControlStateNormal];
        [rightBtn setTitleColor:RGBA(74, 144, 223, 1.0f) forState:UIControlStateNormal];
    }
    
    if (rightBtnSel) {
        [rightBtn addTarget:self action:rightBtnSel forControlEvents:UIControlEventTouchUpInside];
    }
    
    [self.layoutSubView addSubview:rightBtn];
    self.rightBtn = rightBtn;
    
    return barView;
}

#pragma mark 设置导航栏title
- (void)setTitleText:(NSString*)text
{
    [self.titleLabel setText:text];
}

#pragma mark 左边按钮默认点击事件
- (void)leftBtnClickExt:(id)sender
{
    [[NavManager shareInstance] returnToFrontView:YES];
}

#pragma mark 返回bar的高度
- (CGFloat)navBarHeight
{
    return BARHEIGHT;
}

#pragma mark navBar 布局
- (void)navBarUpdateViewConstraints
{
    [self.barView setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    [self.barView autoPinEdgeToSuperviewEdge:ALEdgeTop];
    [self.barView autoPinEdgeToSuperviewEdge:ALEdgeLeft];
    [self.barView autoMatchDimension:ALDimensionWidth toDimension:ALDimensionWidth ofView:self.view];
    [self.barView autoSetDimension:ALDimensionHeight toSize:BARHEIGHT];
    self.barView.backgroundColor = [UIColor whiteColor];
}

#pragma mark 主页面布局
- (void)mainNavBarUpdateViewConstraints
{
    [self.layoutSubView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.rightBtn setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.titleLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    [NSLayoutConstraint autoSetIdentifier:@"layout view edges" forConstraints:^{
        [self.layoutSubView autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:20.0f];
        [self.layoutSubView autoPinEdgeToSuperviewEdge:ALEdgeLeft];
        [self.layoutSubView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(0.0, 0.0, 0.0, 0.0) excludingEdge:ALEdgeTop];
    }];
    
    
    [NSLayoutConstraint autoSetIdentifier:@"layout sub view edges" forConstraints:^{
        [self.leftBtn autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:MAIN_PAG_Y];
        [self.leftBtn autoSetDimensionsToSize:CGSizeMake(65, 35)];
        [self.leftBtn autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
        
        [self.rightBtn autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:MAIN_PAG_Y];
        [self.rightBtn autoSetDimensionsToSize:CGSizeMake(65, 35)];
        [@[self.leftBtn,self.rightBtn] autoAlignViewsToAxis:ALAxisHorizontal];
        
        [self.titleLabel autoMatchDimension:ALDimensionHeight toDimension:ALDimensionHeight ofView:self.layoutSubView];
        [self.titleLabel autoAlignAxisToSuperviewAxis:ALAxisVertical];
        [self.titleLabel autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
    }];
}

#pragma mark 带一个返回按钮导航栏布局
- (void)returnBtnNavBarUpdateViewConstraints
{
    [self.layoutSubView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.leftBtn setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.titleLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    [NSLayoutConstraint autoSetIdentifier:@"layout view edges" forConstraints:^{
        [self.layoutSubView autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:20.0f];
        [self.layoutSubView autoPinEdgeToSuperviewEdge:ALEdgeLeft];
        [self.layoutSubView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(0.0, 0.0, 0.0, 0.0) excludingEdge:ALEdgeTop];
    }];
    
    
    [NSLayoutConstraint autoSetIdentifier:@"layout sub view edges" forConstraints:^{
        [self.titleLabel autoMatchDimension:ALDimensionHeight toDimension:ALDimensionHeight ofView:self.layoutSubView];
        [self.titleLabel autoAlignAxisToSuperviewAxis:ALAxisVertical];
        [self.titleLabel autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
        
        [self.leftBtn autoPinEdgeToSuperviewEdge:ALEdgeLeading withInset:PAG_Y];
//        [self.leftBtn autoSetDimensionsToSize:CGSizeMake(self.leftBtn.currentImage.size.width+10.0f, self.leftBtn.currentImage.size.height)];
        
        
        [@[self.titleLabel,self.leftBtn] autoAlignViewsToAxis:ALAxisHorizontal];
    }];
}

#pragma mark 带一个返回按钮和右边按钮的导航栏布局
- (void)returnBtnAndRightBtnNavBarUpdateViewConstraints
{
    [self.layoutSubView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.leftBtn setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.rightBtn setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.titleLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    [NSLayoutConstraint autoSetIdentifier:@"layout view edges" forConstraints:^{
        [self.layoutSubView autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:20.0f];
        [self.layoutSubView autoPinEdgeToSuperviewEdge:ALEdgeLeft];
        [self.layoutSubView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(0.0, 0.0, 0.0, 0.0) excludingEdge:ALEdgeTop];
    }];
    
    
    [NSLayoutConstraint autoSetIdentifier:@"layout sub view edges" forConstraints:^{
        [self.titleLabel autoMatchDimension:ALDimensionHeight toDimension:ALDimensionHeight ofView:self.layoutSubView];
        [self.titleLabel autoAlignAxisToSuperviewAxis:ALAxisVertical];
        [self.titleLabel autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
        
        [self.leftBtn autoPinEdgeToSuperviewEdge:ALEdgeLeading withInset:PAG_Y];
//        [self.leftBtn autoSetDimensionsToSize:CGSizeMake(self.leftBtn.currentImage.size.width+10.0f, self.leftBtn.currentImage.size.height)];
        
        [self.rightBtn autoSetDimensionsToSize:CGSizeMake(65, 35)];
        [self.rightBtn autoPinEdgeToSuperviewEdge:ALEdgeTrailing withInset:PAG_Y];
        
        [@[self.titleLabel,self.leftBtn,self.rightBtn] autoAlignViewsToAxis:ALAxisHorizontal];
    }];
}

#pragma mark 带一个右边按钮的导航栏布局
- (void)rightBtnNavBarUpdateViewConstraints
{
    [self.layoutSubView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.rightBtn setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.titleLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    [NSLayoutConstraint autoSetIdentifier:@"layout view edges" forConstraints:^{
        [self.layoutSubView autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:20.0f];
        [self.layoutSubView autoPinEdgeToSuperviewEdge:ALEdgeLeft];
        [self.layoutSubView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(0.0, 0.0, 0.0, 0.0) excludingEdge:ALEdgeTop];
    }];
    
    
    [NSLayoutConstraint autoSetIdentifier:@"layout sub view edges" forConstraints:^{
        [self.titleLabel autoMatchDimension:ALDimensionHeight toDimension:ALDimensionHeight ofView:self.layoutSubView];
        [self.titleLabel autoAlignAxisToSuperviewAxis:ALAxisVertical];
        [self.titleLabel autoAlignAxisToSuperviewAxis:ALAxisHorizontal];

        [self.rightBtn autoSetDimensionsToSize:CGSizeMake(65.0f, 35.0f)];
         
        [self.rightBtn autoPinEdgeToSuperviewEdge:ALEdgeTrailing withInset:PAG_Y];
        
        [@[self.titleLabel,self.rightBtn] autoAlignViewsToAxis:ALAxisHorizontal];
    }];
}

- (void)titleNavBarUpdateViewConstraints
{
    [self.layoutSubView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.titleLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    [NSLayoutConstraint autoSetIdentifier:@"layout view edges" forConstraints:^{
        [self.layoutSubView autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:20.0f];
        [self.layoutSubView autoPinEdgeToSuperviewEdge:ALEdgeLeft];
        [self.layoutSubView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(0.0, 0.0, 0.0, 0.0) excludingEdge:ALEdgeTop];
    }];
    
    
    [NSLayoutConstraint autoSetIdentifier:@"layout sub view edges" forConstraints:^{
        [self.titleLabel autoMatchDimension:ALDimensionHeight toDimension:ALDimensionHeight ofView:self.layoutSubView];
        [self.titleLabel autoAlignAxisToSuperviewAxis:ALAxisVertical];
        [self.titleLabel autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
    }];
}


@end
