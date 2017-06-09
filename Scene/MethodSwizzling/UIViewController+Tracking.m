//
//  UIViewController+Tracking.m
//  CAAdvancedTech
//
//  Created by pingjun lin on 2017/2/10.
//  Copyright © 2017年 pingjun lin. All rights reserved.
//

#import "UIViewController+Tracking.h"
#import <objc/runtime.h>

@implementation UIViewController (Tracking)

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
        Class class = [self class];
        
        SEL originalSelector = @selector(viewWillAppear:);
        SEL swizzledSelector = @selector(xxx_viewWillAppear:);
        
        Method originalMethod = class_getInstanceMethod(class, originalSelector);
        Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
        
        // When swizzling a class method, use the following:
        // Class class = object_getClass((id)self);
        // ...
        // Method originalMethod = class_getClassMethod(class, originalSelector);
        // Method swizzledMethod = class_getClassMethod(class, swizzledSelector);
        
        // 通过给定的方法名字和方法实现，将方法添加到指定的类中
        // note: 这个方法会去重写父类实现，但是并不会替换该类已经实现的同名方法，如需要替换，使用method_setImplementation
        BOOL didAddMethod =
        class_addMethod(class,
                        originalSelector,
                        method_getImplementation(swizzledMethod),
                        method_getTypeEncoding(swizzledMethod));
        
        if (didAddMethod) {
            // 替换指定类的方法的实现
            // 具体的实现两种方式:
            // 1. 如果类中没有给定的方法标示，就添加方法到类中，类似于调用class_addMethod方法，类型编码由给定的类型编码使用
            // 2. 如果类中已经存在给定的方法标示，就替换方法的实现，类似于调用method_setImplementation方法，给定的类型编码将被忽略
            class_replaceMethod(class,
                                swizzledSelector,
                                method_getImplementation(originalMethod),
                                method_getTypeEncoding(originalMethod));
        } else {
            // 交换两个方法的实现
            /** 
             *  具体的实现
             *
             *  IMP imp1 = method_getImplementation(m1);
             *  IMP imp2 = method_getImplementation(m2);
             *  method_setImplementation(m1, imp2);
             *  method_setImplementation(m2, imp1);
             */
            method_exchangeImplementations(originalMethod, swizzledMethod);
        }
        
        // 交换dismiss方法
//        [self swizzleSEL:@selector(dismissViewControllerAnimated:completion:) withSEL:@selector(swizzled_dismissViewControllerAnimated:completion:)];
    });
}

- (void)swizzled_dismissViewControllerAnimated:(BOOL)flag completion:(void (^)(void))completion {
    [self swizzled_dismissViewControllerAnimated:flag completion:completion];
    
    UIViewController *dismissedViewController = self.presentedViewController;
    if (!dismissedViewController && self.presentingViewController) {
        dismissedViewController = self;
    }
    
    if (!dismissedViewController) return;
}

#pragma mark - Method Swizzling

- (void)xxx_viewWillAppear:(BOOL)animated {
    [self xxx_viewWillAppear:animated];
}

@end
