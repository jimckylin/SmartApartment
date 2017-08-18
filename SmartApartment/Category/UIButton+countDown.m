//
//  UIButton+countDown.m
//  CarFriend
//
//  Created by mac on 16/4/2.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "UIButton+countDown.h"
#import <objc/runtime.h>
#import "PureLayout.h"

@implementation UIButton (countDown)

#pragma mark - property

- (void)setTimeoutText:(NSString *)timeoutText
{
    objc_setAssociatedObject(self, @selector(timeoutText), timeoutText, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (NSString *)timeoutText
{
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setDisableBackGroundColor:(UIColor *)disableBackGroundColor
{
    objc_setAssociatedObject(self, @selector(disableBackGroundColor), disableBackGroundColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIColor *)disableBackGroundColor
{
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setTimeoutBlock:(TimeOutBlock)timeoutBlock
{
    objc_setAssociatedObject(self, @selector(timeoutBlock), timeoutBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (TimeOutBlock)timeoutBlock
{
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setNormalBackGroundColor:(UIColor *)normalBackGroundColor
{
    objc_setAssociatedObject(self, @selector(normalBackGroundColor), normalBackGroundColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIColor *)normalBackGroundColor
{
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setCountLabel:(UILabel *)countLabel
{
    objc_setAssociatedObject(self, @selector(countLabel), countLabel, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UILabel *)countLabel
{
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setTimer:(NSTimer *)timer
{
    objc_setAssociatedObject(self, @selector(timer), timer, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSTimer *)timer
{
    return objc_getAssociatedObject(self, _cmd);
}

#pragma mark - public

- (void)startCountDown:(NSInteger)count
{
    self.enabled = NO;
    self.titleLabel.layer.opacity = 0;
    
    if (self.disableBackGroundColor) {
        self.normalBackGroundColor = self.backgroundColor;
        self.backgroundColor = self.disableBackGroundColor;
    }
    
    if (!self.countLabel) {
        self.countLabel = [[UILabel alloc] init];
        [self addSubview:self.countLabel];
        [self.countLabel autoPinEdgesToSuperviewEdges];
        self.countLabel.textColor = [UIColor colorWithHexString:@"#333333"];
        self.countLabel.textAlignment = NSTextAlignmentCenter;
    }
    
    self.countLabel.text = [NSString stringWithFormat:@"%zd秒",count];
    self.countLabel.font = [UIFont systemFontOfSize:13];
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(ticket) userInfo:nil repeats:YES];
}

- (void)startCountDown:(NSInteger)count timeOut:(TimeOutBlock)timeout;
{
    self.timeoutBlock = timeout;
    [self startCountDown:count];
}

#pragma mark - private

- (void)ticket
{
    NSInteger count = [self.countLabel.text integerValue];
    count--;
    self.countLabel.text = [NSString stringWithFormat:@"%zd秒",count];
    if (count == 0) {
        self.countLabel.text = @"";
        [self.timer invalidate];
        self.enabled = YES;
        self.titleLabel.layer.opacity = 1;
        self.backgroundColor = self.normalBackGroundColor;
        
        if (self.timeoutText) {
            [self setTitle:self.timeoutText forState:UIControlStateNormal];
        }
        
        if (self.timeoutBlock) {
            self.timeoutBlock();
        }
    }
}

@end
