//
//  OrderDetailView.m
//  SmartApartment
//
//  Created by Jimcky Lin on 2017/8/19.
//  Copyright © 2017年 Jimcky Lin. All rights reserved.
//

#import "OrderDetailView.h"
#import "OrderDetail.h"
#import "RTLabel.h"

@interface OrderDetailView ()

@property (nonatomic, strong) IBOutlet UILabel *storeName;
@property (nonatomic, strong) IBOutlet UILabel *storeType;
@property (nonatomic, strong) IBOutlet UILabel *checkinTime;
@property (nonatomic, strong) IBOutlet UILabel *checkoutTime;
@property (nonatomic, strong) IBOutlet UILabel *payState;
@property (nonatomic, strong) IBOutlet UILabel *livePerson;
@property (nonatomic, strong) IBOutlet UILabel *liveMobilePhone;
@property (nonatomic, strong) IBOutlet UILabel *remark;

@property (nonatomic, strong) IBOutlet UILabel *orderNo;
@property (nonatomic, strong) IBOutlet UILabel *address;
@property (nonatomic, strong) IBOutlet UILabel *storeTel;
@property (nonatomic, strong) IBOutlet RTLabel *cancelRemark;

@property (nonatomic, strong) IBOutlet UIButton *cancelBtn;

@end

@implementation OrderDetailView

- (void)awakeFromNib {
    
    self.cancelBtn.tag = OrderDetailViewBtnTypeCancel;
    [self.cancelBtn addTarget:self action:@selector(cancelBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [super awakeFromNib];
}

- (void)payOrderBtnClick:(UIButton *)sender {
    
    if (self.OrderDetailViewBlock) {
        self.OrderDetailViewBlock(sender.tag);
    }
}

- (IBAction)cancelBtnClick:(UIButton *)sender {
    
    if (self.OrderDetailViewBlock) {
        self.OrderDetailViewBlock(sender.tag);
    }
}

- (void)setOrderDetail:(OrderDetail *)orderDetail {

    self.storeName.text = orderDetail.storeName;
    self.storeType.text = [NSString stringWithFormat:@"%@   %@间", orderDetail.roomType, orderDetail.roomNum];
    
    
    NSDate *checkinDate = [NSDate sia_dateFromString:orderDetail.checkInTime withFormat:@"yyyy-MM-dd"];
    NSDate *checkoutDate = [NSDate sia_dateFromString:orderDetail.checkOutTime withFormat:@"yyyy-MM-dd HH:mm"];
//    NSString *checkinDateStr = [NSString sia_stringFromDate:checkinDate withFormat:@"M月d日"];
//    NSString *checkoutDateStr = [NSString sia_stringFromDate:checkoutDate withFormat:@"MM月dd"];
    NSInteger days = [checkinDate daysBeforeDate:checkoutDate];
    
    self.checkinTime.text = [NSString stringWithFormat:@"%@", orderDetail.checkInTime];
    self.checkoutTime.text = [NSString stringWithFormat:@"%@    共%zd晚", orderDetail.checkOutTime, days];
    self.payState.text = [self orderStateString:orderDetail];
    self.livePerson.text = orderDetail.liveName;
    self.liveMobilePhone.text = orderDetail.mobilePhone;
    self.remark.text = orderDetail.remark;
    self.orderNo.text = orderDetail.orderNo;
    self.address.text = orderDetail.storeAddress;
    self.storeTel.text = orderDetail.storePhone;
    self.cancelRemark.text = orderDetail.cancelPromptInfo;
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
