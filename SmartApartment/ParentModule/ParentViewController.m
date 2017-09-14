//
//  ParentViewController.m
//  Fashion
//
//  Created by Newbie on 14-11-6.
//  Copyright (c) 2014年 com.newbie.circle. All rights reserved.
//

#import "ParentViewController.h"
#import "Macro.h"

#define BackProgressTag 12121212
#define BackProgressShowTag 12121213
#define BackProgressIndicatorTag 12121214

#define BUTTON_SPACEING 10 // 按钮间距10


@interface ParentViewController ()
{
    UIView *_progressView;
    UIView *_blackProgressView;
    UIActivityIndicatorView *_backIndicatorView;
}
@end

@implementation ParentViewController

- (void)dealloc {

}

//- (void)viewDidAppear:(BOOL)animated {
//    [super viewDidAppear:animated];
//    NSString* cName = NSStringFromClass([self class]);
//    [[BaiduMobStat defaultStat] pageviewStartWithName:cName];
//}
//
//- (void)viewDidDisappear:(BOOL)animated {
//    [super viewDidDisappear:animated];
//    NSString* cName = NSStringFromClass([self class]);
//    [[BaiduMobStat defaultStat] pageviewEndWithName:cName];
//}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithHexString:@"#F2F2F2"];

    _naviView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 64)];
    _naviView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_naviView];
    
    _naviBgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 64)];
    _naviBgView.backgroundColor = ThemeColor;//YZColor(51, 64, 72, 1);
    [_naviView addSubview:_naviBgView];

    _naviBackBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _naviBackBtn.frame = CGRectMake(0, 20, 75, 44);
    [_naviBackBtn setImage:[UIImage imageNamed:@"nav_return_ic_wiphone"] forState:UIControlStateNormal];
    [_naviBackBtn setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 27)];
    [_naviBackBtn addTarget:self action:@selector(backClick:) forControlEvents:UIControlEventTouchUpInside];
    [_naviView addSubview:_naviBackBtn];
    
    _naviLabel = [[UILabel alloc]initWithFrame:CGRectMake(70, 29, kScreenWidth - 2 * 70, 26)];
    _naviLabel.textColor = [UIColor whiteColor];
    _naviLabel.backgroundColor = [UIColor clearColor];
    _naviLabel.font = [UIFont systemFontOfSize:18.0];
    _naviLabel.textAlignment = NSTextAlignmentCenter;
    _naviLabel.text = self.title;
    [_naviView addSubview:_naviLabel];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)backClick:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)hideBackBtn {
    
    [_naviBackBtn setHidden:YES];
}


- (BOOL)checkIsLogin {
    if (![UserManager manager].isLogin) {
        [[NavManager shareInstance] returnToLoginView:YES];
    }
    return [UserManager manager].isLogin;
}


#pragma mark- 添加自定义按钮

// 添加文字按钮
-(void)addRightNaviButton:(NSString *)title action:(SEL)action{
    
    UIFont *font = [UIFont systemFontOfSize:14.0f];
    CGSize textSize = [title sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]}];
    
    UIButton *button=[UIButton buttonWithType:UIButtonTypeCustom];
    button.frame=CGRectMake(kScreenWidth - textSize.width - 16, 22, textSize.width + 6, 40);
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor colorWithWhite:0.841 alpha:0.600] forState:UIControlStateHighlighted];
    button.titleLabel.font = font;
    [button addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
    [_naviView addSubview:button];
}

- (void)addRightNaviButton:(NSString *)title actionBlock:(void (^)())actionBlcok {
    
    UIFont *font = [UIFont systemFontOfSize:14.0f];
    CGSize textSize = [title sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]}];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(kScreenWidth - textSize.width - 16, 22, textSize.width + 6, 40);
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor colorWithWhite:0.841 alpha:0.600] forState:UIControlStateHighlighted];
    button.titleLabel.font = font;
    if (actionBlcok) {
        [button ay_setActionBlock:actionBlcok];
    }
    [_naviView addSubview:button];
}

