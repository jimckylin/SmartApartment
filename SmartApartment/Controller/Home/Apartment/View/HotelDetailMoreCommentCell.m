//
//  HotelDetailMoreCommentCell.m
//  SmartApartment
//
//  Created by jimcky on 2017/8/18.
//  Copyright © 2017年 Jimcky Lin. All rights reserved.
//

#import "HotelDetailMoreCommentCell.h"
#import <BAButton/BAButton.h>
#import "HotelDetail.h"

@interface HotelDetailMoreCommentCell ()

@property (nonatomic, strong) UILabel *label;
@property (nonatomic, strong) UIImageView *arrowImgV;

@end

@implementation HotelDetailMoreCommentCell

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
    
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(10, 0, kScreenWidth - 20, 40)];
    bgView.backgroundColor = [UIColor whiteColor];
    [self addSubview:bgView];
    [bgView ba_view_setViewRectCornerType:BAKit_ViewRectCornerTypeBottomLeftAndBottomRight viewCornerRadius:6];
    
    _label = [UILabel new];
    _label.font = [UIFont systemFontOfSize:13];
    _label.textColor = [UIColor grayColor];
    _label.textAlignment = NSTextAlignmentCenter;
    _label.text = @"查看全部0条评论";
    [bgView addSubview:_label];
    
    _arrowImgV = [[UIImageView alloc] initWithImage:kImage(@"home_arrow_iconiphone")];
    [bgView addSubview:_arrowImgV];
    
    
    [_label autoAlignAxisToSuperviewAxis:ALAxisVertical];
    [_label autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
    
    [_arrowImgV autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:_label withOffset:5];
    [_arrowImgV autoAlignAxis:ALAxisHorizontal toSameAxisOfView:_label];
}

- (void)setHotelDetail:(HotelDetail *)hotelDetail {
    
    _label.text = [NSString stringWithFormat:@"查看全部%@条评论", hotelDetail.evaluateTotal];
}

- (void)updateConstraints {
    
    
    [super updateConstraints];
}

@end

