//
//  HotelDetailCommentHeaderCell.m
//  SmartApartment
//
//  Created by jimcky on 2017/8/18.
//  Copyright © 2017年 Jimcky Lin. All rights reserved.
//

#import "HotelCommentHeaderCell.h"
#import <BAButton/BAButton.h>
#import "JKProgressView.h"

@interface HotelCommentHeaderCell ()

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

@property (nonatomic, strong) UILabel *hygieneScore;     // 卫生
@property (nonatomic, strong) UILabel *serviceScore;     // 服务
@property (nonatomic, strong) UILabel *envirmentScore;   // 环境
@property (nonatomic, strong) UILabel *cpRatioScore;     // 性价比


@property (nonatomic, strong) NSMutableArray *btnArray;
@property (nonatomic, strong) UIView *indicatorLine;

@end


@implementation HotelCommentHeaderCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor whiteColor];
        [self initSubView];
    }
    return self;
}

+ (BOOL)requiresConstraintBasedLayout {
    return YES;
}

- (void)initSubView {
    
    _scoreLabel = [UILabel new];
    _scoreLabel.font = [UIFont systemFontOfSize:16];
    _scoreLabel.textColor = [UIColor redColor];
    _scoreLabel.textAlignment = NSTextAlignmentCenter;
    _scoreLabel.text = @"4.8分";
    [self addSubview:_scoreLabel];
    
    _goodCommentRatioLabel = [UILabel new];
    _goodCommentRatioLabel.font = [UIFont systemFontOfSize:10];
    _goodCommentRatioLabel.textColor = [UIColor lightGrayColor];
    _goodCommentRatioLabel.textAlignment = NSTextAlignmentCenter;
    _goodCommentRatioLabel.text = @"100%好评";
    [self addSubview:_goodCommentRatioLabel];
    
    UIView *line = [UIView new];
    line.backgroundColor = [UIColor lightGrayColor];
    [self addSubview:line];
    [line autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:90];
    [line autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:15];
    [line autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:73];
    [line autoSetDimension:ALDimensionWidth toSize:0.5];
    

    // 评价比率
    _hygieneLabel = [UILabel new];
    _hygieneLabel.font = [UIFont systemFontOfSize:10];
    _hygieneLabel.textColor = [UIColor lightGrayColor];
    _hygieneLabel.layer.cornerRadius = 2;
    _hygieneLabel.text = @"卫生";
    [self addSubview:_hygieneLabel];
    
    _serviceLabel = [UILabel new];
    _serviceLabel.font = [UIFont systemFontOfSize:10];
    _serviceLabel.textColor = [UIColor lightGrayColor];
    _serviceLabel.text = @"服务";
    [self addSubview:_serviceLabel];
    
    _envirmentLabel = [UILabel new];
    _envirmentLabel.font = [UIFont systemFontOfSize:10];
    _envirmentLabel.textColor = [UIColor lightGrayColor];
    _envirmentLabel.text = @"环境";
    [self addSubview:_envirmentLabel];
    
    _cpRatioLabel = [UILabel new];
    _cpRatioLabel.font = [UIFont systemFontOfSize:10];
    _cpRatioLabel.textColor = [UIColor lightGrayColor];
    _cpRatioLabel.text = @"性价比";
    [self addSubview:_cpRatioLabel];
    
    
    _hygieneProgress = [[JKProgressView alloc] initWithFrame:CGRectMake(165, 17, 90, 4)];
    _hygieneProgress.progress = 1;
    [self addSubview:_hygieneProgress];
    
    _serviceProgress = [[JKProgressView alloc] initWithFrame:CGRectMake(165, 30, 90, 4)];
    _serviceProgress.progress = 1;
    [self addSubview:_serviceProgress];
    
    _envirmentProgress = [[JKProgressView alloc] initWithFrame:CGRectMake(165, 43, 90, 4)];
    _envirmentProgress.progress = 1;
    [self addSubview:_envirmentProgress];
    
    _cpRatioProgress = [[JKProgressView alloc] initWithFrame:CGRectMake(165, 56, 90, 4)];
    _cpRatioProgress.progress = 1;
    [self addSubview:_cpRatioProgress];
    
    _hygieneScore = [UILabel new];
    _hygieneScore.font = [UIFont systemFontOfSize:10];
    _hygieneScore.textColor = [UIColor lightGrayColor];
    _hygieneScore.layer.cornerRadius = 2;
    _hygieneScore.text = @"4.0";
    [self addSubview:_hygieneScore];
    
    _serviceScore = [UILabel new];
    _serviceScore.font = [UIFont systemFontOfSize:10];
    _serviceScore.textColor = [UIColor lightGrayColor];
    _serviceScore.text = @"4.0";
    [self addSubview:_serviceScore];
    
    _envirmentScore = [UILabel new];
    _envirmentScore.font = [UIFont systemFontOfSize:10];
    _envirmentScore.textColor = [UIColor lightGrayColor];
    _envirmentScore.text = @"4.0";
    [self addSubview:_envirmentScore];
    
    _cpRatioScore = [UILabel new];
    _cpRatioScore.font = [UIFont systemFontOfSize:10];
    _cpRatioScore.textColor = [UIColor lightGrayColor];
    _cpRatioScore.text = @"4.0";
    [self addSubview:_cpRatioScore];
    
    // 评价类型
    UIView *line1 = [UIView new];
    line1.frame = CGRectMake(0, 80, kScreenWidth, 0.5);
    line1.backgroundColor = [UIColor lightGrayColor];
    [self addSubview:line1];
    
    UIView *btnBg = [UIView new];
    [self addSubview:btnBg];
    [btnBg autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(80, 0, 0, 0)];
    
    if (!_btnArray) {
        _btnArray = [NSMutableArray new];
    }
    NSArray *titles = @[@"全部", @"好评", @"中评", @"差评"];
    CGFloat width = kScreenWidth/4;
    for (NSInteger index = 0; index < 4; index ++) {
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(width*index, 0, width, 58);
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [btn setTitle:titles[index] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
        [btn.titleLabel setFont:[UIFont systemFontOfSize:13]];
        btn.tag = index;
        [btnBg addSubview:btn];
        if (index == 0) {
            btn.selected = YES;
        }
        [_btnArray addObject:btn];
    }
    _indicatorLine = [UIView new];
    _indicatorLine.backgroundColor = [UIColor redColor];
    [self addSubview:_indicatorLine];
    [_indicatorLine autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:(width-60)/2];
    [_indicatorLine autoPinEdgeToSuperviewEdge:ALEdgeBottom];
    [_indicatorLine autoSetDimensionsToSize:CGSizeMake(60, 3)];
}


#pragma mark - UIButton Action

- (void)btnClick:(UIButton *)sender {
    
    CommentType type = sender.tag;
    
    for (NSInteger index = 0; index < 4; index ++) {
        UIButton *btn = _btnArray[index];
        if (sender.tag == btn.tag) {
            btn.selected = YES;
        }else {
            btn.selected = NO;
        }
    }
    CGFloat width = kScreenWidth/4;
    NSLog(@"%f", (width-60)/2+ sender.tag*width);
    _indicatorLine.left = (width-60)/2+ sender.tag*width;
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(hotelCommentHeaderCellDidClick:)]) {
        [self.delegate hotelCommentHeaderCellDidClick:type];
    }
}


