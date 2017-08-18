//
//  HotelDetailCommentHeaderCell.m
//  SmartApartment
//
//  Created by jimcky on 2017/8/18.
//  Copyright © 2017年 Jimcky Lin. All rights reserved.
//

#import "HotelDetailCommentHeaderCell.h"
#import <BAButton/BAButton.h>

@interface HotelDetailCommentHeaderCell ()

@property (nonatomic, strong) UILabel *goodCommentRatioLabel;
@property (nonatomic, strong) UILabel *scoreLabel;
@property (nonatomic, strong) UIImageView *flagImgV;
@property (nonatomic, strong) UILabel *tagLabel;
@property (nonatomic, strong) UILabel *remainLabel;
@property (nonatomic, strong) UILabel *priceLabel;

@end


@implementation HotelDetailCommentHeaderCell

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
    
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(10, 0, kScreenWidth-20, 80)];
    bgView.backgroundColor = [UIColor whiteColor];
    bgView.layer.cornerRadius = 6;
    [self addSubview:bgView];
    [bgView ba_view_setViewRectCornerType:BAKit_ViewRectCornerTypeTopLeftAndTopRight viewCornerRadius:6];
    
    _scoreLabel = [UILabel new];
    _scoreLabel.font = [UIFont systemFontOfSize:16];
    _scoreLabel.textColor = [UIColor redColor];
    _scoreLabel.textAlignment = NSTextAlignmentCenter;
    _scoreLabel.text = @"4.8分";
    [bgView addSubview:_scoreLabel];
    
    _goodCommentRatioLabel = [UILabel new];
    _goodCommentRatioLabel.font = [UIFont systemFontOfSize:10];
    _goodCommentRatioLabel.textColor = [UIColor lightGrayColor];
    _goodCommentRatioLabel.textAlignment = NSTextAlignmentCenter;
    _goodCommentRatioLabel.text = @"100%好评";
    [bgView addSubview:_goodCommentRatioLabel];
    
    
    _flagImgV = [UIImageView new];
    _flagImgV.contentMode = UIViewContentModeScaleAspectFill;
    _flagImgV.image = [UIImage imageNamed:@"xq_xinyongzhuiphone"];
    [bgView addSubview:_flagImgV];
    
    _tagLabel = [UILabel new];
    _tagLabel.font = [UIFont systemFontOfSize:11];
    _tagLabel.textColor = [UIColor redColor];
    _tagLabel.layer.cornerRadius = 2;
    _tagLabel.text = @"很安静";
    [bgView addSubview:_tagLabel];
    
    _remainLabel = [UILabel new];
    _remainLabel.font = [UIFont systemFontOfSize:12];
    _remainLabel.textColor = [UIColor redColor];
    _remainLabel.text = @"仅剩4间客房";
    [bgView addSubview:_remainLabel];
    
    _priceLabel = [UILabel new];
    _priceLabel.font = [UIFont systemFontOfSize:13];
    _priceLabel.textColor = [UIColor redColor];
    _priceLabel.textAlignment = NSTextAlignmentRight;
    _priceLabel.text = @"¥99起";
    [bgView addSubview:_priceLabel];
}


- (void)updateConstraints {
    
    [_scoreLabel autoPinEdgeToSuperviewEdge:ALEdgeLeft];
    [_scoreLabel autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:20];
    [_scoreLabel autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:30];
    [_scoreLabel autoSetDimension:ALDimensionWidth toSize:100];
    
    [_goodCommentRatioLabel autoPinEdgeToSuperviewEdge:ALEdgeLeft];
    [_goodCommentRatioLabel autoPinEdge:ALEdgeRight toEdge:ALEdgeRight ofView:_scoreLabel];
    [_goodCommentRatioLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_scoreLabel];
    
    
    
    
//    [_flagImgV autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:_titleLabel];
//    [_flagImgV autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_scoreLabel];
//    [_flagImgV autoSetDimensionsToSize:CGSizeMake(34, 12)];
//    
//    [_tagLabel autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:_titleLabel];
//    [_tagLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_flagImgV];
//    [_tagLabel autoSetDimensionsToSize:CGSizeMake(50, 20)];
//    
//    [_remainLabel autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:_tagLabel];
//    [_remainLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_flagImgV];
//    [_remainLabel autoSetDimensionsToSize:CGSizeMake(120, 20)];
//    
//    [_priceLabel autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:10];
//    [_priceLabel autoPinEdge:ALEdgeBottom toEdge:ALEdgeBottom ofView:_thumbImgV];
//    [_priceLabel autoSetDimensionsToSize:CGSizeMake(80, 20)];
    
    [super updateConstraints];
}


@end

