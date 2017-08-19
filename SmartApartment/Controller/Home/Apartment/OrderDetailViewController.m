//
//  OrderDetailViewController.m
//  SmartApartment
//
//  Created by Jimcky Lin on 2017/8/19.
//  Copyright © 2017年 Jimcky Lin. All rights reserved.
//

#import "OrderDetailViewController.h"
#import "OrderDetailView.h"


@interface OrderDetailViewController ()

@property (nonatomic, strong) IBOutlet UIScrollView *containView;
@property (nonatomic, strong) OrderDetailView *orderDetailView;

@end


@implementation OrderDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _naviLabel.text = @"订单详情";
    
    
    [self.containView addSubview:self.orderDetailView];
    if (_orderDetailView.bottom > self.containView.contentSize.height) {
        self.containView.contentSize = CGSizeMake(0, _orderDetailView.bottom);
    }
    
    [self addEvent];
}

- (void)addEvent {
    
    self.orderDetailView.OrderDetailViewBlock = ^(void){
        
        [[NavManager shareInstance] returnToFrontView:YES];
    };
}


- (OrderDetailView *)orderDetailView {
    if (!_orderDetailView) {
        NSArray *nibView =  [[NSBundle mainBundle] loadNibNamed:@"OrderDetailView"owner:self options:nil];
        _orderDetailView = nibView.lastObject;
    }
    return _orderDetailView;
}


@end
