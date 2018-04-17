//
//  Algo1ViewController.m
//  CAAdvancedTech
//
//  Created by pingjun lin on 2018/4/17.
//  Copyright © 2018年 pingjun lin. All rights reserved.
//

#import "Algo1ViewController.h"

@interface Algo1ViewController ()

@end

@implementation Algo1ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    NSArray *arr = @[@1, @5, @1, @3, @2, @4];
    
    NSInteger n = [self findStandard:arr checkLength:4 flag:3.1];
    NSLog(@"%@", @(n));
}

// 0 无异常
// 1 异常
// 2 入参不符合
// librarys <=> a[n], length <=> m, flag <=> w
- (NSInteger)findStandard:(NSArray *)librarys checkLength:(NSUInteger)length flag:(NSInteger)flag {
    if (librarys.count < length || !librarys.count) return 2;
    
    NSInteger normal = 0;
    
    for (NSInteger i = 0; i < librarys.count - length + 1; i++) {
        double sum = 0.0;
        for (NSInteger j = i; j < length; j++) {
            sum += [librarys[j] integerValue];
        }
        // 找到第一个不符合，就不需要再找了
        if (sum / length > flag) {
            normal = 1;
            break;
        }
    }
    
    return normal;
}

@end
