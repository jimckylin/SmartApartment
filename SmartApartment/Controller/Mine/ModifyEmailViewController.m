//
//  ModifyEmailViewController.m
//  SmartApartment
//
//  Created by jimcky on 2017/9/21.
//  Copyright © 2017年 Jimcky Lin. All rights reserved.
//

#import "ModifyEmailViewController.h"
#import "WRCellView.h"
#import "MineViewModel.h"
#import "NSString+RegExp.h"

#define WRCellViewHeight  50
#define CustomViewX       110
#define CustomViewWidth   150

@interface ModifyEmailViewController ()<UIActionSheetDelegate>

@property (nonatomic, strong) UIScrollView  *containerView;
@property (nonatomic, strong) WRCellView    *phoneNumView;

@property (nonatomic, strong) UITextField   *emailTF;
@property (nonatomic, strong) UIView        *footerView;

@property (nonatomic, strong) MineViewModel *viewModel;

@end


@implementation ModifyEmailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initView];
    [self addViews];
    [self setCellFrame];
}

- (void)initView {
    _naviLabel.text = @"邮箱";
    self.containerView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, kScreenWidth, self.view.bounds.size.height-64 - 50)];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.view addSubview:self.containerView];
}

- (void)addViews {

    [self.containerView addSubview:self.phoneNumView];
    [self.containerView addSubview:self.footerView];
    
    [self.phoneNumView addSubview:self.emailTF];
}

- (void)setCellFrame {
    
    self.phoneNumView.frame = CGRectMake(0, 30, kScreenWidth, WRCellViewHeight);
    self.footerView.frame = CGRectMake(0, _phoneNumView.bottom, kScreenWidth, 100);
    self.containerView.contentSize = CGSizeMake(0, 100);
}


#pragma mark -

- (void)saveBtnClick:(id)sender {
    
    if (![_emailTF.text validateEmail]) {
        [MBProgressHUD cwgj_showHUDWithText:@"请输入正确的邮箱"];
        return;
    }
    if (!_viewModel) {
        _viewModel = [MineViewModel new];
    }
    
    [_viewModel requestSaveUser:@""
             imageExtensionName:@""
                           name:@""
                      birthDate:@""
                         idType:@""
                           idNo:@""
                    mobilePhone:@""
                          email:_emailTF.text
                       complete:^(User *user) {
                           
                           if (user) {
                               [MBProgressHUD cwgj_showHUDWithText:@"修改成功"];
                               [[NSNotificationCenter defaultCenter] postNotificationName:@"kModifyInfoSuccess" object:nil];
                               
                               dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                                   [[NavManager shareInstance] returnToFrontView:YES];
                               });
                           }
                       }];
}


#pragma mark - getter

- (WRCellView *)phoneNumView {
    if (_phoneNumView == nil) {
        _phoneNumView = [[WRCellView alloc] initWithLineStyle:WRCellStyleLabel_];
        _phoneNumView.leftLabel.text = @"邮箱";
    }
    return _phoneNumView;
}

- (UIView *)footerView {
    if (!_footerView) {
        _footerView  = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 100)];
        
        UIButton *saveBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [saveBtn setFrame:CGRectMake(20, 20, kScreenWidth - 40, 44)];
        saveBtn.backgroundColor = ThemeColor;
        //[logoutBtn addTarget:self action:@selector(logoutBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [saveBtn setTitle:@"保存" forState:UIControlStateNormal];
        [saveBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [saveBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
        [saveBtn.titleLabel setFont:[UIFont systemFontOfSize:14]];
        saveBtn.layer.cornerRadius = 3;
        [saveBtn addTarget:self action:@selector(saveBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [_footerView addSubview:saveBtn];
        
        
    }
    return _footerView;
}


// Custom

- (UITextField *)emailTF {
    if (_emailTF == nil) {
        _emailTF = [[UITextField alloc] initWithFrame:CGRectMake(CustomViewX, 0, 175, WRCellViewHeight)];
        _emailTF.font = [UIFont systemFontOfSize:14];
        _emailTF.textColor = [UIColor darkTextColor];
        NSString *email = [UserManager manager].user.email;
        if (![Utils isBlankString:email]) {
            _emailTF.text = email;
        }else
            _emailTF.placeholder = @"请填写邮箱";
    }
    return _emailTF;
}


@end
