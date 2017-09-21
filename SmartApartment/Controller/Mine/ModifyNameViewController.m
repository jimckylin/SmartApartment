//
//  ModifyNameViewController.m
//  SmartApartment
//
//  Created by jimcky on 2017/9/21.
//  Copyright © 2017年 Jimcky Lin. All rights reserved.
//

#import "ModifyNameViewController.h"
#import "WRCellView.h"
#import "MineViewModel.h"

#define WRCellViewHeight  50
#define CustomViewX       110
#define CustomViewWidth   150

@interface ModifyNameViewController ()<UIActionSheetDelegate>

@property (nonatomic, strong) UIScrollView  *containerView;
@property (nonatomic, strong) WRCellView    *phoneNumView;

@property (nonatomic, strong) UITextField   *nameTF;
@property (nonatomic, strong) UIView        *footerView;

@property (nonatomic, strong) MineViewModel *viewModel;

@end


@implementation ModifyNameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initView];
    [self addViews];
    [self setCellFrame];
}

- (void)initView {
    _naviLabel.text = @"姓名";
    self.containerView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, kScreenWidth, self.view.bounds.size.height-64 - 50)];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.view addSubview:self.containerView];
}

- (void)addViews {
    
    [self.containerView addSubview:self.phoneNumView];
    [self.containerView addSubview:self.footerView];
    
    [self.phoneNumView addSubview:self.nameTF];
}

- (void)setCellFrame {
    
    self.phoneNumView.frame = CGRectMake(0, 30, kScreenWidth, WRCellViewHeight);
    self.footerView.frame = CGRectMake(0, _phoneNumView.bottom, kScreenWidth, 100);
    self.containerView.contentSize = CGSizeMake(0, 100);
}


#pragma mark -

- (void)saveBtnClick:(id)sender {
    
    if (!_viewModel) {
        _viewModel = [MineViewModel new];
    }
    
    [_viewModel requestSaveUser:@""
             imageExtensionName:@""
                           name:_nameTF.text
                      birthDate:@""
                         idType:@""
                           idNo:@""
                    mobilePhone:@""
                          email:@""
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
        _phoneNumView.leftLabel.text = @"姓名";
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

- (UITextField *)nameTF {
    if (_nameTF == nil) {
        _nameTF = [[UITextField alloc] initWithFrame:CGRectMake(CustomViewX, 0, 175, WRCellViewHeight)];
        _nameTF.font = [UIFont systemFontOfSize:14];
        _nameTF.textColor = [UIColor darkTextColor];
        NSString *email = [UserManager manager].user.name;
        if (![Utils isBlankString:email]) {
            _nameTF.text = email;
        }else
            _nameTF.placeholder = @"请输入姓名";
    }
    return _nameTF;
}


@end
