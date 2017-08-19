//
//  TripHelperNoOrderView.m
//  SmartApartment
//
//  Created by Jimcky Lin on 2017/8/20.
//  Copyright © 2017年 Jimcky Lin. All rights reserved.
//

#import "TripHelperNoOrderView.h"

@interface TripHelperNoOrderView ()

@property (nonatomic, strong) IBOutlet UIButton *bookHotelBtn;

@end

@implementation TripHelperNoOrderView

- (void)awakeFromNib {
    
    [self.bookHotelBtn addTarget:self action:@selector(bookHotelBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [super awakeFromNib];
}

- (void)bookHotelBtnClick:(id)sender {
    
    if (self.tripHelperNoOrderViewBlock) {
        self.tripHelperNoOrderViewBlock();
    }
}
@end
