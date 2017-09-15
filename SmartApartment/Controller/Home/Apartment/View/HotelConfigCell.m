//
//  HotelConfigCell.m
//  SmartApartment
//
//  Created by Jimcky Lin on 2017/8/28.
//  Copyright © 2017年 Jimcky Lin. All rights reserved.
//

#import "HotelConfigCell.h"
#import "Hotel.h"

@interface HotelConfigCell ()

@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation HotelConfigCell

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
    
    _titleLabel = [UILabel new];
    _titleLabel.font = [UIFont systemFontOfSize:15];
    _titleLabel.textColor = [UIColor darkTextColor];
    _titleLabel.text = @"公寓设施";
    [bgView addSubview:_titleLabel];
}


- (void)setHotel:(Hotel *)hotel {
    
    CGFloat width = (kScreenWidth-15)/3;
    CGFloat height = 25;
    
    UIView *tagBgView = [UIView new];
    tagBgView.frame = CGRectMake(15, 35, kScreenWidth - 15, 20);
    [self addSubview:tagBgView];
    
    NSArray *devices = [hotel.storeDevice componentsSeparatedByString:@" "];
    for (NSInteger index = 0; index< [devices count]; index ++) {
        NSInteger shang = index/3;
        NSInteger yushu = index%3;
        
        UILabel *tagLabel = [[UILabel alloc] initWithFrame:CGRectMake(yushu*width, shang*height, width, height)];
        tagLabel.textColor = [UIColor grayColor];
        tagLabel.font = [UIFont systemFontOfSize:12];
        tagLabel.text = devices[index];
        [tagBgView addSubview:tagLabel];
    }
    
    NSInteger shang = [devices count]/3;
    NSInteger yushu = [devices count]%3;
    
    if ([devices count] >0) {
        CGFloat tagBgVHeight = height * (shang+(yushu?0:1));
        tagBgView.height = tagBgVHeight;
    }
}

+ (CGFloat)getCellHeight:(Hotel *)hotel {

    CGFloat tagHeight = 25;
    NSArray *devices = [hotel.storeDevice componentsSeparatedByString:@" "];

    NSInteger shang = [devices count]/3;
    NSInteger yushu = [devices count]%3;
    
    CGFloat height = 35 + tagHeight * (shang+(yushu?1:0)) +10;
    return height;
}


- (void)updateConstraints {
    
    [_titleLabel autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:15];
    [_titleLabel autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:15];
    [_titleLabel autoSetDimension:ALDimensionWidth toSize:kScreenWidth-30];
    
    
    [super updateConstraints];
}

@end
