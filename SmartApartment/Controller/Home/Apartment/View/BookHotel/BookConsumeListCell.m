//
//  ConsumeListCell.m
//  SmartApartment
//
//  Created by jimcky on 2017/9/8.
//  Copyright © 2017年 Jimcky Lin. All rights reserved.
//

#import "BookConsumeListCell.h"

@interface BookConsumeListCell ()

@property (nonatomic, strong) UILabel *itemLabel;
@property (nonatomic, strong) UILabel *priceLabel;

@end

@implementation BookConsumeListCell

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
    _itemLabel.font = [UIFont systemFontOfSize:11];
    _itemLabel.textColor = [UIColor lightGrayColor];
    _itemLabel.textAlignment = NSTextAlignmentCenter;
    _itemLabel.text = @"房间费";
    [self addSubview:_itemLabel];
    
    _priceLabel = [UILabel new];
    _priceLabel.font = [UIFont systemFontOfSize:11];
    _priceLabel.textColor = [UIColor lightGrayColor];
    _priceLabel.textAlignment = NSTextAlignmentCenter;
    _priceLabel.text = @"¥99起";
    [self addSubview:_priceLabel];
}

- (void)setConsumeDic:(NSDictionary *)consumeDic {
    
    _itemLabel.text = [consumeDic allKeys][0];
    _priceLabel.text = [consumeDic allValues][0];
}


+ (BOOL)requiresConstraintBasedLayout {
    return YES;
}

- (void)updateConstraints {
    
    [_itemLabel autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:15];
    [_itemLabel autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
    
    [_priceLabel autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:15];
    [_priceLabel autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
    
    [super updateConstraints];
}


@end
