//
//  OrderDetailHeaderView.m
//  SmartApartment
//
//  Created by Jimcky Lin on 2017/9/23.
//  Copyright © 2017年 Jimcky Lin. All rights reserved.
//

#import "OrderDetailHeaderView.h"
#import "OrderDetail.h"


@interface OrderDetailHeaderView ()

@property (weak, nonatomic) IBOutlet UIImageView *imgBgView;
@property (weak, nonatomic) IBOutlet UILabel *stateLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalPriceLabel;

@property (weak, nonatomic) IBOutlet UILabel *roomDepositLabel;
@property (weak, nonatomic) IBOutlet UILabel *roomPriceLabel;



@end


@implementation OrderDetailHeaderView


- (void)awakeFromNib {
    [super awakeFromNib];
    
    UIImage *image = [kImage(@"order_fill_bgiphone") resizableImageWithCapInsets:UIEdgeInsetsMake(10, 10, 50, 300)];
    self.imgBgView.image = image;
}

- (void)setOrderDetail:(OrderDetail *)orderDetail {
    
    self.stateLabel.text = [self orderStateString:orderDetail];
    self.totalPriceLabel.text = [NSString stringWithFormat:@"¥%@", orderDetail.consumeSumPrice];
    self.roomDepositLabel.text = [NSString stringWithFormat:@"押金:  ¥%@(可退)", orderDetail.roomDepositPrice];
    
    // 消费列表
    NSMutableArray *arr = [NSMutableArray array];
    if (orderDetail.roomRisePrice) {
        NSString *string = [NSString stringWithFormat:@"节假加价:  ¥%@", orderDetail.roomRisePrice];
        [arr addObject:string];
    }
    for (Consume *consume in orderDetail.consumeList) {
        NSString *string = [NSString stringWithFormat:@"%@  ￥%@", consume.consumeName, consume.consumePrice];
        [arr addObject:string];
    }
    
    UILabel *preLabel = self.roomDepositLabel;
    for (NSString *string in arr) {
        
        UILabel *label = [UILabel new];
        label.font = [UIFont systemFontOfSize:12];
        label.textColor = [UIColor lightGrayColor];
        label.text = string;
        [self addSubview:label];
        
        [label autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:preLabel];
        [label autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:preLabel];
        [label autoSetDimensionsToSize:CGSizeMake(200, 18)];
        
        preLabel = label;
    }

    
    CGFloat height = self.roomDepositLabel.bottom + [arr count]*18 + 20;
    [self setHeight:height];
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(orderDetailHeaderViewUpdateHeight:)]) {
        [self.delegate orderDetailHeaderViewUpdateHeight:height];
    }
}



- (NSString *)orderStateString:(OrderDetail *)orderDetail {
    
    NSString *string = @"";
    NSInteger orderState = [orderDetail.orderStatus integerValue];
    if (orderState == 0) {
        string = @"待支付";
    }else if (orderState == 1) {
        string = @"待入住";
    }else if (orderState == 2) {
        string = @"已入住";
    }else if (orderState == 3) {
        string = @"退房申请(退房申请已提交，请等待查房)";
    }else if (orderState == 4) {
        string = @"已查房(物件有损坏请联系前台人员)";
    }else if (orderState == 5) {
        string = @"确认退房(请自助机办理退房)";
    }else if (orderState == 6) {
        string = @"退款成功";
    }else if (orderState == 7) {
        string = @"取消订单";
    }else if (orderState == 9) {
        string = @"已离店";
    }
    
    return string;
}

@end
