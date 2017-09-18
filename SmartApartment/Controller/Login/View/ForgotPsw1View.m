//
//  ForgotPsw1View.m
//  SmartApartment
//
//  Created by jimcky on 2017/9/18.
//  Copyright © 2017年 Jimcky Lin. All rights reserved.
//

#import "ForgotPsw1View.h"

#import "UITextField+PhoneTextField.h"
#import "UITextField+VerifyNoteTextField.h"
#import "UIButton+countDown.h"
#import "UIImage+Categories.h"

@interface ForgotPsw1View ()<UITextFieldDelegate,
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
@property (nonatomic, strong) UITextField     *verifyCodeTF;

@property (nonatomic, strong) UIButton        *verifyCodeBtn;
@property (nonatomic, strong) UIButton        *loginBtn;         // 登录按钮
@property (nonatomic, strong) UILabel         *verifyCodeLabel;  // 通过短信验证码登录

@property (nonatomic, strong) UIImageView     *phoneLine;
@property (nonatomic, strong) UIImageView     *verifyCodeLine;

@property (nonatomic, strong) UIButton        *forgotPwdBtn;      // 忘记密码按钮
@property (nonatomic, strong) UIButton        *registerBtn;       // 注册按钮

@end


@implementation ForgotPsw1View

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
    NSMutableAttributedString *aString = [[NSMutableAttributedString alloc]initWithString:@"11数字"];
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
    _pwdLabel.text = @"验证码";
    [_loginBgView addSubview:_pwdLabel];
    
    _verifyCodeTF = [[UITextField alloc] initWithFrame:CGRectZero];
    [_verifyCodeTF initVerifyNoteTextField];
    [_verifyCodeTF setTextColor:[UIColor blackColor]];
    [_verifyCodeTF setBackgroundColor:[UIColor clearColor]];
    [_verifyCodeTF setFont:[UIFont systemFontOfSize:17.f]];
    NSMutableAttributedString *string = [[NSMutableAttributedString alloc]initWithString:@"6为数字"];
    [string addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:15] range:NSMakeRange(0, string.length)];
    _verifyCodeTF.attributedPlaceholder = string;
    [_verifyCodeTF setPhoneDelegate:self];
    _verifyCodeTF.keyboardType = UIKeyboardTypeNumberPad;
    [self.loginBgView addSubview:_verifyCodeTF];
    
    // 发送验证码
    _verifyCodeBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 87, 32)];
    [_verifyCodeBtn setTitle:@"发送验证码" forState:UIControlStateNormal];
    _verifyCodeBtn.timeoutText = @"重新发送";
    _verifyCodeBtn.disableBackGroundColor = [UIColor whiteColor];
    
    [_verifyCodeBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    _verifyCodeBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    _verifyCodeBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [_verifyCodeBtn addTarget:self action:@selector(verifyCodeBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.loginBgView addSubview:_verifyCodeBtn];
    
    _verifyCodeLine = [[UIImageView alloc] init];
    _verifyCodeLine.image = image;
    _verifyCodeLine.highlightedImage = highlight;
    [self.loginBgView addSubview:_verifyCodeLine];
    
    
    // 登录
    _loginBtn = [[UIButton alloc] initWithFrame:CGRectZero];
    _loginBtn.layer.cornerRadius = 5;
    _loginBtn.layer.masksToBounds = YES;
    _loginBtn.layer.borderWidth = 0;
    
    [_loginBtn setBackgroundColor:ThemeColor];
    [_loginBtn.titleLabel setFont:[UIFont systemFontOfSize:17.0f]];
    [_loginBtn setTitle:@"下一步,重置密码" forState:UIControlStateNormal];
    [_loginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_loginBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.loginBgView addSubview:_loginBtn];
}


#pragma mark - UIButton Action

- (void)verifyCodeBtnClick:(id)sender {
    
    NSString *phone = [self.phoneTF getPhoneTextFieldText];
    if (!phone||phone.length <= 0) {
        return;
    }
    
    [self startCountDown];
    if ([self.delegate respondsToSelector:@selector(forgotPsw1ViewVerifyCodeBtnClick:)]) {
        [self.delegate forgotPsw1ViewVerifyCodeBtnClick:phone];
    }
}

- (void)btnClick:(id)sender {
    
    NSString *phone = [self.phoneTF getPhoneTextFieldText];
    if (!phone||phone.length <= 0) {
        return;
    }
    
    if ([Utils isBlankString:_verifyCodeTF.text] || [_verifyCodeTF.text length] < 6 || [_verifyCodeTF.text length] > 6) {
        [MBProgressHUD cwgj_showHUDWithText:@"请输入6位验证码"];
        return;
    }
    
    if ([self.delegate respondsToSelector:@selector(forgotPsw1ViewDidClickBtnAction:code:)]) {
        [self.delegate forgotPsw1ViewDidClickBtnAction:phone code:_verifyCodeTF.text];
    }
}


#pragma mark - Pravite

- (void)startCountDown {
    
    __WeakObj(self)
    [self.verifyCodeBtn startCountDown:30 timeOut:^{
        
    }];
}

- (void)phoneTextFieldBecomeFirstResponse {
    [self.phoneTF becomeFirstResponder];
}


#pragma mark - UITextField Delegate

-(void)textFieldDidBeginEditing:(UITextField *)textField {
    
    if ([textField isEqual:self.phoneTF]) {
        self.phoneLine.highlighted = YES;
    }else if ([textField isEqual:self.verifyCodeTF]){
        self.verifyCodeLine.highlighted = YES;
    }
}

-(void)textFieldDidEndEditing:(UITextField *)textField {
    
    if ([textField isEqual:self.phoneTF]) {
        self.phoneLine.highlighted = NO;
    }else if ([textField isEqual:self.verifyCodeTF]){
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
    
    if (textField.text.length >= 13 ) {//输入完成
        textField.text = [textField.text substringToIndex:13];
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
    
    [self.verifyCodeTF autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:padding + 70];
    [self.verifyCodeTF autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.phoneLine withOffset:30];
    [self.verifyCodeTF autoPinEdge:ALEdgeRight toEdge:ALEdgeLeft ofView:self.verifyCodeBtn];
    [self.verifyCodeTF autoSetDimension:ALDimensionHeight toSize:32];
    
    [self.verifyCodeBtn autoAlignAxis:ALAxisHorizontal toSameAxisOfView:self.verifyCodeTF];
    [self.verifyCodeBtn autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:padding];
    [self.verifyCodeBtn autoSetDimensionsToSize:CGSizeMake(87, 32)];
    
    [self.verifyCodeLine autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.verifyCodeTF withOffset:6];
    [self.verifyCodeLine autoSetDimension:ALDimensionHeight toSize:0.5];
    [self.verifyCodeLine autoPinEdgeToSuperviewEdge:ALEdgeLeading withInset:padding];
    [self.verifyCodeLine autoPinEdgeToSuperviewEdge:ALEdgeTrailing withInset:padding];
    
    [self.loginBtn autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.verifyCodeLine withOffset:30];
    [self.loginBtn autoSetDimension:ALDimensionHeight toSize:44.0f];
    [self.loginBtn autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:padding];
    [self.loginBtn autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:padding];
    
    [super updateConstraints];
}


@end
