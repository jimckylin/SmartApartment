//
//  CommentHeaderCell.m
//  SmartApartment
//
//  Created by Jimcky Lin on 2017/8/31.
//  Copyright © 2017年 Jimcky Lin. All rights reserved.
//

#import "CommentHeaderCell.h"
#import "TripOrder.h"

@interface CommentHeaderCell ()

@property (nonatomic, strong) UIImageView *iconV;
@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation CommentHeaderCell

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
    bgView.backgroundColor = [UIColor clearColor];
    [self addSubview:bgView];
    [bgView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
    
    UIImageView *bgImageV = [[UIImageView alloc] initWithImage:kImage(@"order_fill_bgiphone")];
    bgImageV.contentMode = UIViewContentModeScaleAspectFill;
    [bgView addSubview:bgImageV];
    [bgImageV autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
    
    _iconV = [[UIImageView alloc] initWithImage:kImage(@"illustraion_commentiphone")];
    _iconV.contentMode = UIViewContentModeCenter;
    [bgView addSubview:_iconV];
    
    _titleLabel = [UILabel new];
    _titleLabel.font = [UIFont systemFontOfSize:15];
    _titleLabel.textColor = [UIColor darkTextColor];
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    _titleLabel.text = @"尚客优酒店广东深圳坂田五河地铁站店";
    [bgView addSubview:_titleLabel];
}

- (void)setTripOrder:(TripOrder *)tripOrder {
    
    _titleLabel.text = tripOrder.storeName;
}

- (void)updateConstraints {
    
    [_iconV autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:3];
    [_iconV autoPinEdgeToSuperviewEdge:ALEdgeLeft];
    [_iconV autoPinEdgeToSuperviewEdge:ALEdgeRight];
    [_iconV autoSetDimension:ALDimensionHeight toSize:112];
    
    [_titleLabel autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:12];
    [_titleLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_iconV];
    [_titleLabel autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:12];
    
    
    [super updateConstraints];
}

@end

