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

@end

@implementation OrderDetailView

- (void)awakeFromNib {
    
    [self.payOrderBtn addTarget:self action:@selector(payOrderBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [super awakeFromNib];
}

- (void)payOrderBtnClick:(id)sender {
    
    if (self.OrderDetailViewBlock) {
        self.OrderDetailViewBlock();
    }
}

@end
