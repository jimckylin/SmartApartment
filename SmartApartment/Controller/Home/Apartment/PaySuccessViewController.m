//
//  PaySuccessViewController.m
//  SmartApartment
//
//  Created by Jimcky Lin on 2017/9/6.
//  Copyright © 2017年 Jimcky Lin. All rights reserved.
//

#import "PaySuccessViewController.h"
#import "RTLabel.h"
#import <BAButton/BAButton.h>

@interface PaySuccessViewController ()

@end

@implementation PaySuccessViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
}


- (void)initView {
    _naviLabel.text = @"支付成功";
    
    UIView *headerView = [UIView new];
    headerView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:headerView];
    [headerView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(64, 0, 0, 0) excludingEdge:ALEdgeBottom];
    [headerView autoSetDimension:ALDimensionHeight toSize:260];
    
    UIImageView *icon = [[UIImageView alloc] initWithImage:kImage(@"illustration_commentiphone")];
    icon.center = CGPointMake(kScreenWidth/2, 57);
    [headerView addSubview:icon];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, icon.bottom+16, kScreenWidth, 20)];
    label.font = [UIFont systemFontOfSize:14];
    label.textColor = [UIColor darkTextColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.text = @"恭喜您支付成功!";
    [headerView addSubview:label];
    
    RTLabel *descrLabel = [RTLabel new];
    descrLabel.font = [UIFont systemFontOfSize:16];
    descrLabel.textColor = [UIColor darkTextColor];
    descrLabel.textAlignment = RTTextAlignmentCenter;
    descrLabel.text = [NSString stringWithFormat:@"您的入住码是:<font color=#EA2035>%@</font>\n 您到达公寓后，请在自助机的互联网取卡界面，输入入住码自助入住。", self.checkinNo];
    [headerView addSubview:descrLabel];
    
    [descrLabel autoAlignAxisToSuperviewAxis:ALAxisVertical];
    [descrLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:label withOffset:30];
    [descrLabel autoSetDimensionsToSize:CGSizeMake(kScreenWidth-40, 80)];
    
    /*
    UIButton *selectRoomBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    selectRoomBtn.backgroundColor = ThemeColor;
    [selectRoomBtn addTarget:self action:@selector(selectRoomBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [selectRoomBtn setTitle:@"自助选房" forState:UIControlStateNormal];
    [selectRoomBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [selectRoomBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
    [selectRoomBtn.titleLabel setFont:[UIFont systemFontOfSize:15]];
    selectRoomBtn.layer.cornerRadius = 3;
    [headerView addSubview:selectRoomBtn];
    
    [selectRoomBtn autoAlignAxisToSuperviewAxis:ALAxisVertical];
    [selectRoomBtn autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:label withOffset:30];
    [selectRoomBtn autoSetDimensionsToSize:CGSizeMake(kScreenWidth-40, 40)];*/
    
    UIView *footerView = [UIView new];
    footerView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:footerView];
    [footerView autoPinEdgeToSuperviewEdge:ALEdgeLeft];
    [footerView autoPinEdgeToSuperviewEdge:ALEdgeRight];
    [footerView autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:headerView withOffset:10];
    [footerView autoSetDimension:ALDimensionHeight toSize:175];
    
    UIImageView *tipIcon = [[UIImageView alloc] initWithImage:kImage(@"oeder_reminder_iciphone")];
    tipIcon.frame = CGRectMake(3, 10, 18, 18);
    [footerView addSubview:tipIcon];
    
    UILabel *descLabel = [[UILabel alloc] initWithFrame:CGRectMake(tipIcon.right+3, tipIcon.top, kScreenWidth-tipIcon.width+20, 40)];
    descLabel.font = [UIFont systemFontOfSize:11];
    descLabel.textColor = [UIColor lightGrayColor];
    descLabel.numberOfLines = 2;
    descLabel.text = @"请于中午12:00后办理入住，如提前到店，视公寓空房情况安排";
    [footerView addSubview:descLabel];
    [descLabel sizeToFit];
    
    UILabel *tipLabel = [[UILabel alloc] initWithFrame:CGRectMake(descLabel.left, descLabel.bottom+20, 150, 20)];
    tipLabel.font = [UIFont systemFontOfSize:11];
    tipLabel.textColor = [UIColor lightGrayColor];
    tipLabel.numberOfLines = 2;
    tipLabel.text = @"本次入住享受一下权益";
    [footerView addSubview:tipLabel];
    
    
    UIButton *roomKeepTime = [UIButton buttonWithType:UIButtonTypeCustom];
    [roomKeepTime setImage:kImage(@"check_room_iciphone") forState:UIControlStateNormal];
    [roomKeepTime setTitle:@"房间保留 19:00" forState:UIControlStateNormal];
    [roomKeepTime setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [roomKeepTime setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
    [roomKeepTime.titleLabel setFont:[UIFont systemFontOfSize:12]];
    [roomKeepTime ba_button_setButtonLayoutType:BAKit_ButtonLayoutTypeCenterImageTop padding:20];
    [footerView addSubview:roomKeepTime];
    
    [roomKeepTime autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:tipLabel withOffset:15];
    [roomKeepTime autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:35];
    [roomKeepTime autoSetDimensionsToSize:CGSizeMake(100, 65)];
    
    
    
    UIButton *delayCheckoutTime = [UIButton buttonWithType:UIButtonTypeCustom];
    [delayCheckoutTime setImage:kImage(@"check_delete_iciphone") forState:UIControlStateNormal];
    [delayCheckoutTime setTitle:@"延迟退房 14:00" forState:UIControlStateNormal];
    [delayCheckoutTime setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [delayCheckoutTime setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
    [delayCheckoutTime.titleLabel setFont:[UIFont systemFontOfSize:12]];
    [delayCheckoutTime ba_button_setButtonLayoutType:BAKit_ButtonLayoutTypeCenterImageTop padding:20];
    [footerView addSubview:delayCheckoutTime];
    
    [delayCheckoutTime autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:tipLabel withOffset:15];
    [delayCheckoutTime autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:35];
    [delayCheckoutTime autoSetDimensionsToSize:CGSizeMake(100, 65)];
}


#pragma mark - UIButton Action

- (void)selectRoomBtnClick:(id)sender {
    
    
}

- (void)backClick:(id)sender {
    
    [[NavManager shareInstance] returnToMainView:YES];
}


@end
