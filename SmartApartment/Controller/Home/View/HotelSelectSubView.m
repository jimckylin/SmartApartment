//
//  HotelSelectSubView.m
//  SmartApartment
//
//  Created by jimcky on 2017/8/11.
//  Copyright © 2017年 Jimcky Lin. All rights reserved.
//

#import "HotelSelectSubView.h"
#import "UIImage+color.h"

@interface HotelSelectSubView ()

@property (nonatomic, strong) UIButton *cityBtn;
@property (nonatomic, strong) UIButton *locateBtn;
@property (nonatomic, strong) UIButton *liveBtn;
@property (nonatomic, strong) UIButton *leaveBtn;

@property (nonatomic, strong) UILabel *liveLabel;
@property (nonatomic, strong) UILabel *leaveLabel;
@property (nonatomic, strong) UILabel *countLabel;
@property (nonatomic, strong) UILabel *extraLabel;
@property (nonatomic, strong) UIImageView *arrowIconV;

@property (nonatomic, strong) UIButton *searchBtn;

@end

@implementation HotelSelectSubView

- (instancetype)initWithFrame:(CGRect)frame  roomType:(HotelRoomType)roomType {
    
    self = [super initWithFrame:frame];
    if (self) {
        self.roomType = roomType;
        [self initView];
    }
    return self;
}

+ (BOOL)requiresConstraintBasedLayout {
    return YES;
}

