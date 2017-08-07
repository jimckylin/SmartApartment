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
}


- (void)updateConstraints {
    
    [_contentSrollView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(40, 0, 0, 0)];
    
    [_alldayBtn autoPinEdgeToSuperviewEdge:ALEdgeLeft];
    [_alldayBtn autoPinEdgeToSuperviewEdge:ALEdgeTop];
    [_alldayBtn autoSetDimensionsToSize:CGSizeMake(kScreenWidth/2, 40)];
    
    [_hoursBtn autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:_alldayBtn];
    [_hoursBtn autoPinEdgeToSuperviewEdge:ALEdgeTop];
    [_hoursBtn autoSetDimensionsToSize:CGSizeMake(kScreenWidth/2, 40)];
    
    [super updateConstraints];
}

@end
