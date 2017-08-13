//
//  HotelListCell.m
//  SmartApartment
//
//  Created by Jimcky Lin on 2017/8/14.
//  Copyright © 2017年 Jimcky Lin. All rights reserved.
//

#import "HotelListCell.h"

@interface HotelListCell ()

@property (nonatomic, strong) UIImageView *thumbImgV;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *decrLabel;
@property (nonatomic, strong) UILabel *dateLabel;
@property (nonatomic, strong) UILabel *tagLabel;

@end


@implementation HotelListCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initSubView];
    }
    return self;
}

+ (BOOL)requiresConstraintBasedLayout {
    return YES;
}

- (void)initSubView {
    
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 552/2)];
    bgView.backgroundColor = [UIColor whiteColor];
    [self addSubview:bgView];
    
    _thumbImgV = [UIImageView new];
    _thumbImgV.contentMode = UIViewContentModeScaleAspectFill;
    _thumbImgV.image = [UIImage imageNamed:@"activity02"];
    _thumbImgV.clipsToBounds = YES;
    [self addSubview:_thumbImgV];
    
    _titleLabel = [UILabel new];
    _titleLabel.font = [UIFont systemFontOfSize:17];
    _titleLabel.textColor = [UIColor darkTextColor];
    _titleLabel.text = @"优客酒店北京朝阳区双桥东路店";
    [self addSubview:_titleLabel];
    
    _decrLabel = [UILabel new];
    _decrLabel.font = [UIFont systemFontOfSize:14];
    _decrLabel.textColor = [UIColor lightGrayColor];
    _decrLabel.text = @"学生证在手，住遍天下都不怕!";
    [self addSubview:_decrLabel];
    
    _dateLabel = [UILabel new];
    _dateLabel.font = [UIFont systemFontOfSize:10];
    _dateLabel.textColor = [UIColor lightGrayColor];
    _dateLabel.text = @"2017.06.26-2017.08.30";
    [self addSubview:_dateLabel];
    
    _tagLabel = [UILabel new];
    _tagLabel.backgroundColor = [UIColor redColor];
    _tagLabel.font = [UIFont systemFontOfSize:12];
    _tagLabel.textColor = [UIColor whiteColor];
    _tagLabel.textAlignment = NSTextAlignmentCenter;
    _tagLabel.layer.cornerRadius = 2;
    _tagLabel.text = @"限时活动";
    [self addSubview:_tagLabel];
}


- (void)updateConstraints {
    
    CGFloat margin = 15.f;
    
    [_thumbImgV autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:5];
    [_thumbImgV autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:8];
    [_thumbImgV autoSetDimensionsToSize:CGSizeMake(110, 94)];
    
    [_titleLabel autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:_thumbImgV withOffset:7.5];
    [_titleLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:_thumbImgV];
    [_titleLabel autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:5];
    
    /*[_decrLabel autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:margin];
    [_decrLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_titleLabel];
    [_decrLabel autoSetDimensionsToSize:CGSizeMake(kScreenWidth-30, 22)];
    
    [_dateLabel autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:margin];
    [_dateLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_decrLabel];
    [_dateLabel autoSetDimensionsToSize:CGSizeMake(kScreenWidth-100, 20)];
    
    [_tagLabel autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:margin];
    [_tagLabel autoAlignAxis:ALAxisHorizontal toSameAxisOfView:_titleLabel];
    [_tagLabel autoSetDimensionsToSize:CGSizeMake(90, 17)];*/
    
    [super updateConstraints];
}


@end
