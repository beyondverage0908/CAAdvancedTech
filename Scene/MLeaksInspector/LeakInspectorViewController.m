//
//  LeakInspectorViewController.m
//  CAAdvancedTech
//
//  Created by pingjun lin on 2017/2/9.
//  Copyright © 2017年 pingjun lin. All rights reserved.
//

#import "LeakInspectorViewController.h"

#import "InspectorContainerView.h"
#import "LeakFirstView.h"
#import "LeakSecondView.h"
#import "LeakThirdView.h"
#import "LeakFourView.h"

@interface LeakInspectorViewController ()

@end

@implementation LeakInspectorViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    InspectorContainerView *containerView = [[InspectorContainerView alloc] initWithFrame:CGRectMake(15, 100, self.view.frame.size.width - 30, 150)];
    containerView.backgroundColor = [UIColor purpleColor];
    [self.view addSubview:containerView];
    
    LeakFirstView *firstView = [[LeakFirstView alloc] initWithFrame:CGRectMake(10, 10, containerView.frame.size.width - 20, 30)];
    firstView.backgroundColor = [UIColor redColor];
    [containerView addSubview:firstView];
    
    LeakSecondView *secondView = [[LeakSecondView alloc] initWithFrame:CGRectMake(10, 50, containerView.frame.size.width - 20, 30)];
    secondView.backgroundColor = [UIColor greenColor];
    [containerView addSubview:secondView];
    
    LeakThirdView *thirdView = [[LeakThirdView alloc] initWithFrame:CGRectMake(10, 5, secondView.frame.size.width - 20, 20)];
    thirdView.backgroundColor = [UIColor lightGrayColor];
    [secondView addSubview:thirdView];
    
    LeakFourView *fourView = [[LeakFourView alloc] initWithFrame:CGRectMake(10, 90, containerView.frame.size.width - 20, 30)];
    fourView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [containerView addSubview:fourView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)dealloc {
    NSLog(@"%@ be dealloc", NSStringFromClass([self class]));
}

@end
