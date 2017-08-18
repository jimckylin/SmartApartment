//
//  Macro.h
//  Youth
//
//  Created by wuqiang on 15/5/13.
//  Copyright (c) 2015年 Fujian Wisdom Cloud Technology Co.,Ltd. All rights reserved.
//

#ifndef Youth_Macro_h
#define Youth_Macro_h

#ifdef DEBUG
#define YZLog(format, ...) NSLog(format, ## __VA_ARGS__)
#else
#define YZLog(format, ...)
#endif


//////////////// ****  长度定义  **** /////////////////
#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height
#define KEY_WINDOW  [[UIApplication sharedApplication]keyWindow]

#define kFactorHeightOfScreen   (kScreenWidth / 320.0)
#define AdaptHeight(height)     (height * kFactorHeightOfScreen)

///////////////// ****  颜色定义  **** /////////////////
#define MainBgColor YZColor(242, 242, 242, 1)
#define YZColor(r, g, b, a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:a]
#define YZColorPure(value) [UIColor colorWithRed:(value)/255.0 green:(value)/255.0 blue:(value)/255.0 alpha:1.0]
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#define ColorRGB(R, G, B)         [UIColor colorWithRed:(R)/255.0 green:(G)/255.0 blue:(B)/255.0 alpha:1.0]
#define ColorRGBSame(RGB)         [UIColor colorWithRed:(RGB)/255.0 green:(RGB)/255.0 blue:(RGB)/255.0 alpha:1.0]
#define ColorRGBA(R, G, B, A)     [UIColor colorWithRed:(R)/255.0 green:(G)/255.0 blue:(B)/255.0 alpha:A]

#define PriceRGBColor [UIColor colorWithRed:226.0/255.0 green:108.0/255.0 blue:118.0/255.0 alpha:1.0]
#define PriceHexColor #E26C76

#define ThemeColor [UIColor colorWithRed:0 green:0.6 blue:0.8 alpha:1.000]
#define ThemeLightColor [UIColor colorWithRed:0.298 green:0.718 blue:0.859 alpha:1.000]
#define TopColor [UIColor colorWithRed:43.0/255.0 green:181.0/255.0 blue:117.0/255.0 alpha:1.0]
#define DarkGreyColor [UIColor colorWithRed:102.0/255.0 green:102.0/255.0 blue:102.0/255.0 alpha:1.0]
#define LightGreyColor [UIColor colorWithRed:170.0/255.0 green:170.0/255.0 blue:170.0/255.0 alpha:1.0]

#define SeparatorColor [UIColor colorWithRed:221.0/255.0 green:221.0/255.0 blue:221.0/255.0 alpha:1.0]
#define BorderColor [UIColor colorWithRed:215.0/255.0 green:215.0/255.0 blue:215.0/255.0 alpha:1.0]
#define SecondTitleColor [UIColor colorWithRed:119.0/255.0 green:119.0/255.0 blue:119.0/255.0 alpha:1.0]
#define TextHighlightColor [UIColor colorWithRed:93.0/255.0 green:93.0/255.0 blue:93.0/255.0 alpha:1.0]
#define TextPlaceholderColor [UIColor colorWithRed:204.0/255.0 green:204.0/255.0 blue:204.0/255.0 alpha:1.0]

#define LineColor YZColor(221, 221, 221, 0.9)

#define SepatorImg      [CommonUse creactColorImage:CGSizeMake(1, 1) FillColor:UIColorFromRGB(0xe9e9e9)]
#define SepatorImgDark  [CommonUse creactColorImage:CGSizeMake(1, 1) FillColor:UIColorFromRGB(0xcccccc)]
#define ThemeColorImg   [CommonUse creactColorImage:CGSizeMake(1, 1) FillColor:ThemeColor]
#define ThemeHighlightColorImg   [CommonUse creactColorImage:CGSizeMake(1, 1) FillColor:ThemeLightColor]

///////////////// ****  标示定义  **** /////////////////

#define IOS7 [[[UIDevice currentDevice]systemVersion] floatValue] >= 7.0
#define IOS8 [[[UIDevice currentDevice]systemVersion] floatValue] >= 8.0
#define IOS9 [[[UIDevice currentDevice]systemVersion] floatValue] >= 9.0

#define iPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)
#define iPhone6 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size) : NO)
#define iPhone6plus ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? (CGSizeEqualToSize(CGSizeMake(1125, 2001), [[UIScreen mainScreen] currentMode].size) || CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size)) : NO)

#define iPhone6OrLater iPhone6 || iPhone6plus

///////////////// ****  方法定义  **** /////////////////

#define AdaptH(height) iPhone6OrLater?height*1.2:height

#define SAFE_RELEASE(__POINTER) { [__POINTER release]; __POINTER = nil; }
#define ASI_SAFE_RELEASE(_POINTER) { [_POINTER setDelegate:nil];[_POINTER cancel];[_POINTER release]; }

#define TopNormalImage [CommonUse creactColorImage:CGSizeMake(100, 100) FillColor:YZColor(220, 97, 104, 1.0)]
#define TopPressImage [CommonUse creactColorImage:CGSizeMake(100, 100) FillColor:YZColor(210, 87, 94, 1.0)]

#define OrangeNormalImage [CommonUse creactColorImage:CGSizeMake(100, 100) FillColor:YZColor(255, 111, 68, 1.0)]
#define OrangePressImage [CommonUse creactColorImage:CGSizeMake(100, 100) FillColor:YZColor(250, 101, 60, 1.0)]

