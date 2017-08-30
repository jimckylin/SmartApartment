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
@property (nonatomic, strong) UITextField     *phoneTF;
@property (nonatomic, strong) UITextField     *verifyCodeTF;

@property (nonatomic, strong) UIButton        *verifyCodeBtn;  // 验证码按钮
@property (nonatomic, strong) UIButton        *checkPwdBtn;    // 查看密码按钮
@property (nonatomic, strong) UIButton        *loginBtn;       // 登录按钮
@property (nonatomic, strong) UILabel         *protocolMarkLabel;
@property (nonatomic, strong) UILabel         *protocolLabel;

@property (nonatomic, strong) UIImageView     *phoneLine;
@property (nonatomic, strong) UIImageView     *verifyCodeLine;


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
    _headImageView = [[UIImageView alloc] initWithImage:kImage(@"logoiphone")];
    _headImageView.backgroundColor = [UIColor lightGrayColor];
    _headImageView.contentMode = UIViewContentModeScaleAspectFill;
    _headImageView.layer.cornerRadius = 4;
    _headImageView.layer.masksToBounds = YES;
    [_loginBgView addSubview:_headImageView];
    
    // 手机号码输入框
    _phoneTF = [[UITextField alloc] initWithFrame:CGRectZero];
    [_phoneTF initPhoneTextField];
    _phoneTF.keyboardType = UIKeyboardTypeNumberPad;
    [_phoneTF setTextColor:[UIColor blackColor]];
    [_phoneTF setBackgroundColor:[UIColor clearColor]];
    [_phoneTF setFont:[UIFont systemFontOfSize:20.f]];
    NSMutableAttributedString *aString = [[NSMutableAttributedString alloc]initWithString:@"输入手机号码"];
    [aString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:17] range:NSMakeRange(0, 6)];
    _phoneTF.attributedPlaceholder = aString;
    //[_phoneTextField setPlaceholder:@"输入手机号码"];
    [_phoneTF setPhoneDelegate:self];
    _phoneTF.delegate = self;
    [_phoneTF addTarget:self action:@selector(phoneTextFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [self.loginBgView addSubview:_phoneTF];
    
    _verifyCodeBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 87, 32)];
    _verifyCodeBtn.tag = CZDLoginActionVerifyCodeSend;
    [_verifyCodeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    _verifyCodeBtn.timeoutText = @"重新发送";
    _verifyCodeBtn.disableBackGroundColor = [UIColor whiteColor];
    
    [_verifyCodeBtn setTitleColor:[UIColor colorWithHexString:@"#D8DFE7"] forState:UIControlStateNormal];
    _verifyCodeBtn.layer.cornerRadius = 5;
    _verifyCodeBtn.layer.borderWidth = 0.5;
    _verifyCodeBtn.layer.borderColor = [UIColor colorWithHexString:@"#D8DFE7"].CGColor;
    _verifyCodeBtn.backgroundColor = [UIColor whiteColor];
    _verifyCodeBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    _verifyCodeBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    [_verifyCodeBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    _verifyCodeBtn.enabled = NO;
    [self.loginBgView addSubview:_verifyCodeBtn];
    
    UIImage *image = [[UIImage imageWithColor:[UIColor colorWithHexString:@"#C3D0D7"]] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
    UIImage *highlight = [[UIImage imageWithColor:[UIColor colorWithHexString:@"#535C61"]] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
    
    _phoneLine = [[UIImageView alloc] init];
    _phoneLine.image = image;
    _phoneLine.highlightedImage = highlight;
    [self.loginBgView addSubview:_phoneLine];
    
    
    // 验证码输入框
    _verifyCodeTF = [[UITextField alloc] initWithFrame:CGRectZero];
    [_verifyCodeTF initVerifyNoteTextField];
    _verifyCodeTF.keyboardType = UIKeyboardTypeNumberPad;
    [_verifyCodeTF setTextColor:[UIColor blackColor]];
    [_verifyCodeTF setBackgroundColor:[UIColor clearColor]];
    [_verifyCodeTF setFont:[UIFont systemFontOfSize:20.f]];
    NSMutableAttributedString *string = [[NSMutableAttributedString alloc]initWithString:@"验证码"];
    [string addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:17] range:NSMakeRange(0, 3)];
    _verifyCodeTF.attributedPlaceholder = string;
    [_verifyCodeTF setVerifyNoteDelegate:self];
    _verifyCodeTF.delegate = self;
    [self.loginBgView addSubview:_verifyCodeTF];
    
    _checkPwdBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_checkPwdBtn setImage:kImage(@"login_password_hide_ic") forState:UIControlStateNormal];
    [_checkPwdBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
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
    
    [_loginBtn setBackgroundColor:[UIColor colorWithHexString:@"#D8DFE7"]];
    [_loginBtn.titleLabel setFont:[UIFont systemFontOfSize:17.0f]];
    [_loginBtn setTitle:@"登 录" forState:UIControlStateNormal];
    [_loginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_loginBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.loginBgView addSubview:_loginBtn];
    
    _protocolMarkLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _protocolMarkLabel.numberOfLines = 1;
    [_protocolMarkLabel setBackgroundColor:[UIColor clearColor]];
    [_protocolMarkLabel setTextColor:[UIColor colorWithHexString:@"#888888"]];
    [_protocolMarkLabel setFont:[UIFont systemFontOfSize:11.0f]];
    [_protocolMarkLabel setText:@"点击登录，即阅读并同意"];
    [self.loginBgView addSubview:_protocolMarkLabel];
    
    _protocolLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _protocolLabel.numberOfLines = 1;
    _protocolLabel.tag = CZDLoginActionProtocol;
    [_protocolLabel setBackgroundColor:[UIColor clearColor]];
    //[_protocolLabel setTextColor:RGBA(42, 122, 219,1.0f)];
    [_protocolLabel setTextColor:[UIColor colorWithHexString:@"#1B88EE"]];
    [_protocolLabel setFont:[UIFont systemFontOfSize:11.0f]];
    [_protocolLabel setText:@"《软件许可及服务协议》"];
    [_protocolLabel setUserInteractionEnabled:YES];
    [self.loginBgView addSubview:_protocolLabel];
    
    UITapGestureRecognizer* singleRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(protocolLabelClick:)];
    //点击的次数
    singleRecognizer.numberOfTapsRequired = 1; // 单击
    [_protocolLabel addGestureRecognizer:singleRecognizer];
}


#pragma mark - UIButton Action

- (void)btnClick:(id)sender {
    
    [self.phoneTF resignFirstResponder];
    [self.verifyCodeTF resignFirstResponder];
    
    NSDictionary *param = @{};
    UIButton *btn = (UIButton *)sender;
    NSString *phone = [self.phoneTF getPhoneTextFieldText];
    if (!phone||phone.length <= 0) {
        return;
    }
    
    if (btn.tag == CZDLoginActionLogin || btn.tag == CZDLoginActionWXOAuthLogin) {
        NSString *code = [self.verifyCodeTF getVerifyNoteTextFieldText];
        if (!code||code.length <= 0) {
            return;
        }
        param = @{@"paramPhone":phone, @"paramCode":code};
    }else {
        param = @{@"paramPhone":phone};
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

- (void)startCountDown {
    
    __WeakObj(self)
    [self.verifyCodeBtn startCountDown:30 timeOut:^{
        selfWeak.verifyCodeBtn.layer.borderColor = [UIColor colorWithHexString:@"#535C61"].CGColor;
        selfWeak.verifyCodeBtn.enabled = YES;
    }];
    self.verifyCodeBtn.backgroundColor = [UIColor colorWithHexString:@"#EEF3F6"];
    self.verifyCodeBtn.layer.borderColor = [UIColor clearColor].CGColor;
}

- (void)setUserInfo:(NSDictionary *)userInfo {
    
    self.welcomeLabel.text = [NSString stringWithFormat:@"欢迎您,%@",[userInfo objectForKey:@"nickname"]];
    NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:[userInfo objectForKey:@"headimgurl"]]];
    self.headImageView.image = [UIImage imageWithData:imageData];
    
    _userInfo = userInfo;
}


#pragma mark - Pravite

- (void)setLoginBtnEnabled:(BOOL)enabled {
    if (enabled) {
        [self.loginBtn setBackgroundColor:[UIColor colorWithHexString:@"#2290FE"]];
    }else {
        [self.loginBtn setBackgroundColor:[UIColor colorWithHexString:@"#D8DFE7"]];
    }
    [self.loginBtn setEnabled:enabled];
}

- (void)setVerifyBtnEnabled:(BOOL)enabled {
    self.verifyCodeBtn.enabled = enabled;
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
    
    /*
     if (textField.text.length > 0) {
     if (textField.text.length != 13) {
     self.againSendBtn.layer.borderColor = [UIColor colorWithHexString:@"#D8DFE7"].CGColor;
     [self.againSendBtn setTitleColor:[UIColor colorWithHexString:@"#D8DFE7"] forState:UIControlStateNormal];
     self.againSendBtn.enabled = NO;
     }
     }*/
    
    if (textField.text.length >= 13 ) {//输入完成
        textField.text = [textField.text substringToIndex:13];
        
        self.verifyCodeBtn.layer.borderColor = [UIColor colorWithHexString:@"#535C61"].CGColor;
        [self.verifyCodeBtn setTitleColor:[UIColor colorWithHexString:@"#333333"] forState:UIControlStateNormal];
        self.verifyCodeBtn.enabled = YES;
        [textField resignFirstResponder];
        
    }else {
        self.verifyCodeBtn.layer.borderColor = [UIColor colorWithHexString:@"#D8DFE7"].CGColor;
        [self.verifyCodeBtn setTitleColor:[UIColor colorWithHexString:@"#D8DFE7"] forState:UIControlStateNormal];
        self.verifyCodeBtn.enabled = NO;
    }
}


#pragma mark - PhoneTextFieldDelegate

- (void)PhoneTextField:(UITextField *)phoneTextField getIsSuccess:(BOOL)successed {
    BOOL b = YES;
    NSString *phone = [self.phoneTF text];
    if (!phone||phone.length <= 0) {
        b = NO;
    }
    NSString *note = [self.verifyCodeTF text];
    if (!note||note.length <= 0) {
        b = NO;
    }
    [self setLoginBtnEnabled:b];
}


- (void)VerifyNoteTextField:(UITextField *)verifyNoteTextField getIsSuccess:(BOOL)successed {
    BOOL b = YES;
    NSString *phone = [self.phoneTF text];
    if (!phone||phone.length <= 0) {
        b = NO;
    }
    NSString *note = [self.verifyCodeTF text];
    if (!note||note.length <= 0) {
        b = NO;
    }
    [self setLoginBtnEnabled:b];
}

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
    [self.headImageView autoAlignAxisToSuperviewAxis:ALAxisVertical];
    [self.headImageView autoSetDimensionsToSize:CGSizeMake(60, 60)];
    
    // 手机号输入框
    [self.phoneTF autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.headImageView withOffset:40];
    [self.phoneTF autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:padding];
    [self.phoneTF autoPinEdge:ALEdgeRight toEdge:ALEdgeLeft ofView:self.verifyCodeBtn];
    [self.phoneTF autoSetDimension:ALDimensionHeight toSize:32];
    
    [self.verifyCodeBtn autoAlignAxis:ALAxisHorizontal toSameAxisOfView:self.phoneTF];
    [self.verifyCodeBtn autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:padding];
    [self.verifyCodeBtn autoSetDimensionsToSize:CGSizeMake(87, 32)];
    
    [self.phoneLine autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.phoneTF withOffset:6];
    [self.phoneLine autoSetDimension:ALDimensionHeight toSize:0.5];
    [self.phoneLine autoPinEdgeToSuperviewEdge:ALEdgeLeading withInset:padding];
    [self.phoneLine autoPinEdgeToSuperviewEdge:ALEdgeTrailing withInset:padding];
    
    // 验证码输入框
    [self.verifyCodeTF autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:padding];
    [self.verifyCodeTF autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.phoneLine withOffset:30];
    [self.verifyCodeTF autoPinEdgeToSuperviewEdge:ALEdgeTrailing withInset:padding];
    [self.verifyCodeTF autoSetDimension:ALDimensionHeight toSize:32];
    
    [self.checkPwdBtn autoAlignAxis:ALAxisHorizontal toSameAxisOfView:self.verifyCodeTF];
    [self.checkPwdBtn autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:padding];
    [self.checkPwdBtn autoSetDimensionsToSize:CGSizeMake(87, 32)];
    
    [self.verifyCodeLine autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.verifyCodeTF withOffset:6];
    [self.verifyCodeLine autoSetDimension:ALDimensionHeight toSize:0.5];
    [self.verifyCodeLine autoPinEdgeToSuperviewEdge:ALEdgeLeading withInset:padding];
    [self.verifyCodeLine autoPinEdgeToSuperviewEdge:ALEdgeTrailing withInset:padding];
    
    [self.loginBtn autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.verifyCodeLine withOffset:30];
    [self.loginBtn autoSetDimension:ALDimensionHeight toSize:44.0f];
    [self.loginBtn autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:padding];
    [self.loginBtn autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:padding];
    
    // 协议
    [self.protocolMarkLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.loginBtn withOffset:15.0f];
    NSDictionary *protocolMarkDic = [NSDictionary dictionaryWithObjectsAndKeys:self.protocolMarkLabel.font,NSFontAttributeName,nil];
    NSDictionary *protocolDic = [NSDictionary dictionaryWithObjectsAndKeys:self.protocolLabel.font,NSFontAttributeName,nil];
    CGSize  protocolMarkSize =[self.protocolMarkLabel.text boundingRectWithSize:CGSizeMake(0, 0) options:NSStringDrawingUsesLineFragmentOrigin  attributes:protocolMarkDic context:nil].size;
    CGSize  protocolSize =[self.protocolLabel.text boundingRectWithSize:CGSizeMake(0, 0) options:NSStringDrawingUsesLineFragmentOrigin  attributes:protocolDic context:nil].size;
    
    CGFloat edgeX = (kScreenWidth - (protocolMarkSize.width + protocolSize.width + 4))/2;
    [self.protocolMarkLabel autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:edgeX];
    [self.protocolMarkLabel autoSetDimension:ALDimensionWidth toSize:(protocolMarkSize.width+4.0f)];
    
    [self.protocolLabel autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:self.protocolMarkLabel];
    [self.protocolLabel autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:padding];
    [self.protocolLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:self.protocolMarkLabel];
    [self.protocolLabel autoPinEdge:ALEdgeBottom toEdge:ALEdgeBottom ofView:self.protocolMarkLabel];
    
    [super updateConstraints];
}


@end
