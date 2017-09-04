//
//  HotelConfigItemCell.m
//  SmartApartment
//
//  Created by Jimcky Lin on 2017/9/4.
//  Copyright © 2017年 Jimcky Lin. All rights reserved.
//

#import "HotelConfigItemCell.h"
#import "RTLabel.h"
#import "Aroma.h"
#import "Breakfast.h"
#import "FivePiece.h"
#import "RoomLayout.h"
#import "Wine.h"

@interface HotelConfigItemCell ()

@property (nonatomic, strong) UIImageView  *imageView;
@property (nonatomic, strong) UIView       *nameBgView;
@property (nonatomic, strong) RTLabel      *nameLabel;

@end

@implementation HotelConfigItemCell

-(id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        
        _imageView = [[UIImageView alloc]initWithFrame:self.bounds];
        _imageView.highlightedImage = [UIImage imageNamed:@"activity02"];
        _imageView.contentMode = UIViewContentModeScaleAspectFill;
        _imageView.clipsToBounds = YES;
        [self addSubview:_imageView];
        
        _nameBgView = [UIView new];
        _nameBgView.backgroundColor = [UIColor whiteColor];
        [self addSubview:_nameBgView];
        [_nameBgView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(0, 0, 0, 0) excludingEdge:ALEdgeTop];
        [_nameBgView autoSetDimension:ALDimensionHeight toSize:20];
        
        _nameLabel = [RTLabel new];
        _nameLabel.font = [UIFont systemFontOfSize:12];
        _nameLabel.textColor = [UIColor grayColor];
        _nameLabel.text = @"中式 0.01";
        [_nameBgView addSubview:_nameLabel];
        [_nameLabel autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(0, 8, 0, 0)];
    }
    
    return self;
    
}


- (void)setAroma:(Aroma *)aroma {
    
    [_imageView sd_setImageWithURL:[NSURL URLWithString:@""] placeholderImage:kImage(@"evaluate_blankiphone")];
    _nameLabel.text = [NSString stringWithFormat:@"%@ <font color=red>%@</font>", aroma.name, aroma.price];
}

- (void)setBreakfast:(Breakfast *)breakfast {
    
    [_imageView sd_setImageWithURL:[NSURL URLWithString:breakfast.img] placeholderImage:kImage(@"evaluate_blankiphone")];
    _nameLabel.text = [NSString stringWithFormat:@"%@ <font color=red>%@</font>", breakfast.name, breakfast.price];
}

- (void)setFivePiece:(FivePiece *)fivePiece {
    
    [_imageView sd_setImageWithURL:[NSURL URLWithString:fivePiece.img] placeholderImage:kImage(@"evaluate_blankiphone")];
    _nameLabel.text = [NSString stringWithFormat:@"%@ <font color=red>%@</font>", fivePiece.name, fivePiece.price];
}

- (void)setRoomLayout:(RoomLayout *)roomLayout {
    
    [_imageView sd_setImageWithURL:[NSURL URLWithString:roomLayout.img] placeholderImage:kImage(@"evaluate_blankiphone")];
    _nameLabel.text = [NSString stringWithFormat:@"%@ <font color=red>%@</font>", roomLayout.name, roomLayout.price];
}

- (void)setWine:(Wine *)wine {
    
    [_imageView sd_setImageWithURL:[NSURL URLWithString:wine.img] placeholderImage:kImage(@"evaluate_blankiphone")];
    _nameLabel.text = [NSString stringWithFormat:@"%@ <font color=red>%@</font>", wine.name, wine.price];
}



- (void)setSelected:(BOOL)selected{
    [super setSelected:selected];
    _imageView.highlighted = selected;
    
    // Configure the view for the selected state
}

@end
