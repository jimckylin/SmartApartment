//
//  JKProgressView.m
//  SmartApartment
//
//  Created by jimcky on 2017/8/18.
//  Copyright © 2017年 Jimcky Lin. All rights reserved.
//

#import "JKProgressView.h"
#import <ChameleonFramework/Chameleon.h>

@interface JKProgressView ()
@end

@implementation JKProgressView

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        self.layer.cornerRadius = frame.size.height/2;
    }
    return self;
}


- (void)setProgress:(CGFloat)progress {
    
    self.width = progress * self.width;
    self.backgroundColor = [UIColor colorWithGradientStyle:UIGradientStyleLeftToRight withFrame:CGRectMake(0, 0, self.width, self.height) andColors:@[[UIColor redColor],[UIColor yellowColor]]];
}

@end
