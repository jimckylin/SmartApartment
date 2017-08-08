//
//  HotelSelectView.m
//  SmartApartment
//
//  Created by jimcky on 2017/8/7.
//  Copyright © 2017年 Jimcky Lin. All rights reserved.
//

#import "HotelSelectView.h"
#import "UIImage+color.h"

@interface HotelSelectView ()

@property (nonatomic, strong) UIScrollView *contentSrollView;
@property (nonatomic, strong) UIButton *alldayBtn;
@property (nonatomic, strong) UIButton *hoursBtn;
@property (nonatomic, strong) UIButton *cityBtn;
@property (nonatomic, strong) UIButton *locateBtn;
@property (nonatomic, strong) UIButton *liveBtn;
@property (nonatomic, strong) UIButton *leaveBtn;

@end

@implementation HotelSelectView

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:CGRectMake(0, 0, kScreenWidth, 290)];
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
    
    _contentSrollView = [[UIScrollView alloc] init];
    _contentSrollView.contentSize = CGSizeMake(kScreenWidth*2, self.frame.size.height-40);
    _contentSrollView.scrollEnabled = YES;
    [self addSubview:_contentSrollView];
    
    // 房型选择
    UIImage *whiteImg = [UIImage imageWithColor:[UIColor whiteColor] size:CGSizeMake(kScreenWidth/2, 40)];
    
    _alldayBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_alldayBtn setBackgroundImage:kImage(@"CombinedShape2iphone") forState:UIControlStateNormal];
    [_alldayBtn setBackgroundImage:whiteImg forState:UIControlStateSelected];
    [_alldayBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [_alldayBtn setTitle:@"全日房" forState:UIControlStateNormal];
    [_alldayBtn setTitleColor:[UIColor darkTextColor] forState:UIControlStateSelected];
    [_alldayBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [_alldayBtn.titleLabel setFont:[UIFont systemFontOfSize:14]];
    _alldayBtn.tag = HotelSelectBtnTypeAlldayRoom;
    _alldayBtn.selected = YES;
    [self addSubview:_alldayBtn];
    
    _hoursBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_hoursBtn setBackgroundImage:kImage(@"CombinedShapeiphone") forState:UIControlStateNormal];
    [_hoursBtn setBackgroundImage:whiteImg forState:UIControlStateSelected];
    [_hoursBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [_hoursBtn setTitle:@"钟点房" forState:UIControlStateNormal];
    [_hoursBtn setTitleColor:[UIColor darkTextColor] forState:UIControlStateSelected];
    [_hoursBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [_hoursBtn.titleLabel setFont:[UIFont systemFontOfSize:14]];
    _hoursBtn.tag = HotelSelectBtnTypeHoursRoom;
    [self addSubview:_hoursBtn];
    
    // 位置选择
    UIView *selectView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, self.size.height - 40)];
    [_contentSrollView addSubview:selectView];
    
    _cityBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_cityBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    //[_cityBtn setImage:kImage(@"home_arrow_iconiphone") forState:UIControlStateNormal];
    [_cityBtn setTitleColor:[UIColor darkTextColor] forState:UIControlStateSelected];
    [_cityBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [_cityBtn.titleLabel setFont:[UIFont systemFontOfSize:14]];
    [_cityBtn setTitle:@"福州  >" forState:UIControlStateNormal];
    _cityBtn.titleLabel.textAlignment = NSTextAlignmentLeft; // 文字在titleLabel中左对齐(并没有看出有什么卵用)
    [_cityBtn setContentHorizontalAlignment:(UIControlContentHorizontalAlignmentLeft)];
    _cityBtn.tag = HotelSelectBtnTypeCitySelect;
    [selectView addSubview:_cityBtn];
    
    _locateBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_locateBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [_locateBtn setImage:kImage(@"home_location_ic_siphone") forState:UIControlStateNormal];
    [_locateBtn setTitle:@"我的位置" forState:UIControlStateNormal];
    [_locateBtn setTitleColor:[UIColor darkTextColor] forState:UIControlStateSelected];
    [_locateBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [_locateBtn.titleLabel setFont:[UIFont systemFontOfSize:11]];
    _locateBtn.titleLabel.textAlignment = NSTextAlignmentRight; // 文字在titleLabel中右对齐(并没有看出有什么卵用)
    [_locateBtn setContentHorizontalAlignment:(UIControlContentHorizontalAlignmentRight)];
    _locateBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 20);
    _locateBtn.tag = HotelSelectBtnTypeLocate;
    [selectView addSubview:_locateBtn];
    
    UIView *line1 = [[UIView alloc] init];
    line1.frame = CGRectMake(30, 50, kScreenWidth - 60, 1);
    line1.backgroundColor = [UIColor lightGrayColor];
    [selectView addSubview:line1];
    
    // 时间选择
    _liveBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_liveBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [_liveBtn setTitleColor:[UIColor darkTextColor] forState:UIControlStateSelected];
    [_liveBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [_liveBtn.titleLabel setFont:[UIFont systemFontOfSize:13]];
    [_liveBtn setTitle:@"08月08日" forState:UIControlStateNormal];
    _liveBtn.titleLabel.textAlignment = NSTextAlignmentLeft; // 文字在titleLabel中左对齐(并没有看出有什么卵用)
    [_liveBtn setContentHorizontalAlignment:(UIControlContentHorizontalAlignmentLeft)];
    _liveBtn.tag = HotelSelectBtnTypeLiveDate;
    [selectView addSubview:_liveBtn];
    
    _leaveBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_leaveBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [_leaveBtn setTitle:@"08月09日" forState:UIControlStateNormal];
    [_leaveBtn setTitleColor:[UIColor darkTextColor] forState:UIControlStateSelected];
    [_leaveBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [_leaveBtn.titleLabel setFont:[UIFont systemFontOfSize:13]];
    _leaveBtn.titleLabel.textAlignment = NSTextAlignmentRight; // 文字在titleLabel中右对齐(并没有看出有什么卵用)
    [_leaveBtn setContentHorizontalAlignment:(UIControlContentHorizontalAlignmentRight)];
    _leaveBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 20);
    _leaveBtn.tag = HotelSelectBtnTypeLeaveDate;
    [selectView addSubview:_leaveBtn];
    
    UIView *line2 = [[UIView alloc] init];
    line2.frame = CGRectMake(30, 100, kScreenWidth - 60, 1);
    line2.backgroundColor = [UIColor lightGrayColor];
    [selectView addSubview:line2];
}


#pragma mark - UIButton Action

- (void)btnClick:(UIButton *)sender {
    
    HotelSelectBtnType type = sender.tag;
    if (type == HotelSelectBtnTypeAlldayRoom || type == HotelSelectBtnTypeHoursRoom) {
        
        UIButton *alldayBtn = [self viewWithTag:HotelSelectBtnTypeAlldayRoom];
        UIButton *hoursBtn = [self viewWithTag:HotelSelectBtnTypeHoursRoom];
        
        if (type == HotelSelectBtnTypeAlldayRoom) {
            alldayBtn.selected = YES;
            hoursBtn.selected = NO;
        }else {
            alldayBtn.selected = NO;
            hoursBtn.selected = YES;
        }
    }
    else if (type == HotelSelectBtnTypeCitySelect) {
        
    }
    
    if (self.deletegate && [self.deletegate respondsToSelector:@selector(hotelSelectViewDidClickBtn:)]) {
        [self.deletegate hotelSelectViewDidClickBtn:type];
    }
}


- (void)updateConstraints {
    
    CGFloat paddingX = 30;
    
    [_contentSrollView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(40, 0, 0, 0)];
    
    [_alldayBtn autoPinEdgeToSuperviewEdge:ALEdgeLeft];
    [_alldayBtn autoPinEdgeToSuperviewEdge:ALEdgeTop];
    [_alldayBtn autoSetDimensionsToSize:CGSizeMake(kScreenWidth/2, 40)];
    
    [_hoursBtn autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:_alldayBtn];
    [_hoursBtn autoPinEdgeToSuperviewEdge:ALEdgeTop];
    [_hoursBtn autoSetDimensionsToSize:CGSizeMake(kScreenWidth/2, 40)];
    
    [_cityBtn autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:paddingX];
    [_cityBtn autoPinEdgeToSuperviewEdge:ALEdgeTop];
    [_cityBtn autoSetDimensionsToSize:CGSizeMake(150, 50)];
    
    [_locateBtn autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:paddingX];
    [_locateBtn autoPinEdgeToSuperviewEdge:ALEdgeTop];
    [_locateBtn autoSetDimensionsToSize:CGSizeMake(75, 50)];
    
    [_liveBtn autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:paddingX];
    [_liveBtn autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_cityBtn];
    [_liveBtn autoSetDimensionsToSize:CGSizeMake(80, 50)];
    
    [_leaveBtn autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:paddingX + 30];
    [_leaveBtn autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_cityBtn];
    [_leaveBtn autoSetDimensionsToSize:CGSizeMake(80, 50)];
    
    [super updateConstraints];
}

@end