// 添加一个图片按钮
-(void)addRightNaviButton:(UIImage *)image highlight:(UIImage *)highlight action:(SEL)action{
    
    UIButton *button=[UIButton buttonWithType:UIButtonTypeCustom];
    button.frame=CGRectMake(kScreenWidth - 40 - 5, 22, 40, 40);
    [button setImage:image forState:UIControlStateNormal];
    [button setImage:highlight forState:UIControlStateHighlighted];
    button.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [button addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
    [_naviView addSubview:button];
}

- (void)addRightNaviButton:(UIImage *)image highlight:(UIImage *)highlight actionBlock:(void (^)())actionBlcok {
    UIButton *button=[UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(kScreenWidth - image.size.width - 20, 20, 44, 44);
    [button setImage:image forState:UIControlStateNormal];
    button.contentMode = UIViewContentModeCenter;
    if (highlight) {
        [button setImage:highlight forState:UIControlStateHighlighted];
    }
    if (actionBlcok) {
        [button ay_setActionBlock:actionBlcok];
    }
    [_naviView addSubview:button];
}

// 添加两个图片按钮
-(void)addRightNaviButtons:(NSArray *)images highlights:(NSArray *)highlights action:(SEL)action{
    
    [self addRightNaviButtons:images highlights:highlights action:action buttonSpacing:0];
}

// 添加两个图片按钮,带间距
-(void)addRightNaviButtons:(NSArray *)images highlights:(NSArray *)highlights action:(SEL)action buttonSpacing:(CGFloat)spacing{
    
    UIImage *image1 = [images objectAtIndex:0];
    UIImage *image2 = [images objectAtIndex:1];
    
    UIImage *highlight1 = nil;
    UIImage *highlight2 = nil;
    
    if (highlights.count == 1) {
        highlight1 = [highlights objectAtIndex:0];
        
    }else if (highlights.count == 2){
        highlight1 = [highlights objectAtIndex:0];
        highlight2 = [highlights objectAtIndex:1];
    }
    
    CGFloat btnSpacing = spacing? spacing:BUTTON_SPACEING;
    
    UIButton *button1 = [UIButton buttonWithType:UIButtonTypeCustom];
    button1.frame = CGRectMake(kScreenWidth - image1.size.width - 10 - 6 - image2.size.width - btnSpacing, (64 - image1.size.height)/2.0, image1.size.width, image1.size.height);
    [button1 setBackgroundImage:image1 forState:UIControlStateNormal];
    [button1 setBackgroundImage:highlight1 forState:UIControlStateHighlighted];
    [button1 addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
    button1.tag = kNavButtonTag1;
    [_naviView addSubview:button1];
    
    UIButton *button2 = [UIButton buttonWithType:UIButtonTypeCustom];
    button2.frame=CGRectMake(kScreenWidth - image2.size.width - 10 - 6, (64 - image2.size.height)/2.0, image2.size.width, image2.size.height);
    //    button2.layer.borderWidth = 1.0;
    [button2 setBackgroundImage:image2 forState:UIControlStateNormal];
    [button2 setBackgroundImage:highlight2 forState:UIControlStateHighlighted];
    [button2 addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
    button2.tag = kNavButtonTag2;
    
    [_naviView addSubview:button2];
}


- (void)pushControllerWithName:(NSString *)controllerName properties:(NSDictionary *)properties {
    NSParameterAssert(controllerName);
    Class className = NSClassFromString(controllerName);
    if (!className) {
        YZLog(@"pushControllerWithName controllerName invalid");
        return;
    }
    id controller = [[className alloc] init];
    if (![controller isKindOfClass:[UIViewController class]]) {
        YZLog(@"pushControllerWithName controllerName is not UIViewController class name");
        return;
    }
    if (properties && properties.count > 0) {
        [properties enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
            [controller setValue:obj forKeyPath:key];
        }];
    }
    [self.navigationController pushViewController:(UIViewController *)controller animated:YES];
}

- (void)pushControllerWithClass:(Class)controllerClass properties:(NSDictionary *)properties {
    NSParameterAssert(controllerClass);
    id controller = [[controllerClass alloc] init];
    if (![controller isKindOfClass:[UIViewController class]]) {
        YZLog(@"pushControllerWithClass controllerClass is not UIViewController class");
        return;
    }
    if (properties && properties.count > 0) {
        [properties enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
            [controller setValue:obj forKeyPath:key];
        }];
    }
    [self.navigationController pushViewController:(UIViewController *)controller animated:YES];
}

@end
