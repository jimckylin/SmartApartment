//
//  PersonInfoViewController.m
//  SmartApartment
//
//  Created by Jimcky Lin on 2017/8/20.
//  Copyright © 2017年 Jimcky Lin. All rights reserved.
//

#import "PersonInfoViewController.h"
#import "BookSuccessViewController.h"
#import "ModifyNameViewController.h"
#import "ModifyIdNoViewController.h"
#import "ModifyEmailViewController.h"

#import "WRCellView.h"

#import "SelectPhotoManager.h"
#import "HCGDatePickerAppearance.h"
#import "MineViewModel.h"

#define WRCellViewHeight  50
#define CustomViewX       110
#define CustomViewWidth   150

@interface PersonInfoViewController ()<UIAlertViewDelegate, UIActionSheetDelegate>

@property (nonatomic, strong) UIScrollView  *containerView;
@property (nonatomic, strong) WRCellView    *headerView;
@property (nonatomic, strong) WRCellView    *nameView;
@property (nonatomic, strong) WRCellView    *birthdayView;
@property (nonatomic, strong) WRCellView    *phoneView;
@property (nonatomic, strong) WRCellView    *certificateViewView;
@property (nonatomic, strong) WRCellView    *emailView;

@property (nonatomic, strong) UIImageView *avatarView;

@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *birthdayLabel;
@property (nonatomic, strong) UILabel *carNoLabel;
@property (nonatomic, strong) UILabel *emailLabel;

@property (nonatomic, strong) SelectPhotoManager *photoManager;
@property (nonatomic, strong) MineViewModel *mineViewModel;

@end


@implementation PersonInfoViewController

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:@"kModifyInfoSuccess"
                                                  object:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initData];
    [self initView];
    [self addViews];
    [self setCellFrame];
    [self onClickEvent];
}

- (void)initData {
    _mineViewModel = [MineViewModel new];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(refresh:)
                                                 name:@"kModifyInfoSuccess" object:nil];
}

