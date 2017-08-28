//
//  HotelDescrCell.m
//  SmartApartment
//
//  Created by jimcky on 2017/8/28.
//  Copyright © 2017年 Jimcky Lin. All rights reserved.
//

#import "HotelDescrCell.h"

@interface HotelDescrCell ()

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *descrLabel;

@end

@implementation HotelDescrCell

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
    _titleLabel.text = @"酒店介绍";
    [bgView addSubview:_titleLabel];
    
    _descrLabel = [UILabel new];
    _descrLabel.font = [UIFont systemFontOfSize:12];
    _descrLabel.textColor = [UIColor grayColor];
    _descrLabel.numberOfLines = 0;
    _descrLabel.text = @"酒店介绍酒店介绍酒店介绍酒店介绍酒店介绍酒店介绍酒店介绍酒店介绍酒店介绍酒店介绍酒店介绍酒店介绍酒店介绍酒店介绍酒店介绍酒店介绍酒店介绍酒店介绍酒店介绍酒店介绍酒店介绍酒店介绍酒店介绍酒店介绍酒店介绍酒店介绍酒店介绍酒店介绍酒店介绍酒店介绍酒店介绍酒店介绍酒店介绍酒店介绍酒店介绍酒店介绍酒店介绍酒店介绍酒店介绍酒店介绍酒店介绍酒店介绍";
    [bgView addSubview:_descrLabel];
}

- (void)setRoomPriceDic:(NSDictionary *)roomPriceDic {
    
    
}

+ (CGFloat)getDescrCellHeight:(NSDictionary *)dict {
    
    NSString *text = @"酒店介绍酒店介绍酒店介绍酒店介绍酒店介绍酒店介绍酒店介绍酒店介绍酒店介绍酒店介绍酒店介绍酒店介绍酒店介绍酒店介绍酒店介绍酒店介绍酒店介绍酒店介绍酒店介绍酒店介绍酒店介绍酒店介绍酒店介绍酒店介绍酒店介绍酒店介绍酒店介绍酒店介绍酒店介绍酒店介绍酒店介绍酒店介绍酒店介绍酒店介绍酒店介绍酒店介绍酒店介绍酒店介绍酒店介绍酒店介绍酒店介绍酒店介绍";
    CGFloat width = kScreenWidth - 30;
    
    CGSize contentSize;
    if ([[[UIDevice currentDevice] systemVersion] compare:@"7.0" options:NSNumericSearch] != NSOrderedAscending) {
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
        paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
        //        NSDictionary *attributes = @{NSFontAttributeName:CELL_CONTENT_FONT_SIZE, NSParagraphStyleAttributeName:paragraphStyle.copy};
        NSDictionary *attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:12]};
        
        contentSize = [text boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
    }
    else{
        contentSize = [text sizeWithFont:[UIFont systemFontOfSize:12]
                                  constrainedToSize:CGSizeMake(width, CGFLOAT_MAX)
                                      lineBreakMode:NSLineBreakByWordWrapping];
    }
    
    return contentSize.height + 50;
}

- (void)updateConstraints {
    
    [_titleLabel autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:15];
    [_titleLabel autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:15];
    [_titleLabel autoSetDimension:ALDimensionWidth toSize:kScreenWidth-30];
    
    [_descrLabel autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:15];
    [_descrLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_titleLabel withOffset:5];
    [_descrLabel autoSetDimension:ALDimensionWidth toSize:kScreenWidth - 30];
    
    [super updateConstraints];
}

@end
