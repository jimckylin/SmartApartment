//
//  HotelSelectView.m
//  SmartApartment
//
//  Created by jimcky on 2017/8/7.
//  Copyright © 2017年 Jimcky Lin. All rights reserved.
//

#import "HotelSelectView.h"
#import "UIImage+color.h"
#import "HotelSelectSubView.h"

@interface HotelSelectView ()

@property (nonatomic, strong) UIScrollView *contentSrollView;
@property (nonatomic, strong) UIButton *alldayBtn;
@property (nonatomic, strong) UIButton *hoursBtn;

@property (nonatomic, strong) HotelSelectSubView *selectView;
@property (nonatomic, strong) HotelSelectSubView *selectView2;

@end

@implementation HotelSelectView

- (instancetype)initWithDelegate:(id<HotelSelectViewDelegate>)delegate {
    
    self = [super initWithFrame:CGRectMake(0, 0, kScreenWidth, 290)];
    if (self) {
        self.deletegate = delegate;
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
    _contentSrollView.scrollEnabled = NO;
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
    _selectView = [[HotelSelectSubView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, self.size.height - 40) roomType:HotelRoomTypeAllday];
    _selectView.deletegate = self.deletegate;
    [_contentSrollView addSubview:_selectView];
    
    _selectView2 = [[HotelSelectSubView alloc] initWithFrame:CGRectMake(kScreenWidth, 0, kScreenWidth, self.size.height - 40) roomType:HotelRoomTypeTypeHours];
    _selectView2.deletegate = self.deletegate;
    [_contentSrollView addSubview:_selectView2];
}


- (void)setCheckinDate:(NSDate *)checkinDate {
    
    _selectView.checkinDate = checkinDate;
    _selectView2.checkinDate = checkinDate;
    _checkinDate = checkinDate;
}

- (void)setCheckoutDate:(NSDate *)checkoutDate {
    
    _selectView.checkoutDate = checkoutDate;
    _selectView2.checkoutDate = checkoutDate;
    _checkoutDate = checkoutDate;
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
        [_contentSrollView setContentOffset:CGPointMake(kScreenWidth*(type-1000), 0) animated:YES];
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
