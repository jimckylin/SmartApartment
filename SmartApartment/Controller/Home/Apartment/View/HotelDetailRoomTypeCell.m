//
//  HotelDetailRoomTypeCell.m
//  SmartApartment
//
//  Created by jimcky on 2017/8/17.
//  Copyright © 2017年 Jimcky Lin. All rights reserved.
//

#import "HotelDetailRoomTypeCell.h"
#import "HotelDetailDateView.h"
#import <BAButton/BAButton.h>

@interface HotelDetailRoomTypeCell ()

@property (nonatomic, strong) UIButton *alldayBtn;
@property (nonatomic, strong) UIButton *hoursBtn;
@property (nonatomic, strong) HotelDetailDateView *dateView1;
@property (nonatomic, strong) HotelDetailDateView *dateView2;

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

- (void)setDelegate:(id<HotelDetailRoomTypeCellDelegate>)delegate {
    
    _dateView1.delegate = (id<HotelDetailDateViewDelegate>)delegate;
    _dateView2.delegate = (id<HotelDetailDateViewDelegate>)delegate;
    
    _delegate = delegate;
}

- (void)initSubView {
    
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(10, 0, kScreenWidth-20, 48.5)];
    bgView.backgroundColor = [UIColor whiteColor];
    [bgView ba_view_setViewRectCornerType:BAKit_ViewRectCornerTypeTopLeftAndTopRight viewCornerRadius:6];
    [self addSubview:bgView];
    
    _alldayBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_alldayBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [_alldayBtn setTitle:@"全日房" forState:UIControlStateNormal];
    [_alldayBtn setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
    [_alldayBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [_alldayBtn.titleLabel setFont:[UIFont systemFontOfSize:14]];
    _alldayBtn.tag = HotelRoomTypeAllday;
    _alldayBtn.selected = YES;
    [self addSubview:_alldayBtn];
    
    _hoursBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_hoursBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [_hoursBtn setTitle:@"钟点房" forState:UIControlStateNormal];
    [_hoursBtn setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
    [_hoursBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [_hoursBtn.titleLabel setFont:[UIFont systemFontOfSize:14]];
    _hoursBtn.tag = HotelRoomTypeTypeHours;
    [self addSubview:_hoursBtn];
    
    // 时间
    _dateView1 = [[HotelDetailDateView alloc] initWithRoomType:HotelRoomTypeAllday];
    _dateView1.roomType = HotelRoomTypeAllday;
    [self addSubview:_dateView1];
    
    _dateView2 = [[HotelDetailDateView alloc] initWithRoomType:HotelRoomTypeTypeHours];
    _dateView2.roomType = HotelRoomTypeTypeHours;
    _dateView2.hidden = YES;
    [self addSubview:_dateView2];

}

- (void)setDateViewateStr:(NSString *)checkInTime checkoutDateStr:(NSString *)checkOutTime {
    
    [_dateView1 setDateViewateStr:checkInTime checkoutDateStr:checkOutTime];
    [_dateView2 setDateViewateStr:checkInTime checkoutDateStr:checkOutTime];
}


#pragma mark - UIButton Action

- (void)btnClick:(UIButton *)sender {
    
    HotelRoomType type = sender.tag;
    if (type == HotelRoomTypeAllday || type == HotelRoomTypeTypeHours) {
        
        UIButton *alldayBtn = [self viewWithTag:HotelRoomTypeAllday];
        UIButton *hoursBtn = [self viewWithTag:HotelRoomTypeTypeHours];
        if (type == HotelRoomTypeAllday) {
            alldayBtn.selected = YES;
            hoursBtn.selected = NO;
            
            _dateView1.hidden = NO;
            _dateView2.hidden = YES;
        }else {
            alldayBtn.selected = NO;
            hoursBtn.selected = YES;
            
            _dateView1.hidden = YES;
            _dateView2.hidden = NO;
        }
    }
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(hotelDetailDateViewDidClick:)]) {
        [self.delegate hotelDetailRoomTypeCellDidClickBtn:type];
    }
}


- (void)updateConstraints {
    
    [_alldayBtn autoPinEdgeToSuperviewEdge:ALEdgeLeft];
    [_alldayBtn autoPinEdgeToSuperviewEdge:ALEdgeTop];
    [_alldayBtn autoSetDimensionsToSize:CGSizeMake(kScreenWidth/2, 49)];
    
    [_hoursBtn autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:_alldayBtn];
    [_hoursBtn autoPinEdgeToSuperviewEdge:ALEdgeTop];
    [_hoursBtn autoSetDimensionsToSize:CGSizeMake(kScreenWidth/2, 49)];
    
    [_dateView1 autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(49, 0, 0, 0)];
    [_dateView2 autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(49, 0, 0, 0)];
    
    [super updateConstraints];
}

@end
