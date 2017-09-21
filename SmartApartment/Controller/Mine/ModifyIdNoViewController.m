//
//  ModifyIdNoViewController.m
//  SmartApartment
//
//  Created by jimcky on 2017/9/21.
//  Copyright © 2017年 Jimcky Lin. All rights reserved.
//

#import "ModifyIdNoViewController.h"
#import "WRCellView.h"
#import "MineViewModel.h"

#define WRCellViewHeight  50
#define CustomViewX       110
#define CustomViewWidth   150

@interface ModifyIdNoViewController ()<UIActionSheetDelegate>

@property (nonatomic, strong) UIScrollView  *containerView;
@property (nonatomic, strong) WRCellView    *arriveTimeView;
@property (nonatomic, strong) WRCellView    *invoiceView;  // 发票

@property (nonatomic, strong) UILabel       *arriveTimeLabel;
@property (nonatomic, strong) UITextField   *idCarnumTF;
@property (nonatomic, strong) UIView        *footerView;

@property (nonatomic, assign) NSString      *certificateType; // 证件类型
@property (nonatomic, strong) MineViewModel *viewModel;



@end


@implementation ModifyIdNoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initView];
    [self addViews];
    [self setCellFrame];
    [self onClickEvent];
}

- (void)initView {
    _naviLabel.text = @"证件号码";
    self.containerView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, kScreenWidth, self.view.bounds.size.height-64 - 50)];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.view addSubview:self.containerView];
}

- (void)addViews {
    
    [self.containerView addSubview:self.arriveTimeView];
    [self.containerView addSubview:self.invoiceView];
    [self.containerView addSubview:self.footerView];
    
    [self.arriveTimeView addSubview:self.arriveTimeLabel];
    [self.invoiceView addSubview:self.idCarnumTF];
    
    
    
}

- (void)setCellFrame {
    
    self.arriveTimeView.frame = CGRectMake(0, 30 , kScreenWidth, WRCellViewHeight);
    self.invoiceView.frame = CGRectMake(0, _arriveTimeView.bottom, kScreenWidth, WRCellViewHeight);
    self.footerView.frame = CGRectMake(0, _invoiceView.bottom, kScreenWidth, 100);
    
    self.containerView.contentSize = CGSizeMake(0, kScreenHeight -64);
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
    
    [_viewModel requestSaveUser:@""
                 imageExtensionName:@""
                               name:@""
                          birthDate:@""
                             idType:self.certificateType
                               idNo:_idCarnumTF.text
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




- (UITextField *)idCarnumTF {
    if (_idCarnumTF == nil) {
        _idCarnumTF = [[UITextField alloc] initWithFrame:CGRectMake(CustomViewX, 0, 175, WRCellViewHeight)];
        _idCarnumTF.font = [UIFont systemFontOfSize:14];
        _idCarnumTF.textColor = [UIColor darkTextColor];
        
        NSString *idNo = [UserManager manager].user.idNo;
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
