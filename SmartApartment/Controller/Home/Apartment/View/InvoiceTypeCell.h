//
//  InvoiceTypeCell.h
//  SmartApartment
//
//  Created by Jimcky Lin on 2017/8/26.
//  Copyright © 2017年 Jimcky Lin. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, InvoiceType) {
    
    InvoiceTypePersonal,
    InvoiceTypeSpecial,
    InvoiceTypeCompany,
};


@interface InvoiceTypeCell : UITableViewCell

@property (nonatomic, copy) void(^InvoiceCellBlock)(InvoiceType type);

@end
