//
//  Register2View.m
//  SmartApartment
//
//  Created by jimcky on 2017/8/29.
//  Copyright © 2017年 Jimcky Lin. All rights reserved.
//

#import "Register2View.h"
#import "UIImage+Categories.h"
#import "UIButton+countDown.h"

@interface Register2View ()<UITextFieldDelegate>

// 微信登录
@property (nonatomic, strong) UIView          *profileBgView;
@property (nonatomic, strong) UIImageView     *headImageView;

// 手机登录
@property (nonatomic, strong) UIView          *loginBgView;
@property (nonatomic, strong) UILabel         *pwdLabel;
@property (nonatomic, strong) UITextField     *verifyCodeTF;
@property (nonatomic, strong) UIButton        *verifyCodeBtn;

@property (nonatomic, strong) UIButton        *settingPwdBtn;

@property (nonatomic, strong) UIImageView     *phoneLine;



@end


@implementation Register2View

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
    
    // 设置密码输入框
    _pwdLabel = [UILabel new];
    _pwdLabel.textColor = [UIColor darkTextColor];
    _pwdLabel.font = [UIFont systemFontOfSize:15];
    _pwdLabel.text = @"验证码";
    [_loginBgView addSubview:_pwdLabel];
    
    _verifyCodeTF = [[UITextField alloc] initWithFrame:CGRectZero];
    [_verifyCodeTF setTextColor:[UIColor blackColor]];
    [_verifyCodeTF setBackgroundColor:[UIColor clearColor]];
    [_verifyCodeTF setFont:[UIFont systemFontOfSize:17.f]];
    NSMutableAttributedString *string = [[NSMutableAttributedString alloc]initWithString:@"6为数字"];
    [string addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:15] range:NSMakeRange(0, string.length)];
    _verifyCodeTF.attributedPlaceholder = string;
    _verifyCodeTF.delegate = self;
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
    _verifyCodeTF.keyboardType = UIKeyboardTypeNumberPad;
    [self.loginBgView addSubview:_verifyCodeBtn];
    
    UIImage *image = [[UIImage imageWithColor:[UIColor colorWithHexString:@"#C3D0D7"]] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
    UIImage *highlight = [[UIImage imageWithColor:[UIColor colorWithHexString:@"#535C61"]] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
    
    _phoneLine = [[UIImageView alloc] init];
    _phoneLine.image = image;
    _phoneLine.highlightedImage = highlight;
    [self.loginBgView addSubview:_phoneLine];
    
    // 设置密码
    _settingPwdBtn = [[UIButton alloc] initWithFrame:CGRectZero];
    _settingPwdBtn.layer.cornerRadius = 5;
    _settingPwdBtn.layer.masksToBounds = YES;
    _settingPwdBtn.layer.borderWidth = 0;
    
    [_settingPwdBtn setBackgroundColor:ThemeColor];
    [_settingPwdBtn.titleLabel setFont:[UIFont systemFontOfSize:17.0f]];
    [_settingPwdBtn setTitle:@"下一步:设置密码" forState:UIControlStateNormal];
    [_settingPwdBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_settingPwdBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.loginBgView addSubview:_settingPwdBtn];
}


#pragma mark - UIButton Action

- (void)verifyCodeBtnClick:(id)sender {
    
    [self startCountDown];
    if ([self.delegate respondsToSelector:@selector(register2ViewVerifyCodeBtnClick)]) {
        [self.delegate register2ViewVerifyCodeBtnClick];
    }
}

- (void)btnClick:(id)sender {
    
    if ([Utils isBlankString:_verifyCodeTF.text] || [_verifyCodeTF.text length] < 6 || [_verifyCodeTF.text length] > 6) {
        [MBProgressHUD cwgj_showHUDWithText:@"请输入6位验证码"];
        return;
    }
    
    if ([self.delegate respondsToSelector:@selector(register2ViewBtnClick:)]) {
        [self.delegate register2ViewBtnClick:_verifyCodeTF.text];
    }
}


#pragma mark - Public

- (void)startCountDown {
    
    __WeakObj(self)
    [self.verifyCodeBtn startCountDown:30 timeOut:^{
        
    }];
}


#pragma mark - UITextField Delegate

-(void)textFieldDidBeginEditing:(UITextField *)textField {
    
    if ([textField isEqual:self.verifyCodeTF]) {
        self.phoneLine.highlighted = YES;
    }
}

-(void)textFieldDidEndEditing:(UITextField *)textField {
    
    if ([textField isEqual:self.verifyCodeTF]) {
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
    
    // 输入验证码
    [self.pwdLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.headImageView withOffset:40];
    [self.pwdLabel autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:padding];
    [self.pwdLabel autoSetDimension:ALDimensionHeight toSize:32];
    
    [self.verifyCodeTF autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.headImageView withOffset:40];
    [self.verifyCodeTF autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:padding + 70];
    [self.verifyCodeTF autoPinEdge:ALEdgeRight toEdge:ALEdgeLeft ofView:self.verifyCodeBtn];
    [self.verifyCodeTF autoSetDimension:ALDimensionHeight toSize:32];
    
    [self.verifyCodeBtn autoAlignAxis:ALAxisHorizontal toSameAxisOfView:self.verifyCodeTF];
    [self.verifyCodeBtn autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:padding];
    [self.verifyCodeBtn autoSetDimensionsToSize:CGSizeMake(87, 32)];
    
    [self.phoneLine autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.verifyCodeTF withOffset:6];
    [self.phoneLine autoSetDimension:ALDimensionHeight toSize:0.5];
    [self.phoneLine autoPinEdgeToSuperviewEdge:ALEdgeLeading withInset:padding];
    [self.phoneLine autoPinEdgeToSuperviewEdge:ALEdgeTrailing withInset:padding];
    
    [self.settingPwdBtn autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.phoneLine withOffset:30];
    [self.settingPwdBtn autoSetDimension:ALDimensionHeight toSize:44.0f];
    [self.settingPwdBtn autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:padding];
    [self.settingPwdBtn autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:padding];
    
    [super updateConstraints];
}

@end