#define YZFont(a) [UIFont systemFontOfSize:a]

#define WS(weakSelf) __weak typeof (&*self) weakSelf = self;
#define SS(strongSelf) __weak typeof (&*self) strongSelf = weakSelf;

#define __WEAK_SELF                                 __weak typeof(self) weakSelf = self;
#define __STRONG_SELF                               __strong typeof(weakSelf) strongSelf = weakSelf;

/////////////// ****  服务器地址  **** /////////////////
//开发服务器
#define kServerUrl @"http://192.168.1.230/phpcode/platform/storeMobile"
#define kPostTag @"LAN"

//测试服务器
//#define kPostTag @"LAN_T"

////// 外网服务器    -----*******注意修改推送类型！！！！！！！！！！！！！
//#define kServerUrl @"http://36.250.234.6:20080/platform/storeMobile"
//#define kPostTag @"WAN"

#define App_Version @"101"  //每更新一次版本加1，并通知服务端配置


#define kAlipayCallBackUrl  @"/mobile/pay/notify/payment_code/alipay.html"
#define KWXPayCallBackUrl   @"/mobile/pay/notify/payment_code/weixin.html"

/*** 微信配置 ***/

#define WXAPPID             @"wx275d8ba3c5fccaf5"
#define WXSECRET            @"5ad0e40cfe0e73d2ec8222cc37f14fc4"
#define WXPARTNERID         @"1276234301"
#define WXPARTNERKEY        @"5e337e4b00152b00dd5658cd713051c6"
#define WXAPPKEY            @"n2OzxcviNBTLvfr9w6O9fEMZbUZ3g5vugz1ahm77BvrqpVG5DDuRgElTw7JuIlvexxaz9NxjTxADqp62PYx0Nz383oPV4GlnliO4AnFi77YibiFrbLiCGC1dKraVGodD"

/**** 定位相关 ****/

#define kAdCode     @"adCode"
#define kCityName   @"cityName"
#define kLatitude   @"latitude"
#define kLongitude  @"longitude"

#define kLocationInfo @"kLoactionInfo"

///////////////// ****  字段名定义  **** /////////////////

#define kRequestSign        @"HttpRequestSign"

#define kResponseCode       @"code"
#define kResponseMessage    @"msg"
#define kResponseDataDict   @"data"
#define kResponseItemsKey   @"items"

#define kRequestFakeFlag    @"1"    //1:请求假数据，否则请求真实数据

#define kPageCount @"30"
#define kPageSize 30
#define kUserHeadImageSize 200

#define kGetQRCode @"ScanGetQRCode"
#define kSerial    @"WaitInLineSerial"
#define kRemain    @"WaitInLineRemainPerson"

#define kActiveCollect @"UnLoginActiveCollected"
#define kShopCollect   @"UnLoginShopCollected"

///////////////// ****  通知定义  **** /////////////////
#define kLoginSuccess                   @"LoginSuccessNotification"
#define kLogoutSuccess                  @"LogoutSuccessNotification"

#define kRefreshPersonalInfo            @"RefreshPersonalInfoNotification"
#define kRefreshOrderList               @"RefreshOrderListNotification"
#define kLocationDidChangeNotify        @"kLocationDidChangeNotify"
#define kCityDidChangeNotify            @"kCityDidChangeNotify"
#define kRefreshHomeCollectList         @"RefreshHomeCollectListNotification"
#define kPostNotifation                 @"PostInfoToChangeNotification"
#define kRefreshMyCollectList           @"RefreshMyCollectList"
#define kRefreshActDetailReviewListNums @"RefreshActDetailReviewListNums"
#define kRefreshActReviewListNums       @"RefreshActReviewListNums"
#define kWXLoginInfo                    @"GetWXLoginInfoNotification"
#define kHiddenWXHUD                    @"WXHUDDismissNotification"
#define kRefreshOrderDetail             @"RefreshOrderDetailNotification"
#define kAddBankCardSuccess             @"AddBankCardSuccessNotification"

#define kGetWaitInLineSerialNum         @"GetWaitInLineSerialNumNSNotification"
#define kViewControlCanDrag             @"ViewControllerCanDragNSNotification"
#define kViewControlCanNotDrag          @"ViewControlCanNotDragNSNotification"

#define kRefreshMoneyManage             @"RefreshMoneyManageNSNotification"

#define kPopLoginView                   @"PopLoginView"
#define kUpdataMessageNum               @"UpdataMessageNumNSNotification"
#define kOpenJPush                      @"OpenJPushNSNotification"
#define kCancelFollow                   @"kCancelFollowNotification"
#define kCleanCache                     @"kCleanCache"


/**********Key 值定义***********/

#define QRCodeKey @"youth123"


/********** 枚举定义 ***********/

typedef NS_ENUM(NSInteger, MerchantType) {
    kMerchantTypeDefault,
    kMerchantTypeWanka
};

/*iOS Version*/
#define IOS_SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define iOS7_OR_LATER       IOS_SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0")
#define iOS8_OR_LATER       IOS_SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"8.0")
#define iOS9_OR_LATER       IOS_SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"9.0")

/*NSCoding*/
#define YYCodingImplementation \
- (void)encodeWithCoder:(NSCoder *)aCoder { [self yy_modelEncodeWithCoder:aCoder]; } \
- (id)initWithCoder:(NSCoder *)aDecoder { return [self yy_modelInitWithCoder:aDecoder]; }

#define PATH_OF_DOCUMENT    [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0]

#define APP_VERSION     ([[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"])

#endif
