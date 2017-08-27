//
//  NewAddInvoiceCell.m
//  SmartApartment
//
//  Created by Jimcky Lin on 2017/8/27.
//  Copyright © 2017年 Jimcky Lin. All rights reserved.
//

#import "NewAddInvoiceCell.h"
#import "WRCellView.h"


#define CellHeight 57

@interface NewAddInvoiceCell ()

@property (nonatomic, strong) WRCellView    *invoiceInfoView;  // 发票信息
@property (nonatomic, strong) UITextField   *textField;
@end

@implementation NewAddInvoiceCell

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

- (void)setTitleAndPlaceholder:(NSDictionary *)dict {
    
    self.invoiceInfoView.leftLabel.text = dict[@"title"];
    self.textField.placeholder = dict[@"placeholder"];
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
    
    [self.invoiceInfoView addSubview:self.textField];
    
}


- (WRCellView *)invoiceInfoView {
    if (_invoiceInfoView == nil) {
        _invoiceInfoView = [[WRCellView alloc] initWithLineStyle:WRCellStyleLabel_];
        _invoiceInfoView.leftLabel.textColor = ThemeColor;
        _invoiceInfoView.leftLabel.text = @"发票抬头";
        _invoiceInfoView.rightIcon.image = kImage(@"coupon_seleiphone");
    }
    return _invoiceInfoView;
}

- (UITextField *)textField {
    if (_textField == nil) {
        _textField = [[UITextField alloc] initWithFrame:CGRectMake(110, 0, kScreenWidth - 120, CellHeight)];
        _textField.font = [UIFont systemFontOfSize:14];
        _textField.textColor = [UIColor darkTextColor];
        _textField.placeholder = @"公司名称";
    }
    return _textField;
}


@end
