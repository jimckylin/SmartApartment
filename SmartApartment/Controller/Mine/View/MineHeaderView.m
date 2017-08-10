//
//  MineHeaderView.m
//  SmartApartment
//
//  Created by jimcky on 2017/8/10.
//  Copyright © 2017年 Jimcky Lin. All rights reserved.
//

#import "MineHeaderView.h"

@interface MineHeaderView ()

@property (nonatomic, strong) UIImageView *headImgView;

@property (nonatomic, strong) UIButton *cityBtn;
@property (nonatomic, strong) UIButton *locateBtn;
@property (nonatomic, strong) UIButton *liveBtn;
@property (nonatomic, strong) UIButton *leaveBtn;

@property (nonatomic, strong) UILabel *nickNameLabel;
@property (nonatomic, strong) UILabel *levelLabel;

@end


@implementation MineHeaderView

- (instancetype)init {
    
    self = [super initWithFrame:CGRectMake(0, 0, kScreenWidth, 150)];
    if (self) {
        [self initView];
    }
    return self;
}

- (void)initView {
    
    _headImgView = [UIImageView new];
    _headImgView.image = [UIImage imageNamed:@"mine_headiphone"];
    _headImgView.contentMode = UIViewContentModeScaleAspectFill;
    _headImgView.layer.cornerRadius = 56/2;
    _headImgView.layer.masksToBounds = YES;
    _headImgView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    _headImgView.layer.borderWidth = 1;
    [self addSubview:_headImgView];
    
    _nickNameLabel = [UILabel new];
    _nickNameLabel.font = [UIFont systemFontOfSize:14];
    _nickNameLabel.textColor = [UIColor whiteColor];
    _nickNameLabel.text = @"15888888888";
    [self addSubview:_nickNameLabel];
    
    _levelLabel = [UILabel new];
    _levelLabel.font = [UIFont systemFontOfSize:13];
    _levelLabel.textColor = [UIColor whiteColor];
    _levelLabel.text = @"网客";
    [self addSubview:_levelLabel];
    

}


- (void)updateConstraints {
    
    CGFloat paddingX = 25;
    
    [_headImgView autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:paddingX];
    [_headImgView autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:paddingX];
    [_headImgView autoSetDimensionsToSize:CGSizeMake(56, 56)];
    
    [_nickNameLabel autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:_headImgView withOffset:25];
    [_nickNameLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:_headImgView];
    [_nickNameLabel autoSetDimensionsToSize:CGSizeMake(kScreenWidth-100, 20)];
    
    [_levelLabel autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:_nickNameLabel];
    [_levelLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_nickNameLabel withOffset:5];
    [_levelLabel autoSetDimensionsToSize:CGSizeMake(50, 20)];
    
//    [_locateBtn autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:paddingX];
//    [_locateBtn autoPinEdgeToSuperviewEdge:ALEdgeTop];
//    [_locateBtn autoSetDimensionsToSize:CGSizeMake(75, 50)];
//    
//    [_liveBtn autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:paddingX];
//    [_liveBtn autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_cityBtn];
//    [_liveBtn autoSetDimensionsToSize:CGSizeMake(65, 50)];
//    
//    [_leaveBtn autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:paddingX + 30];
//    [_leaveBtn autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_cityBtn];
//    [_leaveBtn autoSetDimensionsToSize:CGSizeMake(65, 50)];
//    
//    [_liveLabel autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:_liveBtn];
//    [_liveLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_cityBtn];
//    [_liveLabel autoSetDimensionsToSize:CGSizeMake(30, 50)];
//    
//    [_leaveLabel autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:paddingX];
//    [_leaveLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_cityBtn];
//    [_leaveLabel autoSetDimensionsToSize:CGSizeMake(30, 50)];
//    
//    [_countLabel autoAlignAxisToSuperviewAxis:ALAxisVertical];
//    [_countLabel autoAlignAxis:ALAxisHorizontal toSameAxisOfView:_liveLabel];
//    [_countLabel autoSetDimensionsToSize:CGSizeMake(40, 15)];
//    
//    [_extraLabel autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:paddingX];
//    [_extraLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_liveLabel];
//    [_extraLabel autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:paddingX+30];
//    [_extraLabel autoSetDimension:ALDimensionHeight toSize:40];
//    
//    [_arrowIconV autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:paddingX];
//    [_arrowIconV autoAlignAxis:ALAxisHorizontal toSameAxisOfView:_extraLabel];
//    //[_countLabel autoSetDimensionsToSize:CGSizeMake(40, 15)];
//    
//    [_searchBtn autoAlignAxisToSuperviewAxis:ALAxisVertical];
//    [_searchBtn autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_extraLabel withOffset:20];
//    [_searchBtn autoSetDimensionsToSize:CGSizeMake(kScreenWidth-80, 40)];
    
    [super updateConstraints];
}

@end
