//
//  TripListCell.m
//  SmartApartment
//
//  Created by Jimcky Lin on 2017/8/20.
//  Copyright © 2017年 Jimcky Lin. All rights reserved.
//

#import "TripListCell.h"

@interface TripListCell ()

@property (nonatomic, strong) IBOutlet UIView   *bgView;
@property (nonatomic, strong) IBOutlet UIButton *cancelOrderBtn;
@property (nonatomic, strong) IBOutlet UIButton *payOrderBtn;
@end

@implementation TripListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    self.cancelOrderBtn.layer.borderWidth = 1;
    self.cancelOrderBtn.layer.borderColor = [UIColor grayColor].CGColor;
    
    self.payOrderBtn.layer.borderWidth = 1;
    self.payOrderBtn.layer.borderColor = [UIColor redColor].CGColor;
    
    
    self.bgView.layer.shadowColor = [UIColor blackColor].CGColor;//shadowColor阴影颜色
    self.bgView.layer.shadowOffset = CGSizeMake(4,4);//shadowOffset阴影偏移,x向右偏移4，y向下偏移4，默认(0, -3),这个跟shadowRadius配合使用
    self.bgView.layer.shadowOpacity = 0.8;//阴影透明度，默认0
    self.bgView.layer.shadowRadius = 4;//阴影半径，默认3
}


- (void)setButtonStyleHistoryTrip {
    
    [self.cancelOrderBtn setTitle:@"删除" forState:UIControlStateNormal];
    [self.payOrderBtn setTitle:@"点评" forState:UIControlStateNormal];
    
    [self.cancelOrderBtn addTarget:self action:@selector(deleteBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.payOrderBtn addTarget:self action:@selector(commentBtnClick) forControlEvents:UIControlEventTouchUpInside];
}


- (void)deleteBtnClick{
    if (self.tripListCellBlock) {
        self.tripListCellBlock(0);
    }
}

- (void)commentBtnClick{
    if (self.tripListCellBlock) {
        self.tripListCellBlock(1);
    }
}


@end
