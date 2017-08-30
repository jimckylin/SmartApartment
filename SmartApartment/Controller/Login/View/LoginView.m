//
//  CZDLoginView.m
//  CWGJCarOwner
//
//  Created by jimcky on 2017/7/18.
//  Copyright © 2017年 CheWeiGuanJia. All rights reserved.
//

#import "LoginView.h"

#import "UITextField+PhoneTextField.h"
#import "UITextField+VerifyNoteTextField.h"
#import "UIButton+countDown.h"
#import "UIImage+Categories.h"

@interface LoginView ()<UITextFieldDelegate,
                           PhoneTextFieldDelegate,
                           VerifyNoteTextFieldDelegate>

// 微信登录
@property (nonatomic, strong) UIView          *profileBgView;
@property (nonatomic, strong) UILabel         *welcomeLabel;
@property (nonatomic, strong) UIImageView     *headImageView;

// 手机登录
@property (nonatomic, strong) UIView          *loginBgView;
@property (nonatomic, strong) UILabel         *phoneLabel;
@property (nonatomic, strong) UILabel         *pwdLabel;
@property (nonatomic, strong) UITextField     *phoneTF;
@property (nonatomic, strong) UITextField     *passwordTF;

@property (nonatomic, strong) UIButton        *checkPwdBtn;      // 查看密码按钮
@property (nonatomic, strong) UIButton        *loginBtn;         // 登录按钮
@property (nonatomic, strong) UILabel         *verifyCodeLabel;  // 通过短信验证码登录

@property (nonatomic, strong) UIImageView     *phoneLine;
@property (nonatomic, strong) UIImageView     *verifyCodeLine;

@property (nonatomic, strong) UIButton        *forgotPwdBtn;      // 忘记密码按钮
@property (nonatomic, strong) UIButton        *registerBtn;       // 注册按钮

@end


