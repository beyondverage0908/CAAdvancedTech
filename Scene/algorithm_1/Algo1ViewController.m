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
    
    NSArray *arr = @[@1, @5, @5, @7, @1, @4, @3, @2];
    
    NSInteger n = [self findStandard:arr checkLength:2 flag:100];
    NSLog(@"%@", @(n));
    
    NSInteger f = [self findStandard:arr checkNumber:2 flag:100];
    NSLog(@"%@", @(f));
}

// 0 无异常
// 1 异常
// 2 入参不符合
// librarys <=> a[n], length <=> m, flag <=> w
// 时间复杂度O(n * n)
- (NSInteger)findStandard:(NSArray *)librarys checkLength:(NSUInteger)length flag:(NSInteger)flag {
    if (librarys.count < length || !librarys.count) return 2;
    
    NSInteger normal = 0;
    
    for (NSInteger i = 0; i < librarys.count - length + 1; i++) {
        double sum = 0.0;
        for (NSInteger j = 0; j < length; j++) {
            sum += [librarys[i + j] integerValue];
        }
        // 找到第一组不符合 - 结束
        if (sum / length > flag) {
            normal = 1;
            break;
        }
    }
    
    return normal;
}

// 0 无异常
// 1 异常
// 2 入参不符合
// libs <=> a[n], number <=> m, flag <=> w
// 时间复杂度O(n)
- (NSInteger)findStandard:(NSArray *)libs checkNumber:(NSUInteger)number flag:(NSInteger)flag {
    if (libs.count < number || !libs.count) return 2;
    
    NSInteger nor = 0;
    
    double curSum = 0.0;
    for (NSInteger i = 0; i < libs.count; i++) {
        curSum += [libs[i] integerValue];
        if (i > number - 1) {
            curSum -= [libs[i - number] integerValue];
        }
        if (i >= number - 1) {
            // 找到第一组不符合 - 结束
            if (curSum / number > flag) {
                nor = 1;
                break;
            }
        }
    }
    
    return nor;
}



@end