- (void)setStoreEvaluateList:(StoreEvaluateList *)storeEvaluateList {
    
    _scoreLabel.text = [NSString stringWithFormat:@"%@分", storeEvaluateList.storeScore];
    _goodCommentRatioLabel.text = [NSString stringWithFormat:@"%@好评", storeEvaluateList.storePercent];
    
    _hygieneProgress.progress = [storeEvaluateList.storeRoomHealthScore floatValue]/5;
    _serviceProgress.progress = [storeEvaluateList.storeHotelScore floatValue]/5;
    _envirmentProgress.progress = [storeEvaluateList.storeEnvironmentScore floatValue]/5;
    _cpRatioProgress.progress = [storeEvaluateList.storeDeviceScore floatValue]/5;
    
    _hygieneScore.text = storeEvaluateList.storeRoomHealthScore;
    _serviceScore.text = storeEvaluateList.storeHotelScore;
    _envirmentScore.text = storeEvaluateList.storeEnvironmentScore;
    _cpRatioScore.text = storeEvaluateList.storeDeviceScore;
    
    NSArray *titles = @[@"全部(46)", @"好评(34)", @"中评(10)", @"差评(2)"];
    for (NSInteger index = 0; index < 4; index ++) {
        UIButton *btn = _btnArray[index];
        [btn setTitle:titles[index] forState:UIControlStateNormal];
    }
}


- (void)updateConstraints {
    
    [_scoreLabel autoPinEdgeToSuperviewEdge:ALEdgeLeft];
    [_scoreLabel autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:20];
    [_scoreLabel autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:30+58];
    [_scoreLabel autoSetDimension:ALDimensionWidth toSize:90];
    
    [_goodCommentRatioLabel autoPinEdgeToSuperviewEdge:ALEdgeLeft];
    [_goodCommentRatioLabel autoPinEdge:ALEdgeRight toEdge:ALEdgeRight ofView:_scoreLabel];
    [_goodCommentRatioLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_scoreLabel];
    
    //
    [_hygieneLabel autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:_scoreLabel withOffset:35];
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
    
    [_hygieneScore autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:265];
    [_hygieneScore autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:13];
    [_hygieneScore autoSetDimensionsToSize:CGSizeMake(40, 13)];
    
    [_serviceScore autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:265];
    [_serviceScore autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_hygieneLabel];
    [_serviceScore autoSetDimensionsToSize:CGSizeMake(40, 13)];
    
    [_envirmentScore autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:265];
    [_envirmentScore autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_serviceLabel];
    [_envirmentScore autoSetDimensionsToSize:CGSizeMake(40, 13)];
    
    [_cpRatioScore autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:265];
    [_cpRatioScore autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_envirmentLabel];
    [_cpRatioScore autoSetDimensionsToSize:CGSizeMake(40, 13)];
    
    
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

