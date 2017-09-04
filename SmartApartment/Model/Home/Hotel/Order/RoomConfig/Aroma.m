//
//  Aroma.m
//  SmartApartment
//
//  Created by jimcky on 2017/9/4.
//  Copyright © 2017年 Jimcky Lin. All rights reserved.
//

#import "Aroma.h"
#import <YYModel/NSObject+YYModel.h>

@interface Aroma ()<YYModel>

@end

@implementation Aroma

/*!
 *  1.该方法是 `字典里的属性Key` 和 `要转化为模型里的属性名` 不一样 而重写的
 *  前：模型的属性   后：字典里的属性
 */

+ (nullable NSDictionary<NSString *, id> *)modelCustomPropertyMapper{
    
    return @{@"aromaId":@"id"};
}

@end
