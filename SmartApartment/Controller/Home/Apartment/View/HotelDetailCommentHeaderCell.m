//
//  HotelDetailCommentHeaderCell.m
//  SmartApartment
//
//  Created by jimcky on 2017/8/18.
//  Copyright © 2017年 Jimcky Lin. All rights reserved.
//

#import "HotelDetailCommentHeaderCell.h"
#import <BAButton/BAButton.h>
#import "JKProgressView.h"

@interface HotelDetailCommentHeaderCell ()

@property (nonatomic, strong) UILabel *goodCommentRatioLabel;
@property (nonatomic, strong) UILabel *scoreLabel;

@property (nonatomic, strong) UILabel *hygieneLabel;     // 卫生
@property (nonatomic, strong) UILabel *serviceLabel;     // 服务
@property (nonatomic, strong) UILabel *envirmentLabel;   // 环境
@property (nonatomic, strong) UILabel *cpRatioLabel;     // 性价比

@property (nonatomic, strong) JKProgressView *hygieneProgress;     // 卫生
@property (nonatomic, strong) JKProgressView *serviceProgress;     // 服务
@property (nonatomic, strong) JKProgressView *envirmentProgress;   // 环境
@property (nonatomic, strong) JKProgressView *cpRatioProgress;     // 性价比

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
    
    UIView *line = [UIView new];
    line.backgroundColor = [UIColor lightGrayColor];
    [bgView addSubview:line];
    [line autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:100];
    [line autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:15];
    [line autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:15];
    [line autoSetDimension:ALDimensionWidth toSize:0.5];
    

    // 评价比率
    _hygieneLabel = [UILabel new];
    _hygieneLabel.font = [UIFont systemFontOfSize:10];
    _hygieneLabel.textColor = [UIColor lightGrayColor];
    _hygieneLabel.layer.cornerRadius = 2;
    _hygieneLabel.text = @"卫生";
    [bgView addSubview:_hygieneLabel];
    
    _serviceLabel = [UILabel new];
    _serviceLabel.font = [UIFont systemFontOfSize:10];
    _serviceLabel.textColor = [UIColor lightGrayColor];
    _serviceLabel.text = @"服务";
    [bgView addSubview:_serviceLabel];
    
    _envirmentLabel = [UILabel new];
    _envirmentLabel.font = [UIFont systemFontOfSize:10];
    _envirmentLabel.textColor = [UIColor lightGrayColor];
    _envirmentLabel.text = @"环境";
    [bgView addSubview:_envirmentLabel];
    
    _cpRatioLabel = [UILabel new];
    _cpRatioLabel.font = [UIFont systemFontOfSize:10];
    _cpRatioLabel.textColor = [UIColor lightGrayColor];
    _cpRatioLabel.text = @"性价比";
    [bgView addSubview:_cpRatioLabel];
    
    
    _hygieneProgress = [[JKProgressView alloc] initWithFrame:CGRectMake(180, 17, 80, 4)];
    _hygieneProgress.progress = 1;
    [bgView addSubview:_hygieneProgress];
    
    _serviceProgress = [[JKProgressView alloc] initWithFrame:CGRectMake(180, 30, 80, 4)];
    _serviceProgress.progress = 1;
    [bgView addSubview:_serviceProgress];
    
    _envirmentProgress = [[JKProgressView alloc] initWithFrame:CGRectMake(180, 43, 80, 4)];
    _envirmentProgress.progress = 1;
    [bgView addSubview:_envirmentProgress];
    
    _cpRatioProgress = [[JKProgressView alloc] initWithFrame:CGRectMake(180, 56, 80, 4)];
    _cpRatioProgress.progress = 1;
    [bgView addSubview:_cpRatioProgress];
    
}

- (void)setCommentHeaderDic:(NSDictionary *)commentDic {
    
    _hygieneProgress.progress = 1;
    _serviceProgress.progress = 0.89;
    _envirmentProgress.progress = 1;
    _cpRatioProgress.progress = 0.9;
}

- (void)updateConstraints {
    
    [_scoreLabel autoPinEdgeToSuperviewEdge:ALEdgeLeft];
    [_scoreLabel autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:20];
    [_scoreLabel autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:30];
    [_scoreLabel autoSetDimension:ALDimensionWidth toSize:100];
    
    [_goodCommentRatioLabel autoPinEdgeToSuperviewEdge:ALEdgeLeft];
    [_goodCommentRatioLabel autoPinEdge:ALEdgeRight toEdge:ALEdgeRight ofView:_scoreLabel];
    [_goodCommentRatioLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_scoreLabel];
    
    //
    [_hygieneLabel autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:_scoreLabel withOffset:40];
    [_hygieneLabel autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:13];
    [_hygieneLabel autoSetDimensionsToSize:CGSizeMake(40, 13)];
    
    [_serviceLabel autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:_hygieneLabel];
    [_serviceLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_hygieneLabel];
    [_serviceLabel autoSetDimensionsToSize:CGSizeMake(40, 13)];
    
    [_envirmentLabel autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:_hygieneLabel];
    [_envirmentLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_serviceLabel];
    [_envirmentLabel autoSetDimensionsToSize:CGSizeMake(40, 13)];
    
    [_cpRatioLabel autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:_hygieneLabel];
    [_cpRatioLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_envirmentLabel];
    [_cpRatioLabel autoSetDimensionsToSize:CGSizeMake(40, 13)];
    
    
    
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