@implementation LoginView

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
    _headImageView.image = kImage(@"logoiphone");
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
    NSMutableAttributedString *aString = [[NSMutableAttributedString alloc]initWithString:@"手机号/卡号"];
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
    
    
    // 密码输入框
    _pwdLabel = [UILabel new];
    _pwdLabel.textColor = [UIColor darkTextColor];
    _pwdLabel.font = [UIFont systemFontOfSize:15];
    _pwdLabel.text = @"密码";
    [_loginBgView addSubview:_pwdLabel];
    
    _passwordTF = [[UITextField alloc] initWithFrame:CGRectZero];
    _passwordTF.secureTextEntry = YES;
    [_passwordTF setTextColor:[UIColor blackColor]];
    [_passwordTF setBackgroundColor:[UIColor clearColor]];
    [_passwordTF setFont:[UIFont systemFontOfSize:17.f]];
    NSMutableAttributedString *string = [[NSMutableAttributedString alloc]initWithString:@"4-20位字母数字、和字符"];
    [string addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:15] range:NSMakeRange(0, string.length)];
    _passwordTF.attributedPlaceholder = string;
    [_passwordTF setVerifyNoteDelegate:self];
    _passwordTF.delegate = self;
    [self.loginBgView addSubview:_passwordTF];
    
    _checkPwdBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_checkPwdBtn setImage:kImage(@"login_password_hide_ic") forState:UIControlStateNormal];
    [_checkPwdBtn setImage:kImage(@"login_password_hshow_ic") forState:UIControlStateSelected];
    [_checkPwdBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    _checkPwdBtn.tag = CZDLoginActionViewPassword;
    [self.loginBgView addSubview:_checkPwdBtn];
    
    _verifyCodeLine = [[UIImageView alloc] init];
    _verifyCodeLine.image = image;
    _verifyCodeLine.highlightedImage = highlight;
    [self.loginBgView addSubview:_verifyCodeLine];
    
    
    // 登录
    _loginBtn = [[UIButton alloc] initWithFrame:CGRectZero];
    _loginBtn.layer.cornerRadius = 5;
    _loginBtn.layer.masksToBounds = YES;
    _loginBtn.layer.borderWidth = 0;
    _loginBtn.tag = CZDLoginActionLogin;
    
    [_loginBtn setBackgroundColor:ThemeColor];
    [_loginBtn.titleLabel setFont:[UIFont systemFontOfSize:17.0f]];
    [_loginBtn setTitle:@"登 录" forState:UIControlStateNormal];
    [_loginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_loginBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.loginBgView addSubview:_loginBtn];
    
    
    _verifyCodeLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _verifyCodeLabel.numberOfLines = 1;
    _verifyCodeLabel.tag = CZDLoginActionVerifyCodeLoginJump;
    [_verifyCodeLabel setBackgroundColor:[UIColor clearColor]];
    //[_protocolLabel setTextColor:RGBA(42, 122, 219,1.0f)];
    [_verifyCodeLabel setTextColor:[UIColor colorWithHexString:@"#1B88EE"]];
    [_verifyCodeLabel setFont:[UIFont systemFontOfSize:11.0f]];
    [_verifyCodeLabel setText:@"通过短信验证码登录"];
    [_verifyCodeLabel setUserInteractionEnabled:YES];
    [self.loginBgView addSubview:_verifyCodeLabel];
    
    UITapGestureRecognizer* singleRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(protocolLabelClick:)];
    //点击的次数
    singleRecognizer.numberOfTapsRequired = 1; // 单击
    [_verifyCodeLabel addGestureRecognizer:singleRecognizer];
    
    
    _forgotPwdBtn = [[UIButton alloc] initWithFrame:CGRectZero];
    [_forgotPwdBtn.titleLabel setFont:[UIFont systemFontOfSize:11.0f]];
    [_forgotPwdBtn setTitle:@"忘记密码?" forState:UIControlStateNormal];
    [_forgotPwdBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [_forgotPwdBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    _forgotPwdBtn.tag = CZDLoginActionForgotPwd;
    [self.loginBgView addSubview:_forgotPwdBtn];
    
    _registerBtn = [[UIButton alloc] initWithFrame:CGRectZero];
    [_registerBtn.titleLabel setFont:[UIFont systemFontOfSize:11.0f]];
    [_registerBtn setTitle:@"立即注册" forState:UIControlStateNormal];
    [_registerBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [_registerBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    _registerBtn.tag = CZDLoginActionRegister;
    [self.loginBgView addSubview:_registerBtn];
    
    UIView *line = [UIView new];
    line.backgroundColor = [UIColor lightGrayColor];
    [_loginBgView addSubview:line];
    [line autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:20];
    [line autoAlignAxisToSuperviewAxis:ALAxisVertical];
    [line autoSetDimensionsToSize:CGSizeMake(0.5, 20)];
}


#pragma mark - UIButton Action

- (void)btnClick:(id)sender {
    
    UIButton *btn = (UIButton *)sender;
    if (btn.tag == CZDLoginActionViewPassword) {
        btn.selected = !btn.selected;
        if (btn.selected) {
            _passwordTF.secureTextEntry = NO;
        }else {
            _passwordTF.secureTextEntry = YES;
        }
        return;
    }
    
    NSDictionary *param = @{};
    if (btn.tag == CZDLoginActionLogin) {
        
        NSString *phone = [self.phoneTF getPhoneTextFieldText];
        if (!phone||phone.length <= 0) {
            return;
        }
        
        NSString *pwd = self.passwordTF.text;
        if ([Utils isBlankString:pwd] || [pwd length]<4) {
            [MBProgressHUD cwgj_showHUDWithText:@"密码不为空或小于4位"];
            return;
        }
        param = @{@"paramPhone":phone, @"paramPsw":pwd};
    }
    
    
    if ([self.delegate respondsToSelector:@selector(loginViewDidClickBtnAction:param:)]) {
        [self.delegate loginViewDidClickBtnAction:btn.tag param:param];
    }
}

- (void)protocolLabelClick:(id)sender {
    
    UIGestureRecognizer *recognizer = (UIGestureRecognizer*)sender;
    UILabel *label = (UILabel*)[recognizer view];
    if ([self.delegate respondsToSelector:@selector(loginViewDidClickBtnAction:param:)]) {
        [self.delegate loginViewDidClickBtnAction:label.tag param:@{}];
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
    }else if ([textField isEqual:self.passwordTF]){
        self.verifyCodeLine.highlighted = YES;
    }
}

-(void)textFieldDidEndEditing:(UITextField *)textField {
    
    if ([textField isEqual:self.phoneTF]) {
        self.phoneLine.highlighted = NO;
    }else if ([textField isEqual:self.passwordTF]){
        self.verifyCodeLine.highlighted = NO;
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

- (void)VerifyNoteTextField:(UITextField *)VNTextField getVNTextFieldTextWithFail:(const NSString *)failError {
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
    
    // 密码输入框
    [self.pwdLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.phoneLine withOffset:30];
    [self.pwdLabel autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:padding];
    [self.pwdLabel autoSetDimension:ALDimensionHeight toSize:32];
    
    [self.passwordTF autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:padding + 70];
    [self.passwordTF autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.phoneLine withOffset:30];
    [self.passwordTF autoPinEdge:ALEdgeRight toEdge:ALEdgeLeft ofView:self.checkPwdBtn];
    [self.passwordTF autoSetDimension:ALDimensionHeight toSize:32];
    
    [self.checkPwdBtn autoAlignAxis:ALAxisHorizontal toSameAxisOfView:self.passwordTF];
    [self.checkPwdBtn autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:padding];
    [self.checkPwdBtn autoSetDimensionsToSize:CGSizeMake(60, 32)];
    
    [self.verifyCodeLine autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.passwordTF withOffset:6];
    [self.verifyCodeLine autoSetDimension:ALDimensionHeight toSize:0.5];
    [self.verifyCodeLine autoPinEdgeToSuperviewEdge:ALEdgeLeading withInset:padding];
    [self.verifyCodeLine autoPinEdgeToSuperviewEdge:ALEdgeTrailing withInset:padding];
    
    [self.loginBtn autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.verifyCodeLine withOffset:30];
    [self.loginBtn autoSetDimension:ALDimensionHeight toSize:44.0f];
    [self.loginBtn autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:padding];
    [self.loginBtn autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:padding];
    
    // 验证码登录
    [self.verifyCodeLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.loginBtn withOffset:15];
    [self.verifyCodeLabel autoAlignAxisToSuperviewAxis:ALAxisVertical];
    [self.verifyCodeLabel autoSetDimension:ALDimensionHeight toSize:20];
    
    // 底部按钮
    [_forgotPwdBtn autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:kScreenWidth/2];
    [_forgotPwdBtn autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:20];
    [_forgotPwdBtn autoSetDimensionsToSize:CGSizeMake(80, 20)];
    
    [_registerBtn autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:kScreenWidth/2];
    [_registerBtn autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:20];
    [_registerBtn autoSetDimensionsToSize:CGSizeMake(80, 20)];
    
    [super updateConstraints];
}


@end
