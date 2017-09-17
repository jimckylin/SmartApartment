//
//  VerifyCode1LoginView.m
//  SmartApartment
//
//  Created by jimcky on 2017/8/31.
//  Copyright © 2017年 Jimcky Lin. All rights reserved.
//

#import "VerifyCode1LoginView.h"

#import "UITextField+PhoneTextField.h"
#import "UITextField+VerifyNoteTextField.h"
#import "UIButton+countDown.h"
#import "UIImage+Categories.h"

@interface VerifyCode1LoginView ()<UITextFieldDelegate,
PhoneTextFieldDelegate>

// 微信登录
@property (nonatomic, strong) UIView          *profileBgView;
@property (nonatomic, strong) UILabel         *welcomeLabel;
@property (nonatomic, strong) UIImageView     *headImageView;

// 手机登录
@property (nonatomic, strong) UIView          *loginBgView;
@property (nonatomic, strong) UILabel         *phoneLabel;
@property (nonatomic, strong) UITextField     *phoneTF;

@property (nonatomic, strong) UIButton        *loginBtn;         // 登录按钮
@property (nonatomic, strong) UIImageView     *phoneLine;

@property (nonatomic, strong) UIButton        *forgotPwdBtn;      // 忘记密码按钮
@property (nonatomic, strong) UIButton        *registerBtn;       // 注册按钮

@end


@implementation VerifyCode1LoginView

- (instancetype)init {
    
    self = [super initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight-64)];
    if (self) {
        [self initData];
        [self initUI];
    }
    return self;
}

+ (BOOL)requiresConstraintBasedLayout {
    return YES;
}

- (void)initData {
    
}

