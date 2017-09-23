//
//  OrderDetailViewController.m
//  SmartApartment
//
//  Created by Jimcky Lin on 2017/8/19.
//  Copyright © 2017年 Jimcky Lin. All rights reserved.
//

#import "OrderDetailViewController.h"
#import "OrderDetailHeaderView.h"
#import "OrderDetailView.h"
#import "OrderViewModel.h"

@interface OrderDetailViewController ()<OrderDetailHeaderViewDelegate>

@property (nonatomic, strong) IBOutlet UIScrollView *containView;
@property (nonatomic, strong) OrderDetailHeaderView *orderDetailHeaderView;
@property (nonatomic, strong) OrderDetailView *orderDetailView;
@property (nonatomic, strong) OrderViewModel  *orderViewModel;

@end


@implementation OrderDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _naviLabel.text = @"订单详情";
    
    [self initView];
    [self initData];
    [self addEvent];
}

- (void)initView {
    
    [self.containView addSubview:self.orderDetailHeaderView];
    [self.containView addSubview:self.orderDetailView];
    
    [self updateHeight];
}

- (void)initData {
    
    __WeakObj(self)
    _orderViewModel = [OrderViewModel new];
    [_orderViewModel requestOrderInfo:self.orderNo complete:^(OrderDetail *orderDetail) {
       
        selfWeak.orderDetailHeaderView.orderDetail = orderDetail;
        selfWeak.orderDetailView.orderDetail = orderDetail;
    }];
}

- (void)addEvent {
    
    self.orderDetailView.OrderDetailViewBlock = ^(OrderDetailViewBtnType type){
        if (type == OrderDetailViewBtnTypePay) {
            [[NavManager shareInstance] returnToFrontView:YES];
        }else {
            
        }
    };
}


#pragma mark - OrderDetailHeaderViewDelegate

- (void)orderDetailHeaderViewUpdateHeight:(CGFloat)height {
    
    [self updateHeight];
}


#pragma mark - Private

- (void)updateHeight {
    
    self.orderDetailView.top = self.orderDetailHeaderView.bottom + 15;
    if (_orderDetailView.bottom > self.containView.contentSize.height) {
        self.containView.contentSize = CGSizeMake(0, _orderDetailView.bottom);
    }
}


#pragma mark - Getter

- (OrderDetailHeaderView *)orderDetailHeaderView {
    if (!_orderDetailHeaderView) {
        NSArray *nibView =  [[NSBundle mainBundle] loadNibNamed:@"OrderDetailHeaderView"owner:self options:nil];
        _orderDetailHeaderView = nibView.lastObject;
        _orderDetailHeaderView.delegate = self;
    }
    return _orderDetailHeaderView;
}

- (OrderDetailView *)orderDetailView {
    if (!_orderDetailView) {
        NSArray *nibView =  [[NSBundle mainBundle] loadNibNamed:@"OrderDetailView"owner:self options:nil];
        _orderDetailView = nibView.lastObject;
    }
    return _orderDetailView;
}


@end
