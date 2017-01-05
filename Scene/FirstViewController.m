//
//  FirstViewController.m
//  CAAdvancedTech
//
//  Created by pingjun lin on 16/7/23.
//  Copyright © 2016年 pingjun lin. All rights reserved.
//

#import "FirstViewController.h"

@interface FirstViewController ()

@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(100, 200, self.view.frame.size.width - 200, 50)];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn setTitle:@"First Controller" forState:UIControlStateNormal];
    btn.backgroundColor = [UIColor cyanColor];
    [self.view addSubview:btn];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
