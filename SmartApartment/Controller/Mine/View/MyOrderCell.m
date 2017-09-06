//
//  MyOrderCell.m
//  SmartApartment
//
//  Created by Jimcky Lin on 2017/8/22.
//  Copyright © 2017年 Jimcky Lin. All rights reserved.
//

#import "MyOrderCell.h"
#import "TripOrder.h"

@interface MyOrderCell ()


@property (nonatomic, weak) IBOutlet UILabel *storeName;
@property (weak, nonatomic) IBOutlet UILabel *address;
@property (weak, nonatomic) IBOutlet UILabel *checkinCheckoutDate;
@property (nonatomic, weak) IBOutlet UILabel *state;
@property (nonatomic, weak) IBOutlet UILabel *consumeSumPrice;

@property (nonatomic, weak) IBOutlet UIView   *bgView;
@property (nonatomic, weak) IBOutlet UIButton *cancelOrderBtn;
@property (nonatomic, weak) IBOutlet UIButton *payOrderBtn;
@end

@implementation MyOrderCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    self.cancelOrderBtn.layer.borderWidth = 1;
    self.cancelOrderBtn.layer.borderColor = [UIColor grayColor].CGColor;
    
    self.payOrderBtn.layer.borderWidth = 1;
    self.payOrderBtn.layer.borderColor = [UIColor redColor].CGColor;
}


- (void)setTripOrder:(TripOrder *)tripOrder {
    
    NSDate *checkinDate = [NSDate sia_dateFromString:tripOrder.checkInTime withFormat:@"yyyy-MM-dd"];
    NSDate *checkoutDate = [NSDate sia_dateFromString:tripOrder.checkOutTime withFormat:@"yyyy-MM-dd"];
    
    //NSString *checkinStr = [NSString sia_stringFromDate:checkinDate withFormat:@"yyyy年MM月dd日"];
    NSInteger days = [checkinDate daysBeforeDate:checkoutDate];
    
    self.storeName.text = tripOrder.storeName;
    self.address.text = tripOrder.address;
    self.checkinCheckoutDate.text = [NSString stringWithFormat:@"%@至%@     %zd晚%@间", tripOrder.checkInTime, tripOrder.checkOutTime, days, @"1"];
    self.state.text = [self orderStateString:tripOrder];
}


- (NSString *)orderStateString:(TripOrder *)tripOrder {
    
    NSString *string = @"";
    NSInteger orderState = [tripOrder.orderStatus integerValue];
    if (orderState == 0) {
        string = @"待支付";
    }else if (orderState == 1) {
        string = @"待入住";
    }else if (orderState == 2) {
        string = @"已入住";
    }else if (orderState == 3) {
        string = @"退房申请";
    }else if (orderState == 4) {
        string = @"已查房";
    }else if (orderState == 5) {
        string = @"确认退房";
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
