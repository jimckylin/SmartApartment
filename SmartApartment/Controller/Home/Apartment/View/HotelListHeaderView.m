//
//  HotelListHeaderView.m
//  SmartApartment
//
//  Created by jimcky on 2017/8/14.
//  Copyright © 2017年 Jimcky Lin. All rights reserved.
//

#import "HotelListHeaderView.h"
#import <BAButton/BAButton.h>
#import "HotelList.h"

@interface HotelListHeaderView ()

@property (nonatomic, strong) UIButton *backBtn;
@property (nonatomic, strong) UIButton *cityBtn;
@property (nonatomic, strong) UIButton *dateBtn;

@end

@implementation HotelListHeaderView

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        [self initView];
    }
    return self;
}

+ (BOOL)requiresConstraintBasedLayout {
    return YES;
}

- (void)initView {
    self.backgroundColor = [UIColor whiteColor];
    
    _backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _backBtn.frame = CGRectMake(0, 20, 75, 44);
    [_backBtn setImage:[UIImage imageNamed:@"nav_return_ic_wiphone"] forState:UIControlStateNormal];
    [_backBtn setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 27)];
    [_backBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    _backBtn.tag = HotelListHeaderBtnTypeBack;
    [self addSubview:_backBtn];
    
    _cityBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _cityBtn.backgroundColor = RGBA(256, 256, 256, 0.3);
    [_cityBtn setImage:kImage(@"list_city_iciphone") forState:UIControlStateNormal];
    [_cityBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_cityBtn.titleLabel setFont:[UIFont systemFontOfSize:13]];
    [_cityBtn setTitle:@"福州(0)" forState:UIControlStateNormal];
    _cityBtn.titleLabel.textAlignment = NSTextAlignmentLeft;
    [_cityBtn setContentHorizontalAlignment:(UIControlContentHorizontalAlignmentLeft)];
    _cityBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    _cityBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    [_cityBtn ba_button_setButtonLayoutType:BAKit_ButtonLayoutTypeLeftImageLeft padding:10];
    _cityBtn.tag = HotelListHeaderBtnTypeCity;
    [_cityBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_cityBtn];
    
    _dateBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _dateBtn.backgroundColor = RGBA(256, 256, 256, 0.3);
    [_dateBtn setImage:kImage(@"list_time_iciphone") forState:UIControlStateNormal];
    [_dateBtn setTitle:@"8月14-15 共1晚" forState:UIControlStateNormal];
    [_dateBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_dateBtn.titleLabel setFont:[UIFont systemFontOfSize:13]];
    _dateBtn.titleLabel.textAlignment = NSTextAlignmentLeft;
    [_dateBtn setContentHorizontalAlignment:(UIControlContentHorizontalAlignmentLeft)];
    _dateBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    _dateBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    [_dateBtn ba_button_setButtonLayoutType:BAKit_ButtonLayoutTypeLeftImageLeft padding:10];
    _dateBtn.tag = HotelListHeaderBtnTypeDate;
    [_dateBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_dateBtn];
}

- (void)setCityName:(NSString *)cityName {
    
    cityName = [cityName stringByReplacingOccurrencesOfString:@"市" withString:@""];
    [_cityBtn setTitle:cityName forState:UIControlStateNormal];
}


#pragma mark - UIButton Action

- (void)btnClick:(id)sender {
    
    HotelListHeaderBtnType type = ((UIButton *)sender).tag;
    if (self.delegate && [self.delegate respondsToSelector:@selector(hotelListHeaderViewDidClickBtn:)]) {
        [self.delegate hotelListHeaderViewDidClickBtn:type];
    }
}


#pragma mark - Publick

- (void)setHotelList:(HotelList *)hotelList {
    
    NSString *title = [NSString stringWithFormat:@"%@(%@)", hotelList.area, hotelList.storeNum];
    [_cityBtn setTitle:title forState:UIControlStateNormal];
}

// 设置头部日期
- (void)setHeaderViewDate:(NSDate *)checkinDate checkoutDate:(NSDate *)checkoutDate {
    
    NSString *checkinDateStr = [NSString sia_stringFromDate:checkinDate withFormat:@"M月d"];
    NSString *checkoutDateStr = [NSString sia_stringFromDate:checkoutDate withFormat:@"M月d"];
    NSInteger days = [checkinDate daysBeforeDate:checkoutDate];
    
    NSString *title = [NSString stringWithFormat:@"%@-%@ 共(%zd)天", checkinDateStr, checkoutDateStr, days];
    [_dateBtn setTitle:title forState:UIControlStateNormal];
}

// 设置头部日期
- (void)setHeaderViewDateStr:(NSString *)checkinDateStr checkoutDateStr:(NSString *)checkoutDateStr {
    
    if (!self.beforeDawn) {
        NSDate *checkinDate = [NSDate sia_dateFromString:checkinDateStr withFormat:@"yyyy-MM-dd"];
        NSDate *checkoutDate = [NSDate sia_dateFromString:checkoutDateStr withFormat:@"yyyy-MM-dd"];
        NSInteger days = [checkinDate daysBeforeDate:checkoutDate];
        
        checkinDateStr = [NSString sia_stringFromDate:checkinDate withFormat:@"M月d"];
        checkoutDateStr = [NSString sia_stringFromDate:checkoutDate withFormat:@"M月d"];
        
        NSString *title = [NSString stringWithFormat:@"%@-%@ 共(%zd)天", checkinDateStr, checkoutDateStr, days];
        [_dateBtn setTitle:title forState:UIControlStateNormal];
    }else {
        NSDate *checkoutDate = [NSDate sia_dateFromString:checkoutDateStr withFormat:@"yyyy-MM-dd"];
        checkoutDateStr = [NSString sia_stringFromDate:checkoutDate withFormat:@"M月d"];
        
        NSString *title = [NSString stringWithFormat:@"%@", checkoutDateStr];
        [_dateBtn setTitle:title forState:UIControlStateNormal];
    }
}


- (void)relayoutHeaderView:(UIScrollView *)scrollView {
    
    CGFloat bounceHeight = 90;
    CGFloat offsetY = scrollView.contentOffset.y + bounceHeight;
    CGFloat triggerY = 60; // 触发临界线
    
    if (offsetY >= 0 && offsetY < triggerY) {
        CGFloat ratio = offsetY/bounceHeight;
        CGFloat headerOffsetY = 64*ratio;
        self.top = - headerOffsetY;
        
        CGFloat alpha = (triggerY - offsetY)/triggerY;
        [_dateBtn setAlpha:alpha];
    }
    
    if (offsetY > triggerY && offsetY <= bounceHeight) {
        
        CGFloat alpha = (bounceHeight - offsetY)/(bounceHeight - triggerY);
        [_cityBtn setAlpha:alpha];
        [_backBtn setAlpha:alpha];
    }
    
    if (offsetY <= 0) {
        self.top = 0;
        [_dateBtn setAlpha:1];
        [_cityBtn setAlpha:1];
        [_backBtn setAlpha:1];
    }
}



#pragma mark - Update Constraints

- (void)updateConstraints {
    
    CGFloat paddingX = 15;
    
    [_cityBtn autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:paddingX];
    [_cityBtn autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:64 + 2];
    [_cityBtn autoSetDimensionsToSize:CGSizeMake(kScreenWidth-30, 31)];
    
    [_dateBtn autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:_cityBtn];
    [_dateBtn autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_cityBtn withOffset:13];
    [_dateBtn autoSetDimensionsToSize:CGSizeMake(kScreenWidth-30, 31)];
    
    [super updateConstraints];
}

@end


