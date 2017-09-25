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
@property (weak, nonatomic) IBOutlet UIView *storeNameBgView;
@property (weak, nonatomic) IBOutlet UIImageView *thumbImgView;
@property (weak, nonatomic) IBOutlet UILabel *address;
@property (nonatomic, weak) IBOutlet UILabel *storeType;
@property (nonatomic, weak) IBOutlet UILabel *checkinDate;
@property (nonatomic, weak) IBOutlet UILabel *checkoutDate;
@property (nonatomic, weak) IBOutlet UILabel *lastCheckinTime;
@property (nonatomic, weak) IBOutlet UILabel *checkinDay;
@property (nonatomic, weak) IBOutlet UILabel *checkoutDay;



@property (nonatomic, strong) IBOutlet UIView   *bgView;
//@property (nonatomic, strong) IBOutlet UIButton *cancelOrderBtn;
//@property (nonatomic, strong) IBOutlet UIButton *payOrderBtn;

@property (nonatomic, strong) IBOutlet UIButton *right1Btn;
@property (nonatomic, strong) IBOutlet UIButton *right2Btn;
@property (nonatomic, strong) IBOutlet UIButton *right3Btn;
@property (nonatomic, strong) IBOutlet UIButton *right4Btn;


@end

@implementation TripListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    self.bgView.layer.shadowColor = [UIColor blackColor].CGColor;//shadowColor阴影颜色
    self.bgView.layer.shadowOffset = CGSizeMake(4,4);//shadowOffset阴影偏移,x向右偏移4，y向下偏移4，默认(0, -3),这个跟shadowRadius配合使用
    self.bgView.layer.shadowOpacity = 0.8;//阴影透明度，默认0
    self.bgView.layer.shadowRadius = 4;//阴影半径，默认3
    
    self.thumbImgView.contentMode = UIViewContentModeScaleAspectFill;
    self.thumbImgView.clipsToBounds = YES;
    
    
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
    
    NSString *checkinStr = [NSString sia_stringFromDate:checkinDate withFormat:@"yyyy年MM月dd日"];
    NSString *checkinWeek = [checkinDate weekDayStr];
    NSString *checkoutWeek = [checkoutDate weekDayStr];
    
    self.checkinDateHeader.text = [NSString stringWithFormat:@"%@ %@", checkinStr, checkinWeek];
    self.storeName.text = tripOrder.storeName;
    self.storeName.text = tripOrder.storeName;
    self.state.text = [self orderStateString:tripOrder];
    [self.thumbImgView sd_setImageWithURL:[NSURL URLWithString:tripOrder.storeImage] placeholderImage:kImage(@"blank_default_nomal_bg")];
    self.address.text = tripOrder.address;
    
    self.checkinDate.text = [NSString stringWithFormat:@"%zd月\n%@", [checkinDate month], checkinWeek];
    self.checkoutDate.text = [NSString stringWithFormat:@"%zd月\n%@", [checkoutDate month], checkoutWeek];
    self.checkinDay.text = [NSString stringWithFormat:@"%zd", [checkinDate day]];
    self.checkoutDay.text = [NSString stringWithFormat:@"%zd", [checkoutDate day]];
    
    self.storeType.text = tripOrder.roomType;
    self.lastCheckinTime.text = tripOrder.lastCheckInTime;
    
    [self configButton:[tripOrder.orderStatus integerValue]];
    //[self configButton:2];
    
    if (self.isHistory) {
        self.storeNameBgView.backgroundColor = [UIColor lightGrayColor];
    }
}

- (void)configButton:(NSInteger)orderState {
    
    if (orderState == 1) {
        self.right1Btn.hidden = NO;
        self.right2Btn.hidden = NO;
        self.right3Btn.hidden = YES;
        self.right4Btn.hidden = YES;
        
        [self.right1Btn setTitle:@"入住码" forState:UIControlStateNormal];
        [self.right2Btn setTitle:@"取消订单" forState:UIControlStateNormal];
        
        self.right1Btn.layer.borderColor = [UIColor redColor].CGColor;
        self.right2Btn.layer.borderColor = [UIColor grayColor].CGColor;
        [self.right1Btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [self.right2Btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        
        
    }else if (orderState == 2) {
        self.right1Btn.hidden = NO;
        self.right2Btn.hidden = NO;
        self.right3Btn.hidden = NO;
        self.right4Btn.hidden = NO;
        
        [self.right1Btn setTitle:@"续住" forState:UIControlStateNormal];
        [self.right2Btn setTitle:@"自助退房" forState:UIControlStateNormal];
        [self.right3Btn setTitle:@"APP开门" forState:UIControlStateNormal];
        [self.right4Btn setTitle:@"点评" forState:UIControlStateNormal];
        
        self.right1Btn.layer.borderColor = [UIColor redColor].CGColor;
        self.right2Btn.layer.borderColor = [UIColor redColor].CGColor;
        self.right3Btn.layer.borderColor = [UIColor redColor].CGColor;
        self.right4Btn.layer.borderColor = [UIColor grayColor].CGColor;
        [self.right1Btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [self.right2Btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [self.right3Btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [self.right4Btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        
    }else if (orderState == 9) {
        self.right1Btn.hidden = NO;
        self.right2Btn.hidden = NO;
        self.right3Btn.hidden = YES;
        self.right4Btn.hidden = YES;
        
        [self.right1Btn setTitle:@"点评" forState:UIControlStateNormal];
        [self.right2Btn setTitle:@"删除" forState:UIControlStateNormal];
        
        self.right1Btn.layer.borderColor = [UIColor redColor].CGColor;
        self.right2Btn.layer.borderColor = [UIColor grayColor].CGColor;
        [self.right1Btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [self.right2Btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
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
    
    NSInteger tag = sender.tag;
    TripCellBtnType type = TripCellBtnTypeNone;
    
    NSInteger orderState = [_tripOrder.orderStatus integerValue];
    if (orderState == 1) {
        if (tag == 0) {
            type = TripCellBtnTypeGetCarVerifyCode;
        }else {
            type = TripCellBtnTypeCancelOrder;
        }
    }
    else if (orderState == 2) {
        if (tag == 0) {
            type = TripCellBtnTypeContinueLiving;
        }else if (tag == 1) {
            type = TripCellBtnTypeAutoCheckout;
        }else if (tag == 2) {
            type = TripCellBtnTypeAppOpenDoor;
        }else if (tag == 3) {
            type = TripCellBtnTypeCommentRoom;
        }
    }
    else if (orderState == 9) {
        if (tag == 0) {
            type = TripCellBtnTypeCommentRoom;
        }else if (tag == 1) {
            type = TripCellBtnTypeDeleteOrder;
        }
    }
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(tripListCellDidClcikBtnType:order:)]) {
        [self.delegate tripListCellDidClcikBtnType:type order:self.tripOrder];
    }
    
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
