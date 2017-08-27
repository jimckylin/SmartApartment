//
//  InvoiceTypeCell.m
//  SmartApartment
//
//  Created by Jimcky Lin on 2017/8/26.
//  Copyright © 2017年 Jimcky Lin. All rights reserved.
//

#import "InvoiceTypeCell.h"
#import "WRCellView.h"


#define CellViewHeight 57

@interface InvoiceTypeCell ()

@property (nonatomic, strong) WRCellView    *personalView;  // 普通个人
@property (nonatomic, strong) WRCellView    *specialView;   // 专用
@property (nonatomic, strong) WRCellView    *companyView;   // 普通公司

@end

@implementation InvoiceTypeCell

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
    self.personalView.tapBlock = ^ {
        __strong typeof(self) pThis = weakSelf;
        pThis.personalView.rightIcon.image = kImage(@"coupon_sele_siphone");
        pThis.specialView.rightIcon.image = nil;
        pThis.companyView.rightIcon.image = nil;
        
        if (pThis.InvoiceCellBlock) {
            pThis.InvoiceCellBlock(InvoiceTypePersonal);
        }
    };
    self.specialView.tapBlock = ^{
        __strong typeof(self) pThis = weakSelf;
        pThis.personalView.rightIcon.image = nil;
        pThis.specialView.rightIcon.image = kImage(@"coupon_sele_siphone");
        pThis.companyView.rightIcon.image = nil;
        
        if (pThis.InvoiceCellBlock) {
            pThis.InvoiceCellBlock(InvoiceTypeSpecial);
        }
    };
    self.companyView.tapBlock = ^{
        __strong typeof(self) pThis = weakSelf;
        pThis.personalView.rightIcon.image = nil;
        pThis.specialView.rightIcon.image = nil;
        pThis.companyView.rightIcon.image = kImage(@"coupon_sele_siphone");
        
        if (pThis.InvoiceCellBlock) {
            pThis.InvoiceCellBlock(InvoiceTypeCompany);
        }
    };
}

- (void)initSubView {
    
    [self addSubview:self.personalView];
    [self addSubview:self.specialView];
    [self addSubview:self.companyView];
    
    self.personalView.frame = CGRectMake(0, 0, kScreenWidth, CellViewHeight);
    self.specialView.frame = CGRectMake(0, _personalView.bottom, kScreenWidth, CellViewHeight);
    self.companyView.frame = CGRectMake(0, _specialView.bottom, kScreenWidth, CellViewHeight);
}


- (WRCellView *)personalView {
    if (_personalView == nil) {
        _personalView = [[WRCellView alloc] initWithLineStyle:WRCellStyleLabel_Icon];
        _personalView.leftLabel.text = @"增值税普通发票(个人)";
        _personalView.rightIcon.image = kImage(@"coupon_sele_siphone");
    }
    return _personalView;
}

- (WRCellView *)specialView {
    if (_specialView == nil) {
        _specialView = [[WRCellView alloc] initWithLineStyle:WRCellStyleLabel_Icon];
        _specialView.leftLabel.text = @"增值税专用发票";
        [_specialView setLineStyleWithLeftZero];
    }
    return _specialView;
}

- (WRCellView *)companyView {
    if (_companyView == nil) {
        _companyView = [[WRCellView alloc] initWithLineStyle:WRCellStyleLabel_Icon];
        _companyView.leftLabel.text = @"增值税普通发票（公司）";
    }
    return _companyView;
}


@end
