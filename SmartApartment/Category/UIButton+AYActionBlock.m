//
//  UIButton+actionBlock.m
//  
//
//  Created by Alpha Yu on 10/10/15.
//
//

#import "UIButton+AYActionBlock.h"
#import <objc/runtime.h>


@implementation UIButton (AYActionBlock)

- (void)ay_setActionBlock:(void (^)(void))actionBlock {
    [self addTarget:self action:@selector(buttonAction) forControlEvents:UIControlEventTouchUpInside];
    objc_setAssociatedObject(self, @selector(buttonAction), actionBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
    
}

- (void)buttonAction {
    void (^actionBlock)(void) = objc_getAssociatedObject(self, _cmd);
    if (actionBlock) {
        actionBlock();
    }
}

- (void (^)(void))ay_actionBlock {
    void (^actionBlock)(void) = objc_getAssociatedObject(self, @selector(buttonAction));
    if (actionBlock) {
        return actionBlock;
    } else {
        return nil;
    }
}

@end
