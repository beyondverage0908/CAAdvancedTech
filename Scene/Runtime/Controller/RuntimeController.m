//
//  RuntimeController.m
//  CAAdvancedTech
//
//  Created by pingjun lin on 2017/10/30.
//  Copyright © 2017年 pingjun lin. All rights reserved.
//

#import "RuntimeController.h"
#import <objc/runtime.h>
#import <objc/message.h>
#import "RuntimeModel.h"
#import "ColorModel.h"

@interface RuntimeController ()

@property (strong, nonatomic) UIView *colorView;
@property (strong, nonatomic) ColorModel *color;
@property (strong, nonatomic) NSTimer *timer;

@end

@implementation RuntimeController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Runtime示例";
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self printRuntimeProperty];
    
    self.colorView = [[UIView alloc] initWithFrame:CGRectMake(10, 200, self.view.frame.size.width - 20, 30)];
    self.colorView.backgroundColor = [UIColor redColor];
    [self.view addSubview:self.colorView];
    
    self.color = [[ColorModel alloc] init];
    
    [self.color addObserver:self forKeyPath:@"color" options:NSKeyValueObservingOptionOld|NSKeyValueObservingOptionNew context:nil];
    
    NSArray *colorList = @[@"red", @"yellow"];
    self.timer = [NSTimer scheduledTimerWithTimeInterval:2.0 repeats:YES block:^(NSTimer * _Nonnull timer) {
        NSInteger randNum = arc4random() % 2;
        self.color.color = colorList[randNum];
    }];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.timer fire];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.timer invalidate];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)printRuntimeProperty {
    unsigned int count = 0;
    Ivar *vars = class_copyIvarList([RuntimeModel class], &count);
    
    for (NSInteger i = 0; i < count; i++) {
        Ivar var = vars[i];
        const char *name = ivar_getName(var);
        NSString *key = [NSString stringWithUTF8String:name];
        NSLog(@"-->>> %@", key);
    }
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    
    if ([@"red" isEqualToString:change[@"new"]]) {
        self.colorView.backgroundColor = [UIColor redColor];
    } else if ([@"yellow" isEqualToString:change[@"new"]]) {
        self.colorView.backgroundColor = [UIColor yellowColor];
    } else {
        self.colorView.backgroundColor = [UIColor greenColor];
    }
    NSLog(@"--->> %@", keyPath);
    
}

@end
