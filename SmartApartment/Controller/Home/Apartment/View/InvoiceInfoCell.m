//
//  InvoiceInfoCell.m
//  SmartApartment
//
//  Created by Jimcky Lin on 2017/8/27.
//  Copyright © 2017年 Jimcky Lin. All rights reserved.
//

#import "InvoiceInfoCell.h"
#import "WRCellView.h"


#define CellHeight 57

@interface InvoiceInfoCell ()

@property (nonatomic, strong) WRCellView    *invoiceInfoView;  // 发票信息
@end

@implementation InvoiceInfoCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor clearColor];
        [self initSubView];
        [self onClickEvent];
    }
    return self;
}

- (void)onClickEvent {
    
    __weak typeof(self) weakSelf = self;
    self.invoiceInfoView.tapBlock = ^ {
        __strong typeof(self) pThis = weakSelf;
        pThis.invoiceInfoView.rightIcon.image = kImage(@"coupon_sele_siphone");
    };
}

- (void)initSubView {
    
    [self addSubview:self.invoiceInfoView];
    self.invoiceInfoView.frame = CGRectMake(0, 0, kScreenWidth, CellHeight);
}


- (WRCellView *)invoiceInfoView {
    if (_invoiceInfoView == nil) {
        _invoiceInfoView = [[WRCellView alloc] initWithLineStyle:WRCellStyleLabel_Icon];
        _invoiceInfoView.leftLabel.text = @"发票抬头";
        _invoiceInfoView.rightIcon.image = kImage(@"coupon_seleiphone");
    }
    return _invoiceInfoView;
}


@end
