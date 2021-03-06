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
@property (nonatomic, strong) IBOutlet UIButton *right1Btn;
@property (nonatomic, strong) IBOutlet UIButton *right2Btn;
@property (nonatomic, strong) IBOutlet UIButton *right3Btn;
@property (nonatomic, strong) IBOutlet UIButton *right4Btn;

@end

@implementation MyOrderCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    self.right1Btn.layer.borderWidth = 1;
    self.right2Btn.layer.borderWidth = 1;
    self.right3Btn.layer.borderWidth = 1;
    self.right4Btn.layer.borderWidth = 1;
    
    
    CGFloat btnWidth = (self.bgView.width - 14 - 10 - 8*3)/4;
    
    [self.right1Btn autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:14];
    [self.right1Btn autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:8];
    [self.right1Btn autoSetDimensionsToSize:CGSizeMake(btnWidth, 30)];
    
    [self.right2Btn autoPinEdge:ALEdgeRight toEdge:ALEdgeLeft ofView:self.right1Btn withOffset:-8];
    [self.right2Btn autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:8];
    [self.right2Btn autoSetDimensionsToSize:CGSizeMake(btnWidth, 30)];
    
    [self.right3Btn autoPinEdge:ALEdgeRight toEdge:ALEdgeLeft ofView:self.right2Btn withOffset:-8];
    [self.right3Btn autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:8];
    [self.right3Btn autoSetDimensionsToSize:CGSizeMake(btnWidth, 30)];
    
    [self.right4Btn autoPinEdge:ALEdgeRight toEdge:ALEdgeLeft ofView:self.right3Btn withOffset:-8];
    [self.right4Btn autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:8];
    [self.right4Btn autoSetDimensionsToSize:CGSizeMake(btnWidth, 30)];
}


- (void)setTripOrder:(TripOrder *)tripOrder {
    
    _tripOrder = tripOrder;
    NSDate *checkinDate = [NSDate sia_dateFromString:tripOrder.checkInTime withFormat:@"yyyy-MM-dd"];
    NSDate *checkoutDate = [NSDate sia_dateFromString:tripOrder.checkOutTime withFormat:@"yyyy-MM-dd"];
    
    //NSString *checkinStr = [NSString sia_stringFromDate:checkinDate withFormat:@"yyyy年MM月dd日"];
    NSInteger days = [checkinDate daysBeforeDate:checkoutDate];
    
    self.storeName.text = tripOrder.storeName;
    self.address.text = tripOrder.address;
    self.checkinCheckoutDate.text = [NSString stringWithFormat:@"%@至%@     %zd晚%@间", tripOrder.checkInTime, tripOrder.checkOutTime, days, @"1"];
    self.consumeSumPrice.text = [NSString stringWithFormat:@"￥%@", tripOrder.consumeSumPrice];
    self.state.text = [self orderStateString:tripOrder];
    [self configButton:[tripOrder.orderStatus integerValue]];
}

- (void)configButton:(NSInteger)orderState {
    
    // （0-待支付，1-待入住，2-已入住，3-退房申请(退房申请已提交，请等待查房)，4-已查房(物件有损坏请联系前台人员)，5-确认退房(请自助机办理退房)，6-退款成功，7-取消订单,9-已离店)
    if (orderState == 1) {
        self.right1Btn.hidden = NO;
        self.right2Btn.hidden = YES;
        self.right3Btn.hidden = YES;
        self.right4Btn.hidden = YES;
        
        [self.right1Btn setTitle:@"取消订单" forState:UIControlStateNormal];
        
        self.right1Btn.layer.borderColor = [UIColor grayColor].CGColor;
        [self.right1Btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        
    }else if (orderState == 2 || orderState == 9) {
        //（0-待评论，1-已评论)
        if ([_tripOrder.evaluateStatus integerValue] == 0) {
            self.right1Btn.hidden = NO;
        }else {
            self.right1Btn.hidden = YES;
        }
        self.right2Btn.hidden = YES;
        self.right3Btn.hidden = YES;
        self.right4Btn.hidden = YES;
        
        [self.right1Btn setTitle:@"点评" forState:UIControlStateNormal];
        self.right1Btn.layer.borderColor = [UIColor redColor].CGColor;
        [self.right1Btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        
    }else  {
        self.right1Btn.hidden = YES;
        self.right2Btn.hidden = YES;
        self.right3Btn.hidden = YES;
        self.right4Btn.hidden = YES;
    }
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


- (IBAction)btnClick:(UIButton *)sender {
    
    // NSInteger tag = sender.tag;
    TripCellBtnType type = TripCellBtnTypeNone;
    
    NSInteger orderState = [_tripOrder.orderStatus integerValue];
    if (orderState == 1) {
        type = TripCellBtnTypeCancelOrder;
    }
    else if (orderState == 2 || orderState == 9) {
        type = TripCellBtnTypeCommentRoom;
    }
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(myOrderCellDidClcikBtnType:order:)]) {
        [self.delegate myOrderCellDidClcikBtnType:type order:self.tripOrder];
    }
    
}

@end
