//
//  SwizzlingSonViewController.m
//  CAAdvancedTech
//
//  Created by pingjun lin on 2017/2/10.
//  Copyright © 2017年 pingjun lin. All rights reserved.
//

#import "SwizzlingSonViewController.h"

static NSInteger swizzlingSonLoadNumbers = 0;

@interface SwizzlingSonViewController ()

@end

@implementation SwizzlingSonViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(10, 100, self.view.frame.size.width - 20, 50)];
    [btn setTitle:@"返回了" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn setBackgroundColor:[UIColor yellowColor]];
    [btn addTarget:self action:@selector(backVCWithBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    static NSInteger fstatic;
    NSLog(@"fstatic addredd %p", &fstatic);
    
    NSString *externString = @"Hello";
}

- (void)backVCWithBtn:(UIButton *)backBtn {
//    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
//    ++swizzlingSonLoadNumbers;
//    NSLog(@"swizzlingSonLoadNumbers = %@", @(swizzlingSonLoadNumbers));
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
