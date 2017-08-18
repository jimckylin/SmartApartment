//
//  HotelDetailMoreCommentCell.m
//  SmartApartment
//
//  Created by jimcky on 2017/8/18.
//  Copyright © 2017年 Jimcky Lin. All rights reserved.
//

#import "HotelDetailMoreCommentCell.h"
#import <BAButton/BAButton.h>

@implementation HotelDetailMoreCommentCell

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
    
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(10, 0, kScreenWidth - 20, 40)];
    bgView.backgroundColor = [UIColor whiteColor];
    [self addSubview:bgView];
    [bgView ba_view_setViewRectCornerType:BAKit_ViewRectCornerTypeBottomLeftAndBottomRight viewCornerRadius:6];
    
    UILabel *label = [UILabel new];
    label.font = [UIFont systemFontOfSize:13];
    label.textColor = [UIColor grayColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.text = @"查看全部45条评论";
    [bgView addSubview:label];
    [label autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
    
}


- (void)updateConstraints {
    
    
    [super updateConstraints];
}

@end

