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
@property (nonatomic, weak) IBOutlet UIButton *commentBtn;
@property (nonatomic, weak) IBOutlet UIButton *deleteBtn;
@property (nonatomic, weak) IBOutlet UIButton *bookAgainBtn;

@end

@implementation MyOrderCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    self.commentBtn.layer.borderWidth = 1;
    self.commentBtn.layer.borderColor = [UIColor redColor].CGColor;
    
    self.deleteBtn.layer.borderWidth = 1;
    self.deleteBtn.layer.borderColor = [UIColor grayColor].CGColor;
    
    self.bookAgainBtn.layer.borderWidth = 1;
    self.bookAgainBtn.layer.borderColor = [UIColor grayColor].CGColor;
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
    [self configButton:[tripOrder.orderStatus integerValue]];
}

- (void)configButton:(NSInteger)orderState {
    
//    if (orderState == 1) {
//        self.commentBtn.hidden = NO;
//        self.deleteBtn.hidden = NO;
//        self.bookAgainBtn.hidden = YES;
//        
//        [self.commentBtn setTitle:@"取卡验证码" forState:UIControlStateNormal];
//        [self.deleteBtn setTitle:@"取消订单" forState:UIControlStateNormal];
//        
//        self.commentBtn.layer.borderColor = [UIColor redColor].CGColor;
//        self.deleteBtn.layer.borderColor = [UIColor grayColor].CGColor;
//        [self.right1Btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
//        [self.right2Btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
//        
//        
//    }else if (orderState == 2) {
//        self.right1Btn.hidden = NO;
//        self.right2Btn.hidden = NO;
//        self.right3Btn.hidden = NO;
//        self.right4Btn.hidden = NO;
//        
//        [self.right1Btn setTitle:@"续住" forState:UIControlStateNormal];
//        [self.right2Btn setTitle:@"自助退房" forState:UIControlStateNormal];
//        [self.right3Btn setTitle:@"APP开门" forState:UIControlStateNormal];
//        [self.right4Btn setTitle:@"点评" forState:UIControlStateNormal];
//        
//        self.right1Btn.layer.borderColor = [UIColor redColor].CGColor;
//        self.right2Btn.layer.borderColor = [UIColor redColor].CGColor;
//        self.right3Btn.layer.borderColor = [UIColor redColor].CGColor;
//        self.right4Btn.layer.borderColor = [UIColor grayColor].CGColor;
//        [self.right1Btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
//        [self.right2Btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
//        [self.right3Btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
//        [self.right4Btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
//        
//    }else if (orderState == 9) {
//        self.right1Btn.hidden = NO;
//        self.right2Btn.hidden = NO;
//        self.right3Btn.hidden = YES;
//        self.right4Btn.hidden = YES;
//        
//        [self.right1Btn setTitle:@"点评" forState:UIControlStateNormal];
//        [self.right2Btn setTitle:@"删除" forState:UIControlStateNormal];
//        
//        self.right1Btn.layer.borderColor = [UIColor redColor].CGColor;
//        self.right2Btn.layer.borderColor = [UIColor grayColor].CGColor;
//        [self.right1Btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
//        [self.right2Btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
//    }
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
