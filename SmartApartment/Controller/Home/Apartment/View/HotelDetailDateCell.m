//
//  HotelDetailDateCell.m
//  SmartApartment
//
//  Created by jimcky on 2017/8/17.
//  Copyright © 2017年 Jimcky Lin. All rights reserved.
//

#import "HotelDetailDateCell.h"
@interface HotelDetailDateCell ()

@property (nonatomic, strong) UIButton *liveBtn;
@property (nonatomic, strong) UIButton *leaveBtn;

@property (nonatomic, strong) UILabel *liveLabel;
@property (nonatomic, strong) UILabel *leaveLabel;
@property (nonatomic, strong) UILabel *countLabel;

@end


@implementation HotelDetailDateCell

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
    
    CGFloat paddingX = 30;
    
    [_liveBtn autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:paddingX];
    [_liveBtn autoPinEdgeToSuperviewEdge:ALEdgeTop];
    [_liveBtn autoSetDimensionsToSize:CGSizeMake(65, 50)];
    
    [_liveLabel autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:_liveBtn];
    [_liveLabel autoPinEdgeToSuperviewEdge:ALEdgeTop];
    [_liveLabel autoSetDimensionsToSize:CGSizeMake(30, 50)];
    
    // 是否
    if (self.roomType == HotelRoomTypeAllday) {
        [_leaveBtn autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:paddingX + 30];
        [_leaveBtn autoPinEdgeToSuperviewEdge:ALEdgeTop];
        [_leaveBtn autoSetDimensionsToSize:CGSizeMake(65, 50)];
        
        [_leaveLabel autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:paddingX];
        [_leaveLabel autoPinEdgeToSuperviewEdge:ALEdgeTop];
        [_leaveLabel autoSetDimensionsToSize:CGSizeMake(30, 50)];
        
        [_countLabel autoAlignAxisToSuperviewAxis:ALAxisVertical];
        [_countLabel autoAlignAxis:ALAxisHorizontal toSameAxisOfView:_liveLabel];
        [_countLabel autoSetDimensionsToSize:CGSizeMake(40, 15)];
    }
    
    [super updateConstraints];
}


@end
