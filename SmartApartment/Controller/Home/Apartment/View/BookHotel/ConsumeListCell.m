//
//  ConsumeListCell.m
//  SmartApartment
//
//  Created by jimcky on 2017/9/8.
//  Copyright © 2017年 Jimcky Lin. All rights reserved.
//

#import "ConsumeListCell.h"

@interface ConsumeListCell ()

@property (nonatomic, strong) UILabel *itemLabel;
@property (nonatomic, strong) UILabel *countLabel;
@property (nonatomic, strong) UILabel *priceLabel;

@end

@implementation ConsumeListCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self initView];
    }
    return self;
}

- (void)initView {
    
    _itemLabel = [UILabel new];
    _itemLabel.font = [UIFont systemFontOfSize:13];
    _itemLabel.textColor = [UIColor darkTextColor];
    _itemLabel.textAlignment = NSTextAlignmentCenter;
    _itemLabel.text = @"房间费";
    [self addSubview:_itemLabel];
    
    _countLabel = [UILabel new];
    _countLabel.font = [UIFont systemFontOfSize:13];
    _countLabel.textColor = [UIColor darkTextColor];
    _countLabel.textAlignment = NSTextAlignmentCenter;
    _countLabel.text = @"X1";
    [self addSubview:_countLabel];
    
    _priceLabel = [UILabel new];
    _priceLabel.font = [UIFont systemFontOfSize:13];
    _priceLabel.textColor = [UIColor darkTextColor];
    _priceLabel.textAlignment = NSTextAlignmentCenter;
    _priceLabel.text = @"¥99起";
    [self addSubview:_priceLabel];
}

- (void)setConsumeDic:(NSDictionary *)consumeDic {
    
    _itemLabel.text = consumeDic[@"consumeName"];
    _countLabel.text = [NSString stringWithFormat:@"X%@", consumeDic[@"consumeNum"]];
    _priceLabel.text = [NSString stringWithFormat:@"¥%@", consumeDic[@"consumePrice"]];
}


+ (BOOL)requiresConstraintBasedLayout {
    return YES;
}

- (void)updateConstraints {
    
    CGFloat width = kScreenWidth/3;
    
    [_itemLabel autoPinEdgeToSuperviewEdge:ALEdgeLeft];
    [_itemLabel autoPinEdgeToSuperviewEdge:ALEdgeTop];
    [_itemLabel autoPinEdgeToSuperviewEdge:ALEdgeBottom];
    [_itemLabel autoSetDimension:ALDimensionWidth toSize:width];
    
    [_countLabel autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:_itemLabel];
    [_countLabel autoPinEdgeToSuperviewEdge:ALEdgeTop];
    [_countLabel autoPinEdgeToSuperviewEdge:ALEdgeBottom];
    [_countLabel autoSetDimension:ALDimensionWidth toSize:width];
    
    [_priceLabel autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:_countLabel];
    [_priceLabel autoPinEdgeToSuperviewEdge:ALEdgeTop];
    [_priceLabel autoPinEdgeToSuperviewEdge:ALEdgeBottom];
    [_priceLabel autoSetDimension:ALDimensionWidth toSize:width];
    
    [super updateConstraints];
}


@end
