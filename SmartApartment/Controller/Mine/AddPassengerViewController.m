//
//  AddPassengerViewController.m
//  SmartApartment
//
//  Created by Jimcky Lin on 2017/8/20.
//  Copyright © 2017年 Jimcky Lin. All rights reserved.
//

#import "AddPassengerViewController.h"
#import "WRCellView.h"
#import "MineViewModel.h"

#define WRCellViewHeight  50
#define CustomViewX       110
#define CustomViewWidth   150

@interface AddPassengerViewController ()<UIActionSheetDelegate>

@property (nonatomic, strong) UIScrollView  *containerView;
@property (nonatomic, strong) WRCellView    *roomNumView;
@property (nonatomic, strong) WRCellView    *livePersonView;
@property (nonatomic, strong) WRCellView    *phoneNumView;
@property (nonatomic, strong) WRCellView    *arriveTimeView;
@property (nonatomic, strong) WRCellView    *invoiceView;  // 发票
@property (nonatomic, strong) WRCellView    *remarkView;
@property (nonatomic, strong) WRCellView    *tipView;

@property (nonatomic, strong) UITextField   *nameTF;
@property (nonatomic, strong) UITextField   *phoneNumTF;
@property (nonatomic, strong) UITextField   *emailTF;
@property (nonatomic, strong) UILabel       *arriveTimeLabel;
@property (nonatomic, strong) UITextField   *idCarnumTF;

@property (nonatomic, strong) UIView        *footerView;


@property (nonatomic, assign) NSString      *certificateType; // 证件类型
@property (nonatomic, strong) MineViewModel *viewModel;



@end


@implementation AddPassengerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initView];
    [self addViews];
    [self setCellFrame];
    [self onClickEvent];
}

- (void)initView {
    if (self.contact) {
        _naviLabel.text = @"修改常用旅客";
    }else
        _naviLabel.text = @"新增常用旅客";
    self.containerView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, kScreenWidth, self.view.bounds.size.height-64 - 50)];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.view addSubview:self.containerView];
}

- (void)addViews {
    [self.containerView addSubview:self.roomNumView];
    [self.containerView addSubview:self.livePersonView];
    [self.containerView addSubview:self.phoneNumView];
    [self.containerView addSubview:self.arriveTimeView];
    [self.containerView addSubview:self.invoiceView];
    [self.containerView addSubview:self.remarkView];
    [self.containerView addSubview:self.tipView];
    [self.containerView addSubview:self.footerView];
    
    [self.roomNumView addSubview:self.nameTF];
    [self.livePersonView addSubview:self.phoneNumTF];
    [self.phoneNumView addSubview:self.emailTF];
    [self.arriveTimeView addSubview:self.arriveTimeLabel];
    
    [self.invoiceView addSubview:self.idCarnumTF];

    

}

- (void)setCellFrame {
    self.roomNumView.frame = CGRectMake(0, 30, kScreenWidth, WRCellViewHeight);
    self.livePersonView.frame = CGRectMake(0, _roomNumView.bottom, kScreenWidth, WRCellViewHeight);
    self.phoneNumView.frame = CGRectMake(0, _livePersonView.bottom, kScreenWidth, WRCellViewHeight);
    
    self.arriveTimeView.frame = CGRectMake(0, _phoneNumView.bottom , kScreenWidth, WRCellViewHeight);
    
    self.invoiceView.frame = CGRectMake(0, _arriveTimeView.bottom, kScreenWidth, WRCellViewHeight);
    self.remarkView.frame = CGRectMake(0, _invoiceView.bottom, kScreenWidth, WRCellViewHeight);
    self.tipView.frame = CGRectMake(0, _remarkView.bottom, kScreenWidth, WRCellViewHeight);
    self.footerView.frame = CGRectMake(0, _invoiceView.bottom, kScreenWidth, 100);
    
    if (self.tipView.bottom< (kScreenHeight -64-50)) {
        self.containerView.contentSize = CGSizeMake(0, (kScreenHeight -64-50 + 20));
    }else {
        self.containerView.contentSize = CGSizeMake(0, self.remarkView.top + WRCellViewHeight + 50);
    }
}

- (void)onClickEvent {
    
    __weak typeof(self) weakSelf = self;
    self.arriveTimeView.tapBlock = ^ {
        __strong typeof(self) pThis = weakSelf;
        UIActionSheet *actionsheet = [[UIActionSheet alloc] initWithTitle:@"证件类型" delegate:pThis cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"身份证", @"学生证", @"其他证件", nil];
        [actionsheet showInView:pThis.view];
    };
}


#pragma mark - UIActionSheetDelegate

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    // 证件类型：0-身份证，1-学生证，2-其他证件
    if (buttonIndex == 0) {
        self.certificateType = @"0";
        _arriveTimeLabel.text = @"居民身份证";
    }else if (buttonIndex == 1) {
        self.certificateType = @"1";
        _arriveTimeLabel.text = @"学生证";
    }else if (buttonIndex == 1) {
        self.certificateType = @"2";
        _arriveTimeLabel.text = @"其他证件";
    }
}


