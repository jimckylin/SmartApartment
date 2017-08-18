//
//  HotelDetailNoCommentCellCell.m
//  SmartApartment
//
//  Created by jimcky on 2017/8/18.
//  Copyright © 2017年 Jimcky Lin. All rights reserved.
//

#import "HotelDetailNoCommentCellCell.h"
#import <BAButton/BAButton.h>

@implementation HotelDetailNoCommentCellCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor clearColor];
        [self initSubView];
    }
    return self;
}

- (void)initSubView {
    
    
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(10, 0, kScreenWidth - 20, 120)];
    bgView.backgroundColor = [UIColor whiteColor];
    [self addSubview:bgView];
    [bgView ba_view_setViewRectCornerType:BAKit_ViewRectCornerTypeBottomLeftAndBottomRight viewCornerRadius:6];

    UIImageView *imageView = [[UIImageView alloc] initWithImage:kImage(@"detail_blank_commentiphone")];
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    imageView.center = bgView.center;
    [bgView addSubview:imageView];
}


@end
