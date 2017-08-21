//
//  OrderDetailView.m
//  SmartApartment
//
//  Created by Jimcky Lin on 2017/8/19.
//  Copyright © 2017年 Jimcky Lin. All rights reserved.
//

#import "OrderDetailView.h"

@interface OrderDetailView ()

@property (nonatomic, strong) IBOutlet UIButton *payOrderBtn;
@property (nonatomic, strong) IBOutlet UIButton *cancelBtn;

@end

@implementation OrderDetailView

- (void)awakeFromNib {
    self.payOrderBtn.tag = OrderDetailViewBtnTypePay;
    [self.payOrderBtn addTarget:self action:@selector(payOrderBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    self.cancelBtn.tag = OrderDetailViewBtnTypeCancel;
    [self.cancelBtn addTarget:self action:@selector(cancelBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [super awakeFromNib];
}

- (void)payOrderBtnClick:(UIButton *)sender {
    
    if (self.OrderDetailViewBlock) {
        self.OrderDetailViewBlock(sender.tag);
    }
}

- (void)cancelBtnClick:(UIButton *)sender {
    
    if (self.OrderDetailViewBlock) {
        self.OrderDetailViewBlock(sender.tag);
    }
}


@end
