//
//  StarHotelCell.m
//  SmartApartment
//
//  Created by Jimcky Lin on 2017/8/31.
//  Copyright © 2017年 Jimcky Lin. All rights reserved.
//

#import "StarHotelCell.h"
#import "JWStarView.h"

@interface StarHotelCell ()

@property (nonatomic, strong) UILabel *hygieneLabel;     // 卫生
@property (nonatomic, strong) UILabel *envirmentLabel;   // 环境
@property (nonatomic, strong) UILabel *serviceLabel;     // 服务
@property (nonatomic, strong) UILabel *deviceLabel;      // 设施

@property (nonatomic, strong) JWStarView *hygieneStarsView;     // 房间卫生
@property (nonatomic, strong) JWStarView *envirmentStarsView;   // 周围环境
@property (nonatomic, strong) JWStarView *serviceStarsView;     // 酒店服务
@property (nonatomic, strong) JWStarView *deviceStarsView;      // 设施服务

@property (nonatomic, strong) UITextView *commentTextView;
@end


@implementation StarHotelCell

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
    [bgView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
    
    // 评价比率
    _hygieneLabel = [UILabel new];
    _hygieneLabel.font = [UIFont systemFontOfSize:14];
    _hygieneLabel.textColor = [UIColor darkTextColor];
    _hygieneLabel.text = @"房间卫生";
    [bgView addSubview:_hygieneLabel];
    
    _envirmentLabel = [UILabel new];
    _envirmentLabel.font = [UIFont systemFontOfSize:14];
    _envirmentLabel.textColor = [UIColor darkTextColor];
    _envirmentLabel.text = @"周围环境";
    [bgView addSubview:_envirmentLabel];
    
    _serviceLabel = [UILabel new];
    _serviceLabel.font = [UIFont systemFontOfSize:14];
    _serviceLabel.textColor = [UIColor darkTextColor];
    _serviceLabel.text = @"酒店服务";
    [bgView addSubview:_serviceLabel];
    
    _deviceLabel = [UILabel new];
    _deviceLabel.font = [UIFont systemFontOfSize:14];
    _deviceLabel.textColor = [UIColor darkTextColor];
    _deviceLabel.text = @"设施服务";
    [bgView addSubview:_deviceLabel];
    
    
    _hygieneStarsView = [[JWStarView alloc] initWithFrame:CGRectMake(90, 8, 100, 20)];
    _hygieneStarsView.rateStyle = HalfStar;
    _hygieneStarsView.isIndicator = YES;
    _hygieneStarsView.currentScore = 4.5;
    [bgView addSubview:_hygieneStarsView];
    
    _envirmentStarsView = [[JWStarView alloc] initWithFrame:CGRectMake(90, _hygieneStarsView.bottom+18, 100, 20)];
    _envirmentStarsView.rateStyle = HalfStar;
    _envirmentStarsView.isIndicator = YES;
    _envirmentStarsView.currentScore = 4.5;
    [bgView addSubview:_envirmentStarsView];
    
    _serviceStarsView = [[JWStarView alloc] initWithFrame:CGRectMake(90, _envirmentStarsView.bottom+18, 100, 20)];
    _serviceStarsView.rateStyle = HalfStar;
    _serviceStarsView.isIndicator = YES;
    _serviceStarsView.currentScore = 4.5;
    [bgView addSubview:_serviceStarsView];
    
    _deviceStarsView = [[JWStarView alloc] initWithFrame:CGRectMake(90, _serviceStarsView.bottom+18, 100, 20)];
    _deviceStarsView.rateStyle = HalfStar;
    _deviceStarsView.isIndicator = YES;
    _deviceStarsView.currentScore = 4.5;
    [bgView addSubview:_deviceStarsView];
    
    
    UIView *line = [UIView new];
    line.backgroundColor = [UIColor lightGrayColor];
    [bgView addSubview:line];
    [line autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:12];
    [line autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_deviceLabel withOffset:10];
    [line autoPinEdgeToSuperviewEdge:ALEdgeRight];
    [line autoSetDimension:ALDimensionHeight toSize:0.5];
    
    _commentTextView = [UITextView new];
    _commentTextView.backgroundColor = [UIColor lightGrayColor];
    _commentTextView.font = [UIFont systemFontOfSize:13];
    _commentTextView.textColor = [UIColor grayColor];
    _commentTextView.text = @"写下您的入住体验，帮助千万用户挑选到心仪的酒店";
    [bgView addSubview:_commentTextView];
}

- (void)setCommentHeaderDic:(NSDictionary *)commentDic {
    
    
}

- (void)updateConstraints {
    
    CGFloat margin = 12;
    //
    [_hygieneLabel autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:margin];
    [_hygieneLabel autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:8];
    [_hygieneLabel autoSetDimensionsToSize:CGSizeMake(60, 20)];
    
    [_envirmentLabel autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:_hygieneLabel];
    [_envirmentLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_hygieneLabel withOffset:18];
    [_envirmentLabel autoSetDimensionsToSize:CGSizeMake(60, 20)];
    
    [_serviceLabel autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:_hygieneLabel];
    [_serviceLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_envirmentLabel withOffset:18];
    [_serviceLabel autoSetDimensionsToSize:CGSizeMake(60, 20)];
    
    [_deviceLabel autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:_hygieneLabel];
    [_deviceLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_serviceLabel withOffset:18];
    [_deviceLabel autoSetDimensionsToSize:CGSizeMake(60, 20)];
    
    [_commentTextView autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_deviceLabel withOffset:20];
    [_commentTextView autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:margin];
    [_commentTextView autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:margin];
    [_commentTextView autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:margin];
    
    [super updateConstraints];
}


@end
