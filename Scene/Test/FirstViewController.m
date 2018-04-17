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
    [btn addTarget:self action:@selector(firstBtn:) forControlEvents:UIControlEventTouchUpInside];
    btn.backgroundColor = [UIColor cyanColor];
    [self.view addSubview:btn];
    
    UIButton *urlBtn = [[UIButton alloc] initWithFrame:CGRectMake(100, 300, self.view.frame.size.width - 200, 50)];
    [urlBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [urlBtn setTitle:@"调用V健康+" forState:UIControlStateNormal];
    [urlBtn addTarget:self action:@selector(urlSechemeAction:) forControlEvents:UIControlEventTouchUpInside];
    urlBtn.backgroundColor = [UIColor cyanColor];
    [self.view addSubview:urlBtn];
}

- (void)firstBtn:(UIButton *)btn {
    FistSwiftViewController *firstSwiftVC = [[FistSwiftViewController alloc] init];
    firstSwiftVC.title = @"第一个Swift试图";
    [self.navigationController pushViewController:firstSwiftVC animated:YES];
}

- (void)urlSechemeAction:(UIButton *)btn {
    NSString *vplusUrl = @"VPLUSUrlSechemeTestType://";
    
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"plistDemo" ofType:@"plist"];
    NSMutableDictionary *data = [[NSMutableDictionary alloc] initWithContentsOfFile:plistPath];
    [data setObject:@"111" forKey:@"LPJ111"];
    [data setObject:@"222" forKey:@"LPJ222"];
    NSLog(@"%@", data);
    
    //获取应用程序沙盒的Documents目录
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    NSString *plistPath1 = [paths objectAtIndex:0];
    //得到完整的文件名
    NSString *filename = [plistPath1 stringByAppendingPathComponent:@"plistDemo.plist"];
    //输入写入
    [data writeToFile:filename atomically:YES];
    
    NSMutableArray *schemes = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"LSApplicationQueriesSchemes"];
    [schemes addObject:vplusUrl];
    
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:vplusUrl]]) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:vplusUrl]];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