- (void)initView {
    
    _naviLabel.text = @"个人资料";
    self.containerView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, kScreenWidth, self.view.bounds.size.height-64 - 60)];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.view addSubview:self.containerView];
    
    UIView *bottomViewBg = [UIView new];
    bottomViewBg.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:bottomViewBg];
    [bottomViewBg autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(0, 0, 0, 0) excludingEdge:ALEdgeTop];
    [bottomViewBg autoSetDimension:ALDimensionHeight toSize:60];
    
    UIButton *logoutBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    logoutBtn.backgroundColor = ThemeColor;
    [logoutBtn addTarget:self action:@selector(logoutBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [logoutBtn setTitle:@"退出" forState:UIControlStateNormal];
    [logoutBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [logoutBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
    [logoutBtn.titleLabel setFont:[UIFont systemFontOfSize:14]];
    logoutBtn.layer.cornerRadius = 3;
    [bottomViewBg addSubview:logoutBtn];
    
    [logoutBtn autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(8, 15, 10, 15)];
}

- (void)addViews {
    [self.containerView addSubview:self.headerView];
    [self.containerView addSubview:self.nameView];
    [self.containerView addSubview:self.birthdayView];
    [self.containerView addSubview:self.phoneView];
    [self.containerView addSubview:self.certificateViewView];
    [self.containerView addSubview:self.emailView];

    [self.headerView addSubview:self.avatarView];
    [self.nameView addSubview:self.nameLabel];
    [self.birthdayView addSubview:self.birthdayLabel];
    [self.certificateViewView addSubview:self.carNoLabel];
    [self.emailView addSubview:self.emailLabel];
}

- (void)setCellFrame {
    self.headerView.frame = CGRectMake(0, 30, kScreenWidth, 100);
    self.nameView.frame = CGRectMake(0, _headerView.bottom+10, kScreenWidth, WRCellViewHeight);
    self.birthdayView.frame = CGRectMake(0, _nameView.bottom, kScreenWidth, WRCellViewHeight);
    
    self.phoneView.frame = CGRectMake(0, _birthdayView.bottom, kScreenWidth, WRCellViewHeight);
    
    self.certificateViewView.frame = CGRectMake(0, _phoneView.bottom, kScreenWidth, WRCellViewHeight);
    self.emailView.frame = CGRectMake(0, _certificateViewView.bottom, kScreenWidth, WRCellViewHeight);
    
    if (self.emailView.bottom< (kScreenHeight -64-60)) {
        self.containerView.contentSize = CGSizeMake(0, (kScreenHeight -64-60 + 20));
    }else {
        self.containerView.contentSize = CGSizeMake(0, self.emailView.top + WRCellViewHeight + 60);
    }
}

- (void)onClickEvent {
    
    __weak typeof(self) weakSelf = self;
    
    // 头像点击
    self.headerView.tapBlock = ^ {
        __strong typeof(self) pThis = weakSelf;
        
        if (!pThis.photoManager) {
            pThis.photoManager =[[SelectPhotoManager alloc]init];
        }
        [pThis.photoManager startSelectPhotoWithImageName:@"选择头像"];
        //选取照片成功
        __WeakObj(pThis)
        pThis.photoManager.successHandle=^(SelectPhotoManager *manager,UIImage *image){
            
            pThisWeak.avatarView.image = image;
            //保存到本地
            NSData *data = UIImagePNGRepresentation(image);
            [[NSUserDefaults standardUserDefaults] setObject:data forKey:@"headerImage"];
            [pThisWeak requestUploadHeadImg:data];
        };
    };
    
    // 名字点击
    self.nameView.tapBlock = ^{
        ModifyNameViewController *vc = [ModifyNameViewController new];
        [[NavManager shareInstance] showViewController:vc isAnimated:YES];
    };
    
    // 生日点击
    self.birthdayView.tapBlock = ^{
        __strong typeof(self) pThis = weakSelf;
        HCGDatePickerAppearance *picker = [[HCGDatePickerAppearance alloc]initWithDatePickerMode:DatePickerDateMode completeBlock:^(NSDate *date) {
            NSString *formatStr = @"yyyy-MM-dd";
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            [dateFormatter setDateFormat:formatStr];
            [pThis requestSaveUserWithBirthday:[dateFormatter stringFromDate:date]];
        }];
        [picker show];
    };
    
    // 证件点击
    self.certificateViewView.tapBlock = ^{
        ModifyIdNoViewController *vc = [ModifyIdNoViewController new];
        [[NavManager shareInstance] showViewController:vc isAnimated:YES];
    };
    
    // 邮箱点击
    self.emailView.tapBlock = ^{
        ModifyEmailViewController *vc = [ModifyEmailViewController new];
        [[NavManager shareInstance] showViewController:vc isAnimated:YES];
    };
}

//照片选取成功
- (void)selectPhotoManagerDidFinishImage:(UIImage *)image {
    
    _headerView.rightIcon.image = image;
}


#pragma mark - UIButton Action

- (void)logoutBtnClick:(id)sender {
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"确定退出" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alertView show];
}


#pragma mark - UIAlertViewDelegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    if (buttonIndex == 1) {
        [[UserManager manager] removeUser];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"kLogoutSuccess" object:nil];
        [[NavManager shareInstance] returnToLoginView:YES];
    }
}


#pragma mark - UIActionSheetDelegate

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    if (buttonIndex == 0) {
        
    }else if (buttonIndex == 1) {
        
    }
}


#pragma mark - HttpRequest

