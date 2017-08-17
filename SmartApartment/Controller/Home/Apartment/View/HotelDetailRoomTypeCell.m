//
//  HotelDetailRoomTypeCell.m
//  SmartApartment
//
//  Created by jimcky on 2017/8/17.
//  Copyright © 2017年 Jimcky Lin. All rights reserved.
//

#import "HotelDetailRoomTypeCell.h"

@interface HotelDetailRoomTypeCell ()

@property (nonatomic, strong) UIButton *alldayBtn;
@property (nonatomic, strong) UIButton *hoursBtn;

@end


@implementation HotelDetailRoomTypeCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor clearColor];
        [self initSubView];
    }
    return self;
}

+ (BOOL)requiresConstraintBasedLayout {
    return YES;
}

- (void)initSubView {
    
    UIView *bgView = [UIView new];
    bgView.backgroundColor = [UIColor whiteColor];
    [self addSubview:bgView];
    [bgView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(0, 10, 0, 10)];
    
    _alldayBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_alldayBtn setBackgroundImage:kImage(@"CombinedShape2iphone") forState:UIControlStateNormal];
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
    [_hoursBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [_hoursBtn setTitle:@"钟点房" forState:UIControlStateNormal];
    [_hoursBtn setTitleColor:[UIColor darkTextColor] forState:UIControlStateSelected];
    [_hoursBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [_hoursBtn.titleLabel setFont:[UIFont systemFontOfSize:14]];
    _hoursBtn.tag = HotelSelectBtnTypeHoursRoom;
    [self addSubview:_hoursBtn];
    
    [self sendSubviewToBack:bgView];
    
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
}


- (void)updateConstraints {
    
    [_alldayBtn autoPinEdgeToSuperviewEdge:ALEdgeLeft];
    [_alldayBtn autoPinEdgeToSuperviewEdge:ALEdgeTop];
    [_alldayBtn autoSetDimensionsToSize:CGSizeMake(kScreenWidth/2, 40)];
    
    [_hoursBtn autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:_alldayBtn];
    [_hoursBtn autoPinEdgeToSuperviewEdge:ALEdgeTop];
    [_hoursBtn autoSetDimensionsToSize:CGSizeMake(kScreenWidth/2, 40)];
    
    [super updateConstraints];
}

@end