- (void)initUI {
    
    _loginBgView = [UIView new];
    [self addSubview:_loginBgView];
    
    // 头像
    _headImageView = [UIImageView new];
    //    _headImageView.backgroundColor = [UIColor lightGrayColor];
    _headImageView.contentMode = UIViewContentModeScaleAspectFill;
    _headImageView.layer.cornerRadius = 4;
    _headImageView.layer.masksToBounds = YES;
    _headImageView.image = kImage(@"icon-83");
    [_loginBgView addSubview:_headImageView];
    
    // 手机号码输入框
    _phoneLabel = [UILabel new];
    _phoneLabel.textColor = [UIColor darkTextColor];
    _phoneLabel.font = [UIFont systemFontOfSize:15];
    _phoneLabel.text = @"手机";
    [_loginBgView addSubview:_phoneLabel];
    
    _phoneTF = [[UITextField alloc] initWithFrame:CGRectZero];
    [_phoneTF initPhoneTextField];
    _phoneTF.keyboardType = UIKeyboardTypeNumberPad;
    [_phoneTF setTextColor:[UIColor blackColor]];
    [_phoneTF setBackgroundColor:[UIColor clearColor]];
    [_phoneTF setFont:[UIFont systemFontOfSize:17.f]];
    NSMutableAttributedString *aString = [[NSMutableAttributedString alloc]initWithString:@"手机号"];
    [aString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:15] range:NSMakeRange(0, aString.length)];
    _phoneTF.attributedPlaceholder = aString;
    [_phoneTF setPhoneDelegate:self];
    _phoneTF.delegate = self;
    [_phoneTF addTarget:self action:@selector(phoneTextFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [self.loginBgView addSubview:_phoneTF];
    
    UIImage *image = [[UIImage imageWithColor:[UIColor colorWithHexString:@"#C3D0D7"]] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
    UIImage *highlight = [[UIImage imageWithColor:[UIColor colorWithHexString:@"#535C61"]] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
    
    _phoneLine = [[UIImageView alloc] init];
    _phoneLine.image = image;
    _phoneLine.highlightedImage = highlight;
    [self.loginBgView addSubview:_phoneLine];
    
    
    // 登录
    _loginBtn = [[UIButton alloc] initWithFrame:CGRectZero];
    _loginBtn.layer.cornerRadius = 5;
    _loginBtn.layer.masksToBounds = YES;
    _loginBtn.layer.borderWidth = 0;
    
    [_loginBtn setBackgroundColor:ThemeColor];
    [_loginBtn.titleLabel setFont:[UIFont systemFontOfSize:17.0f]];
    [_loginBtn setTitle:@"获取动态密码" forState:UIControlStateNormal];
    [_loginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_loginBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    _loginBtn.tag = VerifyCodeLoginActionGetVerifyCode;
    [self.loginBgView addSubview:_loginBtn];
    
    
    _forgotPwdBtn = [[UIButton alloc] initWithFrame:CGRectZero];
    [_forgotPwdBtn.titleLabel setFont:[UIFont systemFontOfSize:11.0f]];
    [_forgotPwdBtn setTitle:@"普通登录" forState:UIControlStateNormal];
    [_forgotPwdBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [_forgotPwdBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    _forgotPwdBtn.tag = VerifyCodeLoginActionNormalLogin;
    [self.loginBgView addSubview:_forgotPwdBtn];
    
    _registerBtn = [[UIButton alloc] initWithFrame:CGRectZero];
    [_registerBtn.titleLabel setFont:[UIFont systemFontOfSize:11.0f]];
    [_registerBtn setTitle:@"立即注册" forState:UIControlStateNormal];
    [_registerBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [_registerBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    _registerBtn.tag = VerifyCodeLoginActionRegitster;
    [self.loginBgView addSubview:_registerBtn];
    
}


#pragma mark - UIButton Action

- (void)btnClick:(UIButton *)sender {
    
    NSString *phone = @"";
    if (sender.tag == VerifyCodeLoginActionGetVerifyCode) {
        phone = [self.phoneTF getPhoneTextFieldText];
        if (!phone||phone.length <= 0) {
            return;
        }
    }
    
    if ([self.delegate respondsToSelector:@selector(verifyCode1LoginViewBtnClick:action:)]) {
        [self.delegate verifyCode1LoginViewBtnClick:phone action:sender.tag];
    }
}

#pragma mark - Public




#pragma mark - Pravite

- (void)phoneTextFieldBecomeFirstResponse {
    [self.phoneTF becomeFirstResponder];
}


#pragma mark - UITextField Delegate

-(void)textFieldDidBeginEditing:(UITextField *)textField {
    
    if ([textField isEqual:self.phoneTF]) {
        self.phoneLine.highlighted = YES;
    }
}

-(void)textFieldDidEndEditing:(UITextField *)textField {
    
    if ([textField isEqual:self.phoneTF]) {
        self.phoneLine.highlighted = NO;
    }
}

- (void)phoneTextFieldDidChange:(UITextField *)textField {
    
    NSMutableString *phoneString = [NSMutableString string];
    textField.text = [textField.text stringByReplacingOccurrencesOfString:@" " withString:@""];
    [phoneString appendString:textField.text];
    
    if (textField.text.length > 3 && textField.text.length < 8) {
        [phoneString insertString:@" " atIndex:3];
        textField.text = phoneString;
        
    }else if (textField.text.length >= 8 ) {
        [phoneString insertString:@" " atIndex:3];
        [phoneString insertString:@" " atIndex:8];
        textField.text = phoneString;
    }
}


#pragma mark - PhoneTextFieldDelegate

- (void)PhoneTextField:(UITextField *)phoneTextField getPhoneTextFieldTextWithFail:(const NSString *)failError {
    [MBProgressHUD cwgj_showHUDWithText:[NSString stringWithFormat:@"%@",failError]];
}


#pragma mark - NSLayoutConstraints

- (void)updateConstraints {
    
    CGFloat padding = 27.0f;
    [self.loginBgView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
    
    [self.headImageView autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:35];
    [self.headImageView autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:(kScreenWidth-80)/2];
    [self.headImageView autoSetDimensionsToSize:CGSizeMake(80, 80)];
    
    // 手机号输入框
    [self.phoneLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.headImageView withOffset:40];
    [self.phoneLabel autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:padding];
    [self.phoneLabel autoSetDimension:ALDimensionHeight toSize:32];
    
    [self.phoneTF autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.headImageView withOffset:40];
    [self.phoneTF autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:padding + 70];
    [self.phoneTF autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:padding];
    [self.phoneTF autoSetDimension:ALDimensionHeight toSize:32];
    
    [self.phoneLine autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.phoneTF withOffset:6];
    [self.phoneLine autoSetDimension:ALDimensionHeight toSize:0.5];
    [self.phoneLine autoPinEdgeToSuperviewEdge:ALEdgeLeading withInset:padding];
    [self.phoneLine autoPinEdgeToSuperviewEdge:ALEdgeTrailing withInset:padding];
    
    [self.loginBtn autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.phoneLine withOffset:30];
    [self.loginBtn autoSetDimension:ALDimensionHeight toSize:44.0f];
    [self.loginBtn autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:padding];
    [self.loginBtn autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:padding];
    
    // 底部按钮
    [_forgotPwdBtn autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.loginBtn withOffset:20];
    [_forgotPwdBtn autoAlignAxisToSuperviewAxis:ALAxisVertical];
    [_forgotPwdBtn autoSetDimensionsToSize:CGSizeMake(80, 20)];
    
    [_registerBtn autoAlignAxisToSuperviewAxis:ALAxisVertical];
    [_registerBtn autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:20];
    [_registerBtn autoSetDimensionsToSize:CGSizeMake(80, 20)];
    
    [super updateConstraints];
}


@end