- (void)requestUploadHeadImg:(NSData *)imageData {
    
    NSString *base64Str = [imageData base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    
    [_mineViewModel requestSaveUser:base64Str
                 imageExtensionName:@"png"
                               name:@""
                          birthDate:@""
                             idType:@""
                               idNo:@""
                        mobilePhone:@""
                              email:@""
                           complete:^(User *user) {
        
                               if (user) {
                                   [MBProgressHUD cwgj_showHUDWithText:@"修改成功"];
                               }
    }];
}

- (void)requestSaveUserWithBirthday:(NSString *)birthday {
    
    __WeakObj(self)
    [_mineViewModel requestSaveUser:@""
                 imageExtensionName:@""
                               name:@""
                          birthDate:birthday
                             idType:@""
                               idNo:@""
                        mobilePhone:@""
                              email:@""
                           complete:^(User *user) {
                               
                               if (user) {
                                   selfWeak.birthdayLabel.text = birthday;
                                   [MBProgressHUD cwgj_showHUDWithText:@"修改成功"];
                               }
                           }];
}


#pragma mark - Notification

- (void)refresh:(NSNotification *)noti {
    
    [_avatarView sd_setImageWithURL:[NSURL URLWithString:[UserManager manager].user.headImage]
                   placeholderImage:kImage(@"mine_headiphone")];
    _nameLabel.text = [UserManager manager].user.name;
    _birthdayLabel.text = [UserManager manager].user.birthdate;
    _carNoLabel.text = [UserManager manager].user.idNo;
    _emailLabel.text = [UserManager manager].user.email;
}



#pragma mark - getter

- (WRCellView *)headerView {
    if (_headerView == nil) {
        _headerView = [[WRCellView alloc] initWithLineStyle:WRCellStyleLabel_IconIndicator];
        _headerView.leftLabel.text = @"头像";
    }
    return _headerView;
}

- (WRCellView *)nameView {
    if (_nameView == nil) {
        _nameView = [[WRCellView alloc] initWithLineStyle:WRCellStyleLabel_LabelIndicator];
        _nameView.leftLabel.text = @"姓名";
    }
    return _nameView;
}

- (WRCellView *)birthdayView {
    if (_birthdayView == nil) {
        _birthdayView = [[WRCellView alloc] initWithLineStyle:WRCellStyleLabel_LabelIndicator];
        _birthdayView.leftLabel.text = @"出生日期";
    }
    return _birthdayView;
}

- (WRCellView *)phoneView {
    if (_phoneView == nil) {
        _phoneView = [[WRCellView alloc] initWithLineStyle:WRCellStyleLabel_LabelIndicator];
        _phoneView.leftLabel.text = @"手机";
        _phoneView.rightLabel.text = [UserManager manager].user.mobilePhone;
    }
    return _phoneView;
}

- (WRCellView *)certificateViewView {
    if (_certificateViewView == nil) {
        _certificateViewView = [[WRCellView alloc] initWithLineStyle:WRCellStyleLabel_LabelIndicator];
        _certificateViewView.leftLabel.text = @"证件号码";
    }
    return _certificateViewView;
}

- (WRCellView *)emailView {
    if (_emailView == nil) {
        _emailView = [[WRCellView alloc] initWithLineStyle:WRCellStyleLabel_LabelIndicator];
        _emailView.leftLabel.text = @"邮箱";
        [_emailView setLineStyleWithLeftZero];
    }
    return _emailView;
}


- (UIImageView *)avatarView {
    if (!_avatarView) {
        _avatarView = [[UIImageView alloc] initWithFrame:CGRectMake(kScreenWidth-80, 25, 50, 50)];
        _avatarView.contentMode = UIViewContentModeScaleAspectFill;
        _avatarView.clipsToBounds = YES;
        _avatarView.layer.cornerRadius = _avatarView.width/2;
        _avatarView.layer.masksToBounds = YES;
        [_avatarView sd_setImageWithURL:[NSURL URLWithString:[UserManager manager].user.headImage]
                                 placeholderImage:kImage(@"mine_headiphone")];
    }
    return _avatarView;
}

- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth-150, 15, 120, 20)];
        _nameLabel.textAlignment = NSTextAlignmentRight;
        _nameLabel.text = [UserManager manager].user.name;
        _nameLabel.textColor = [UIColor lightGrayColor];
        _nameLabel.font = [UIFont systemFontOfSize:14];
    }
    return _nameLabel;
}

- (UILabel *)birthdayLabel {
    if (!_birthdayLabel) {
        _birthdayLabel = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth-150, 15, 120, 20)];
        _birthdayLabel.textAlignment = NSTextAlignmentRight;
        _birthdayLabel.text = [UserManager manager].user.birthdate;
        _birthdayLabel.textColor = [UIColor lightGrayColor];
        _birthdayLabel.font = [UIFont systemFontOfSize:14];
    }
    return _birthdayLabel;
}

- (UILabel *)carNoLabel {
    if (!_carNoLabel) {
        _carNoLabel = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth-150, 15, 120, 20)];
        _carNoLabel.textAlignment = NSTextAlignmentRight;
        _carNoLabel.text = [UserManager manager].user.idNo;
        _carNoLabel.textColor = [UIColor lightGrayColor];
        _carNoLabel.font = [UIFont systemFontOfSize:14];
    }
    return _carNoLabel;
}

- (UILabel *)emailLabel {
    if (!_emailLabel) {
        _emailLabel = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth-150, 15, 120, 20)];
        _emailLabel.textAlignment = NSTextAlignmentRight;
        _emailLabel.text = [UserManager manager].user.email;
        _emailLabel.textColor = [UIColor lightGrayColor];
        _emailLabel.font = [UIFont systemFontOfSize:14];
    }
    return _emailLabel;
}


@end
