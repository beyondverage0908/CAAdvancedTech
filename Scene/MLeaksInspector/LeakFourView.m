//
//  LeakFourView.m
//  CAAdvancedTech
//
//  Created by pingjun lin on 2017/2/9.
//  Copyright © 2017年 pingjun lin. All rights reserved.
//

#import "LeakFourView.h"

@implementation LeakFourView

- (void)dealloc {
    NSLog(@"%@ be dealloc", NSStringFromClass([self class]));
}

@end