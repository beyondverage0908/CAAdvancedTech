//
//  SwizzlingViewController.m
//  CAAdvancedTech
//
//  Created by pingjun lin on 2017/2/10.
//  Copyright © 2017年 pingjun lin. All rights reserved.
//

#import "SwizzlingViewController.h"
#import "SwizzlingSonViewController.h"

@interface SwizzlingViewController ()

@end

extern const NSInteger swizzlingLoadNumbers;

extern NSString *externString;

@implementation SwizzlingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(10, 100, self.view.frame.size.width - 20, 50)];
    [btn setTitle:@"下一个" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn setBackgroundColor:[UIColor greenColor]];
    [btn addTarget:self action:@selector(nextVCWithBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    static NSInteger fstatic = 123;
    NSLog(@"fstatic addredd %p", &fstatic);
}

- (void)nextVCWithBtn:(UIButton *)btn {
    SwizzlingSonViewController *sonVC = [[SwizzlingSonViewController alloc] init];
    [self presentViewController:sonVC animated:YES completion:nil];
    
    NSLog(@"%@ presentViewController is %@", NSStringFromClass([self class]), NSStringFromClass([self.presentedViewController class]));
    
//    [self.navigationController pushViewController:sonVC animated:YES];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        NSLog(@"%@", externString);
    });
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
//    ++swizzlingLoadNumbers;
//    NSLog(@"swizzlingLoadNumbers = %@", @(swizzlingLoadNumbers));
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
