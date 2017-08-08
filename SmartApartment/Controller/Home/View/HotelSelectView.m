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
    
    UIView *selectView = [[UIView alloc] initWithFrame:CGRectMake(0, 40, kScreenWidth, self.size.height - 40)];
    [_contentSrollView addSubview:selectView];
    
    _cityBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_cityBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [_cityBtn setTitle:@"福州" forState:UIControlStateNormal];
    [_cityBtn setTitleColor:[UIColor darkTextColor] forState:UIControlStateSelected];
    [_cityBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [_cityBtn.titleLabel setFont:[UIFont systemFontOfSize:14]];
    _cityBtn.tag = HotelSelectBtnTypeCitySelect;
    [selectView addSubview:_cityBtn];
    
    _locateBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_locateBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [_locateBtn setImage:kImage(@"home_location_ic_siphone") forState:UIControlStateNormal];
    [_locateBtn setTitle:@" 我的位置" forState:UIControlStateNormal];
    [_locateBtn setTitleColor:[UIColor darkTextColor] forState:UIControlStateSelected];
    [_locateBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [_locateBtn.titleLabel setFont:[UIFont systemFontOfSize:14]];
    _locateBtn.tag = HotelSelectBtnTypeLocate;
    [selectView addSubview:_locateBtn];
    
    UIImage *image = kImage(@"myorder_lineiphone");
    UIImageView *line1 = [[UIImageView alloc] initWithImage:image];
    line1.frame = CGRectMake(30, 90, kScreenWidth - 60, 0.5);
    [selectView addSubview:line1];
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
    
    [super updateConstraints];
}

@end