#pragma mark -

- (void)saveBtnClick:(id)sender {
    
    if (!_viewModel) {
        _viewModel = [MineViewModel new];
    }
    
    __WeakObj(self)
    [_viewModel requestSaveCommonInfo:_nameTF.text
                               idType:self.certificateType
                                 idNo:_idCarnumTF.text
                          mobilePhone:_phoneNumTF.text
                                email:_emailTF.text
                            checkInNo:self.contact[@"checkInNo"]
                             complete:^(BOOL isSuccess) {
       
                                 if (isSuccess) {
                                     if (selfWeak.contact) {
                                         [MBProgressHUD cwgj_showHUDWithText:@"修改成功"];
                                     }else
                                         [MBProgressHUD cwgj_showHUDWithText:@"新增成功"];
                                     
                                     if (selfWeak.didAddOrModifyUserInfo) {
                                         selfWeak.didAddOrModifyUserInfo();
                                     }
                                     dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                                         [[NavManager shareInstance] returnToFrontView:YES];
                                     });
                                 }
    }];
    
}


#pragma mark - getter

- (WRCellView *)roomNumView {
    if (_roomNumView == nil) {
        _roomNumView = [[WRCellView alloc] initWithLineStyle:WRCellStyleLabel_];
        _roomNumView.leftLabel.text = @"姓名";
    }
    return _roomNumView;
}

- (WRCellView *)livePersonView {
    if (_livePersonView == nil) {
        _livePersonView = [[WRCellView alloc] initWithLineStyle:WRCellStyleLabel_];
        _livePersonView.leftLabel.text = @"手机号";
    }
    return _livePersonView;
}

- (WRCellView *)phoneNumView {
    if (_phoneNumView == nil) {
        _phoneNumView = [[WRCellView alloc] initWithLineStyle:WRCellStyleLabel_];
        _phoneNumView.leftLabel.text = @"邮箱";
    }
    return _phoneNumView;
}

- (WRCellView *)arriveTimeView {
    if (_arriveTimeView == nil) {
        _arriveTimeView = [[WRCellView alloc] initWithLineStyle:WRCellStyleLabel_Indicator];
        _arriveTimeView.leftLabel.text = @"证件类型";
    }
    return _arriveTimeView;
}

- (WRCellView *)invoiceView {
    if (_invoiceView == nil) {
        _invoiceView = [[WRCellView alloc] initWithLineStyle:WRCellStyleLabel_];
        _invoiceView.leftLabel.text = @"证件号码";
    }
    return _invoiceView;
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
        NSString *name = self.contact[@"name"];
        if (![Utils isBlankString:name]) {
            _nameTF.text = self.contact[@"name"];
        }else
            _nameTF.placeholder = @"请填写姓名";
    }
    return _nameTF;
}

- (UITextField *)phoneNumTF {
    if (_phoneNumTF == nil) {
        _phoneNumTF = [[UITextField alloc] initWithFrame:CGRectMake(CustomViewX, 0, 175, WRCellViewHeight)];
        _phoneNumTF.font = [UIFont systemFontOfSize:14];
        _phoneNumTF.textColor = [UIColor darkTextColor];
        NSString *phone = self.contact[@"mobilePhone"];
        if (![Utils isBlankString:phone]) {
            _phoneNumTF.text = phone;
        }else
            _phoneNumTF.placeholder = @"请填写手机号码";
    }
    return _phoneNumTF;
}

- (UITextField *)emailTF {
    if (_emailTF == nil) {
        _emailTF = [[UITextField alloc] initWithFrame:CGRectMake(CustomViewX, 0, 175, WRCellViewHeight)];
        _emailTF.font = [UIFont systemFontOfSize:14];
        _emailTF.textColor = [UIColor darkTextColor];
        NSString *email = self.contact[@"email"];
        if (![Utils isBlankString:email]) {
            _emailTF.text = email;
        }else
            _emailTF.placeholder = @"请填写邮箱";
    }
    return _emailTF;
}

- (UITextField *)idCarnumTF {
    if (_idCarnumTF == nil) {
        _idCarnumTF = [[UITextField alloc] initWithFrame:CGRectMake(CustomViewX, 0, 175, WRCellViewHeight)];
        _idCarnumTF.font = [UIFont systemFontOfSize:14];
        _idCarnumTF.textColor = [UIColor darkTextColor];
        NSString *idNo = self.contact[@"idNo"];
        if (![Utils isBlankString:idNo]) {
            _idCarnumTF.text = idNo;
        }else
            _idCarnumTF.placeholder = @"请填写证件号码";
    }
    return _idCarnumTF;
}


- (UILabel *)arriveTimeLabel {
    if (_arriveTimeLabel == nil) {
        _arriveTimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(CustomViewX, 0, 175, WRCellViewHeight)];
        _arriveTimeLabel.text = @"居民身份证";
    }
    return _arriveTimeLabel;
}

@end