- (void)initView {
    self.backgroundColor = [UIColor whiteColor];
    
    _cityBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_cityBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    //[_cityBtn setImage:kImage(@"home_arrow_iconiphone") forState:UIControlStateNormal];
    [_cityBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
    [_cityBtn setTitleColor:[UIColor darkTextColor] forState:UIControlStateNormal];
    [_cityBtn.titleLabel setFont:[UIFont systemFontOfSize:15]];
    [_cityBtn setTitle:@"福州  >" forState:UIControlStateNormal];
    _cityBtn.titleLabel.textAlignment = NSTextAlignmentLeft; // 文字在titleLabel中左对齐(并没有看出有什么卵用)
    [_cityBtn setContentHorizontalAlignment:(UIControlContentHorizontalAlignmentLeft)];
    _cityBtn.tag = HotelSelectBtnTypeCitySelect;
    [self addSubview:_cityBtn];
    
    _locateBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_locateBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [_locateBtn setImage:kImage(@"home_location_ic_siphone") forState:UIControlStateNormal];
    [_locateBtn setTitle:@"我的位置" forState:UIControlStateNormal];
    [_locateBtn setTitleColor:[UIColor darkTextColor] forState:UIControlStateHighlighted];
    [_locateBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [_locateBtn.titleLabel setFont:[UIFont systemFontOfSize:11]];
    _locateBtn.titleLabel.textAlignment = NSTextAlignmentRight; // 文字在titleLabel中右对齐(并没有看出有什么卵用)
    [_locateBtn setContentHorizontalAlignment:(UIControlContentHorizontalAlignmentRight)];
    _locateBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 20);
    _locateBtn.tag = HotelSelectBtnTypeLocate;
    [self addSubview:_locateBtn];
    
    UIView *line1 = [[UIView alloc] init];
    line1.frame = CGRectMake(30, 50, kScreenWidth - 60, 0.5);
    line1.backgroundColor = [UIColor lightGrayColor];
    [self addSubview:line1];
    
    // 时间选择
    _liveBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_liveBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [_liveBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateSelected];
    [_liveBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [_liveBtn.titleLabel setFont:[UIFont systemFontOfSize:14]];
    [_liveBtn setTitle:@"08月08日" forState:UIControlStateNormal];
    _liveBtn.titleLabel.textAlignment = NSTextAlignmentLeft; // 文字在titleLabel中左对齐(并没有看出有什么卵用)
    [_liveBtn setContentHorizontalAlignment:(UIControlContentHorizontalAlignmentLeft)];
    _liveBtn.tag = HotelSelectBtnTypeLiveDate;
    [self addSubview:_liveBtn];
    
    _liveLabel = [UILabel new];
    _liveLabel.font = [UIFont systemFontOfSize:10];
    _liveLabel.textColor = [UIColor lightGrayColor];
    _liveLabel.textAlignment = NSTextAlignmentCenter;
    _liveLabel.numberOfLines = 0;
    _liveLabel.text = @"入住\n周二";
    [self addSubview:_liveLabel];
    
    if (self.roomType == HotelRoomTypeAllday) {
        _leaveBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_leaveBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [_leaveBtn setTitle:@"08月09日" forState:UIControlStateNormal];
        [_leaveBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateSelected];
        [_leaveBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        [_leaveBtn.titleLabel setFont:[UIFont systemFontOfSize:14]];
        _leaveBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 20);
        _leaveBtn.tag = HotelSelectBtnTypeLeaveDate;
        [self addSubview:_leaveBtn];
        
        _leaveLabel = [UILabel new];
        _leaveLabel.font = [UIFont systemFontOfSize:10];
        _leaveLabel.textColor = [UIColor lightGrayColor];
        _leaveLabel.textAlignment = NSTextAlignmentCenter;
        _leaveLabel.numberOfLines = 0;
        _leaveLabel.text = @"离店\n周三";
        [self addSubview:_leaveLabel];
        
        _countLabel = [UILabel new];
        _countLabel.font = [UIFont systemFontOfSize:9];
        _countLabel.textColor = [UIColor lightGrayColor];
        _countLabel.textAlignment = NSTextAlignmentCenter;
        _countLabel.layer.borderColor = [UIColor grayColor].CGColor;
        _countLabel.layer.borderWidth = 0.5;
        _countLabel.layer.cornerRadius = 15/2.;
        _countLabel.text = @"共2晚";
        [self addSubview:_countLabel];
    }
    
    UIView *line2 = [[UIView alloc] init];
    line2.frame = CGRectMake(30, 100, kScreenWidth - 60, 0.5);
    line2.backgroundColor = [UIColor lightGrayColor];
    [self addSubview:line2];
    
    _extraLabel = [UILabel new];
    _extraLabel.font = [UIFont systemFontOfSize:13];
    _extraLabel.textColor = [UIColor lightGrayColor];
    _extraLabel.text = @"位置/品牌/酒店名称";
    _extraLabel.userInteractionEnabled = YES;
    _extraLabel.tag = HotelSelectBtnTypeExtraSearch;
    [self addSubview:_extraLabel];
    
    _arrowIconV = [UIImageView new];
    _arrowIconV.image = kImage(@"home_arrow_iconiphone");
    [self addSubview:_arrowIconV];
    
    UIView *line3 = [[UIView alloc] init];
    line3.frame = CGRectMake(30, 100 + 40, kScreenWidth - 60, 0.5);
    line3.backgroundColor = [UIColor lightGrayColor];
    [self addSubview:line3];
    
    // 查找酒店
    _searchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _searchBtn.backgroundColor = ThemeColor;
    [_searchBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [_searchBtn setTitle:@"查找酒店" forState:UIControlStateNormal];
    [_searchBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_searchBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
    [_searchBtn.titleLabel setFont:[UIFont systemFontOfSize:14]];
    _searchBtn.tag = HotelSelectBtnTypeSearchHotel;
    _searchBtn.layer.cornerRadius = 3;
    [self addSubview:_searchBtn];
}


#pragma mark - UIButton Action

- (void)btnClick:(id)sender {
    
    HotelSelectBtnType type;
    if ([sender isKindOfClass:[UIButton class]]) {
        type = ((UIButton *)sender).tag;
    }else {
        type = ((UITapGestureRecognizer *)sender).view.tag;
    }
    
    if (self.deletegate && [self.deletegate respondsToSelector:@selector(hotelSelectViewDidClickBtn:roomType:)]) {
        [self.deletegate hotelSelectViewDidClickBtn:type roomType:_roomType];
    }
}


#pragma mark - Update Constraints

- (void)updateConstraints {
    
    CGFloat paddingX = 30;
    
    [_cityBtn autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:paddingX];
    [_cityBtn autoPinEdgeToSuperviewEdge:ALEdgeTop];
    [_cityBtn autoSetDimensionsToSize:CGSizeMake(150, 50)];
    
    [_locateBtn autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:paddingX];
    [_locateBtn autoPinEdgeToSuperviewEdge:ALEdgeTop];
    [_locateBtn autoSetDimensionsToSize:CGSizeMake(75, 50)];
    
    [_liveBtn autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:paddingX];
    [_liveBtn autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_cityBtn];
    [_liveBtn autoSetDimensionsToSize:CGSizeMake(65, 50)];
    
    [_liveLabel autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:_liveBtn];
    [_liveLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_cityBtn];
    [_liveLabel autoSetDimensionsToSize:CGSizeMake(30, 50)];
    
    // 是否
    if (self.roomType == HotelRoomTypeAllday) {
        [_leaveBtn autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:paddingX + 30];
        [_leaveBtn autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_cityBtn];
        [_leaveBtn autoSetDimensionsToSize:CGSizeMake(65, 50)];
        
        [_leaveLabel autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:paddingX];
        [_leaveLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_cityBtn];
        [_leaveLabel autoSetDimensionsToSize:CGSizeMake(30, 50)];
        
        [_countLabel autoAlignAxisToSuperviewAxis:ALAxisVertical];
        [_countLabel autoAlignAxis:ALAxisHorizontal toSameAxisOfView:_liveLabel];
        [_countLabel autoSetDimensionsToSize:CGSizeMake(40, 15)];
    }
    
    [_extraLabel autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:paddingX];
    [_extraLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_liveLabel];
    [_extraLabel autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:paddingX+30];
    [_extraLabel autoSetDimension:ALDimensionHeight toSize:40];
    
    [_arrowIconV autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:paddingX];
    [_arrowIconV autoAlignAxis:ALAxisHorizontal toSameAxisOfView:_extraLabel];
    //[_countLabel autoSetDimensionsToSize:CGSizeMake(40, 15)];
    
    [_searchBtn autoAlignAxisToSuperviewAxis:ALAxisVertical];
    [_searchBtn autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_extraLabel withOffset:20];
    [_searchBtn autoSetDimensionsToSize:CGSizeMake(kScreenWidth-80, 40)];
    
    UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(btnClick:)];
    recognizer.numberOfTapsRequired = 1;
    [_extraLabel addGestureRecognizer:recognizer];
    
    [super updateConstraints];
}

@end

