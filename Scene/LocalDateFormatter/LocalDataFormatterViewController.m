//
//  LocalDataFormatterViewController.m
//  CAAdvancedTech
//
//  Created by pingjun lin on 2018/3/16.
//  Copyright © 2018年 pingjun lin. All rights reserved.
//

#import "LocalDataFormatterViewController.h"
#import "BTNSDateFormatterFactory.h"

@interface LocalDataFormatterViewController ()

@property (nonatomic, strong) UILabel *showLabel;

@end

@implementation LocalDataFormatterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(50, 100, self.view.bounds.size.width - 100, 50)];
    [btn setTitle:@"Get Current Time" forState:UIControlStateNormal];
    btn.backgroundColor = [UIColor cyanColor];
    [btn addTarget:self action:@selector(getCurrentTimeAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    self.showLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, btn.frame.origin.y + 100, self.view.bounds.size.width - 100, 50)];
    self.showLabel.text = @"temp time";
    self.showLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:self.showLabel];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark -
#pragma mark - Actions

- (void)getCurrentTimeAction:(UIButton *)btn {
    NSDateFormatter *formatter = [[BTNSDateFormatterFactory sharedFactory] dateFormatterWithFormat:@"yyyy-MM-dd HH:mm:ss" andLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"first-local-identifier"]];
    NSString *currentDateStr = [formatter stringFromDate:[NSDate date]];
    self.showLabel.text = currentDateStr;
}

@end
