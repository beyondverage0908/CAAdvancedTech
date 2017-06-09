//
//  UIView+Tracking.m
//  CAAdvancedTech
//
//  Created by pingjun lin on 2017/3/23.
//  Copyright © 2017年 pingjun lin. All rights reserved.
//

#import "UIView+Tracking.h"
#import <objc/runtime.h>

@implementation UIView (Tracking)

+ (void)swizzleSEL:(SEL)originalSEL withSEL:(SEL)swizzledSEL {
    Class class = [self class];
    
    Method originalMethod = class_getInstanceMethod(class, originalSEL);
    Method swizzledMethod = class_getInstanceMethod(class, swizzledSEL);
    
    BOOL didAddMethod =
    class_addMethod(class,
                    originalSEL,
                    method_getImplementation(swizzledMethod),
                    method_getTypeEncoding(swizzledMethod));
    
    if (didAddMethod) {
        class_replaceMethod(class,
                            swizzledSEL,
                            method_getImplementation(originalMethod),
                            method_getTypeEncoding(originalMethod));
    } else {
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self swizzleSEL:@selector(initWithFrame:) withSEL:@selector(swizzled_initWithFrame:)];
    });
}

- (instancetype)swizzled_initWithFrame:(CGRect)frame {
    return [self swizzled_initWithFrame:frame];
}

@end
