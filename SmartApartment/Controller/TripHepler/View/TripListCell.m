//
//  TripListCell.m
//  SmartApartment
//
//  Created by Jimcky Lin on 2017/8/20.
//  Copyright © 2017年 Jimcky Lin. All rights reserved.
//

#import "TripListCell.h"

@interface TripListCell ()

@property (weak, nonatomic) IBOutlet UILabel *checkinDateHeader;
@property (nonatomic, weak) IBOutlet UILabel *state;
@property (nonatomic, weak) IBOutlet UILabel *storeName;
@property (weak, nonatomic) IBOutlet UIImageView *thumbImgView;
@property (weak, nonatomic) IBOutlet UILabel *address;
@property (nonatomic, weak) IBOutlet UILabel *storeType;
@property (nonatomic, weak) IBOutlet UILabel *checkinDate;
@property (nonatomic, weak) IBOutlet UILabel *checkoutDate;
@property (nonatomic, weak) IBOutlet UILabel *lastCheckinTime;
@property (nonatomic, weak) IBOutlet UILabel *checkinDay;
@property (nonatomic, weak) IBOutlet UILabel *checkoutDay;



@property (nonatomic, strong) IBOutlet UIView   *bgView;
@property (nonatomic, strong) IBOutlet UIButton *cancelOrderBtn;
@property (nonatomic, strong) IBOutlet UIButton *payOrderBtn;
@end

@implementation TripListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    self.thumbImgView.contentMode = UIViewContentModeScaleAspectFill;
    self.thumbImgView.clipsToBounds = YES;
    
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

- (void)setTripOrder:(TripOrder *)tripOrder {
    
    NSDate *checkinDate = [NSDate sia_dateFromString:tripOrder.checkInTime withFormat:@"yyyy-MM-dd"];
    NSDate *checkoutDate = [NSDate sia_dateFromString:tripOrder.checkOutTime withFormat:@"yyyy-MM-dd"];
    
    NSString *checkinStr = [NSString sia_stringFromDate:checkinDate withFormat:@"yyyy年MM月dd日"];
    NSString *checkinWeek = [checkinDate weekDayStr];
    NSString *checkoutWeek = [checkoutDate weekDayStr];
    
    self.checkinDateHeader.text = [NSString stringWithFormat:@"%@ %@", checkinStr, checkinWeek];
    self.storeName.text = tripOrder.storeName;
    self.storeName.text = tripOrder.storeName;
    self.state.text = [self orderStateString:tripOrder];
    [self.thumbImgView sd_setImageWithURL:[NSURL URLWithString:tripOrder.storeImage] placeholderImage:kImage(@"travel_details_blankiphone")];
    self.address.text = tripOrder.address;
    
    self.checkinDate.text = [NSString stringWithFormat:@"%zd月\n%@", [checkinDate month], checkinWeek];
    self.checkoutDate.text = [NSString stringWithFormat:@"%zd月\n%@", [checkoutDate month], checkoutWeek];
    self.checkinDay.text = [NSString stringWithFormat:@"%zd", [checkinDate day]];
    self.checkinDay.text = [NSString stringWithFormat:@"%zd", [checkoutDate day]];
    
    self.storeType.text = tripOrder.roomType;
    self.lastCheckinTime.text = tripOrder.lastCheckInTime;
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
