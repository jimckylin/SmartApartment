//
//  HotelDetailCommentCell.m
//  SmartApartment
//
//  Created by jimcky on 2017/8/18.
//  Copyright © 2017年 Jimcky Lin. All rights reserved.
//

#import "HotelDetailCommentCell.h"
#import "JWStarView.h"
#import "StoreEvaluate.h"

@interface HotelDetailCommentCell ()

@property (nonatomic, strong) UIImageView *avatarImgV;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) JWStarView *starsView;
@property (nonatomic, strong) UILabel *scoreLabel;
@property (nonatomic, strong) UILabel *dateLabel;

@property (nonatomic, strong) UILabel *commentLabel;
@property (nonatomic, strong) UILabel *replyLabel;
@property (nonatomic, strong) UIImageView *replyBg;
@property (nonatomic, strong) UILabel *replyContent;

@end


@implementation HotelDetailCommentCell

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
    
    
    // header
    _avatarImgV = [UIImageView new];
    _avatarImgV.contentMode = UIViewContentModeScaleAspectFill;
    _avatarImgV.layer.cornerRadius = 20;
    _avatarImgV.clipsToBounds = YES;
    _avatarImgV.image = kImage(@"share_friend_iciphone");
    [bgView addSubview:_avatarImgV];
    
    _titleLabel = [UILabel new];
    _titleLabel.font = [UIFont systemFontOfSize:16];
    _titleLabel.textColor = [UIColor darkTextColor];
    _titleLabel.text = @"匿名用户";
    [bgView addSubview:_titleLabel];
    
    _starsView = [[JWStarView alloc] initWithFrame:CGRectMake(130, 22, 84, 13)];
    _starsView.rateStyle = HalfStar;
    _starsView.isIndicator = YES;
    _starsView.currentScore = 4.5;
    [bgView addSubview:_starsView];
    
    _scoreLabel = [UILabel new];
    _scoreLabel.font = [UIFont systemFontOfSize:10];
    _scoreLabel.textColor = [UIColor lightGrayColor];
    _scoreLabel.text = @"4.5";
    [bgView addSubview:_scoreLabel];
    
    _dateLabel = [UILabel new];
    _dateLabel.font = [UIFont systemFontOfSize:11];
    _dateLabel.textColor = [UIColor lightGrayColor];
    _dateLabel.textAlignment = NSTextAlignmentRight;
    _dateLabel.text = @"2017-08-16";
    [bgView addSubview:_dateLabel];
    
    _commentLabel = [UILabel new];
    _commentLabel.font = [UIFont systemFontOfSize:13];
    _commentLabel.textColor = [UIColor darkTextColor];
    _commentLabel.numberOfLines = 0;
    _commentLabel.text = @"房间很干净卫生，价格合理";
    [bgView addSubview:_commentLabel];
    
    _replyLabel = [UILabel new];
    _replyLabel.font = [UIFont systemFontOfSize:13];
    _replyLabel.textColor = [UIColor lightGrayColor];
    _replyLabel.textAlignment = NSTextAlignmentRight;
    _replyLabel.text = @"酒店回复";
    [bgView addSubview:_replyLabel];
    
    _replyBg = [UIImageView new];
    _replyBg.contentMode = UIViewContentModeScaleAspectFill;
    _replyBg.image = kImage(@"");
    _replyBg.backgroundColor = [UIColor lightGrayColor];
    [bgView addSubview:_replyBg];
    
    _replyContent = [UILabel new];
    _replyContent.font = [UIFont systemFontOfSize:11];
    _replyContent.textColor = [UIColor grayColor];
    _replyContent.textAlignment = NSTextAlignmentLeft;
    _replyContent.text = @"尊敬的宾客您好：感谢您对本店的点评和支持";
    _replyContent.numberOfLines = 0;
    [_replyBg addSubview:_replyContent];
}


- (void)setEvaluate:(StoreEvaluate *)evaluate {
    
    _titleLabel.text = evaluate.username;
    _starsView.currentScore = [evaluate.customerScore floatValue];
    _scoreLabel.text = [NSString stringWithFormat:@"%0.1f", [evaluate.customerScore floatValue]];
    _commentLabel.text = evaluate.customerEvaluate;
    _dateLabel.text = evaluate.evaluateDate;
    _replyContent.text = evaluate.storeEvaluate;
    
    _evaluate = evaluate;
}

+ (CGFloat)getCellHeightWith:(StoreEvaluate *)storeEvaluate {
    
    CGFloat hegith = 75 + [Utils getContentHeight:storeEvaluate.customerEvaluate Width:kScreenWidth-20-20 FontSize:13] + 15;
    if (![Utils isBlankString:storeEvaluate.storeEvaluate]) {
        CGFloat storeEvaluateHegith = 30 + 20 + [Utils getContentHeight:storeEvaluate.storeEvaluate Width:kScreenWidth-26-20 FontSize:16];
        hegith += storeEvaluateHegith;
    }
    return hegith;
}


- (void)updateConstraints {
    
    [_avatarImgV autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:5];
    [_avatarImgV autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:15];
    [_avatarImgV autoSetDimensionsToSize:CGSizeMake(40, 40)];
    
    [_titleLabel autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:_avatarImgV withOffset:10];
    [_titleLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:_avatarImgV withOffset:5];
    [_titleLabel autoSetDimension:ALDimensionWidth toSize:100];
    
    [_scoreLabel autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:_starsView];
    [_scoreLabel autoAlignAxis:ALAxisHorizontal toSameAxisOfView:_starsView];
    [_scoreLabel autoSetDimension:ALDimensionWidth toSize:40];
    
    [_dateLabel autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:15];
    [_dateLabel autoAlignAxis:ALAxisHorizontal toSameAxisOfView:_scoreLabel];
    [_dateLabel autoSetDimensionsToSize:CGSizeMake(65, 20)];

    [_commentLabel autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:10];
    [_commentLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_avatarImgV withOffset:20];
    [_commentLabel autoSetDimension:ALDimensionWidth toSize:kScreenWidth-20-20];
    
    if (![Utils isBlankString:_evaluate.storeEvaluate]) {
        [_replyLabel autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:5];
        [_replyLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_commentLabel withOffset:20];
        [_replyLabel autoSetDimension:ALDimensionWidth toSize:80];
        
        [_replyBg autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:5];
        [_replyBg autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:5];
        [_replyBg autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_replyLabel];
        
        CGFloat hegith = 20 + [Utils getContentHeight:_evaluate.storeEvaluate Width:kScreenWidth-26-20 FontSize:11];
        [_replyBg autoSetDimension:ALDimensionHeight toSize:hegith];
        
        [_replyContent autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(10, 8, 10, 8)];
    }
    
    [super updateConstraints];
}


@end
