//
//  HotelDetailCommentCell.m
//  SmartApartment
//
//  Created by jimcky on 2017/8/18.
//  Copyright © 2017年 Jimcky Lin. All rights reserved.
//

#import "HotelCommentCell.h"
#import "JWStarView.h"

@interface HotelCommentCell ()

@property (nonatomic, strong) UIImageView *avatarImgV;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) JWStarView *starsView;
@property (nonatomic, strong) UILabel *scoreLabel;
@property (nonatomic, strong) UILabel *dateLabel;

@property (nonatomic, strong) UILabel *commentLabel;
@property (nonatomic, strong) UIImageView *flagImgV;
@property (nonatomic, strong) UILabel *replyLabel;


@end


@implementation HotelCommentCell

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
    
    // header
    _avatarImgV = [UIImageView new];
    _avatarImgV.contentMode = UIViewContentModeScaleAspectFill;
    _avatarImgV.layer.cornerRadius = 20;
    _avatarImgV.clipsToBounds = YES;
    _avatarImgV.image = kImage(@"share_friend_iciphone");
    [self addSubview:_avatarImgV];
    
    _titleLabel = [UILabel new];
    _titleLabel.font = [UIFont systemFontOfSize:16];
    _titleLabel.textColor = [UIColor darkTextColor];
    _titleLabel.text = @"匿名用户";
    [self addSubview:_titleLabel];
    
    _starsView = [[JWStarView alloc] initWithFrame:CGRectMake(130, 22, 84, 13)];
    _starsView.rateStyle = HalfStar;
    _starsView.isIndicator = YES;
    _starsView.currentScore = 4.5;
    [self addSubview:_starsView];
    
    _scoreLabel = [UILabel new];
    _scoreLabel.font = [UIFont systemFontOfSize:10];
    _scoreLabel.textColor = [UIColor lightGrayColor];
    _scoreLabel.text = @"4.5";
    [self addSubview:_scoreLabel];
    
    _flagImgV = [UIImageView new];
    _flagImgV.contentMode = UIViewContentModeScaleAspectFill;
    _flagImgV.image = [UIImage imageNamed:@"xq_xinyongzhuiphone"];
    [self addSubview:_flagImgV];
    
    _dateLabel = [UILabel new];
    _dateLabel.font = [UIFont systemFontOfSize:11];
    _dateLabel.textColor = [UIColor lightGrayColor];
    _dateLabel.textAlignment = NSTextAlignmentRight;
    _dateLabel.text = @"2017-08-16";
    [self addSubview:_dateLabel];
    
    _commentLabel = [UILabel new];
    _commentLabel.font = [UIFont systemFontOfSize:13];
    _commentLabel.textColor = [UIColor grayColor];
    _commentLabel.text = @"房间很干净卫生，价格合理";
    [self addSubview:_commentLabel];
    
    _replyLabel = [UILabel new];
    _replyLabel.font = [UIFont systemFontOfSize:13];
    _replyLabel.textColor = [UIColor redColor];
    _replyLabel.textAlignment = NSTextAlignmentRight;
    _replyLabel.text = @"尊敬的宾客您好：感谢您对本店的点评和支持";
    [self addSubview:_replyLabel];
}


- (void)updateConstraints {
    
    [_avatarImgV autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:15];
    [_avatarImgV autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:15];
    [_avatarImgV autoSetDimensionsToSize:CGSizeMake(40, 40)];
    
    [_titleLabel autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:_avatarImgV withOffset:10];
    [_titleLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:_avatarImgV withOffset:5];
    [_titleLabel autoSetDimension:ALDimensionWidth toSize:100];
    
    [_scoreLabel autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:_starsView];
    [_scoreLabel autoAlignAxis:ALAxisHorizontal toSameAxisOfView:_starsView];
    [_scoreLabel autoSetDimension:ALDimensionWidth toSize:20];
    
    [_dateLabel autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:15];
    [_dateLabel autoAlignAxis:ALAxisHorizontal toSameAxisOfView:_scoreLabel];
    [_dateLabel autoSetDimensionsToSize:CGSizeMake(65, 20)];

    [_commentLabel autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:10];
    [_commentLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_avatarImgV withOffset:20];
    [_commentLabel autoSetDimension:ALDimensionWidth toSize:kScreenWidth-20];
    
    
    
//    [_flagImgV autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:_titleLabel];
//    [_flagImgV autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_scoreLabel];
//    [_flagImgV autoSetDimensionsToSize:CGSizeMake(34, 12)];
    

//    [_priceLabel autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:10];
//    [_priceLabel autoPinEdge:ALEdgeBottom toEdge:ALEdgeBottom ofView:_thumbImgV];
//    [_priceLabel autoSetDimensionsToSize:CGSizeMake(80, 20)];
    
    [super updateConstraints];
}


@end