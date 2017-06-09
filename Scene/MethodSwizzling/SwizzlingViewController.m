//
//  SwizzlingViewController.m
//  CAAdvancedTech
//
//  Created by pingjun lin on 2017/2/10.
//  Copyright © 2017年 pingjun lin. All rights reserved.
//

#import "SwizzlingViewController.h"
#import "SwizzlingSonViewController.h"
#import "SwizzlingView.h"
#import <objc/runtime.h>

@interface SwizzlingViewController ()<UITextFieldDelegate>

@end

extern const NSInteger swizzlingLoadNumbers;

extern NSString *externString;

@implementation SwizzlingViewController

+ (void)swizzleSEL:(SEL)originalSEL withSEL:(SEL)swizzledSEL {
    Class class = [self class];
    
    Method originalMethod = class_getInstanceMethod(class, originalSEL);
    Method swizzledMethod = class_getInstanceMethod(class, swizzledSEL);
    
    BOOL didAddMethod =
    class_addMethod(class,
                    originalSEL,
                    method_getImplementation(swizzledMethod),
                    method_getTypeEncoding(swizzledMethod));
    
    if (didAddMethod) {
        class_replaceMethod(class,
                            swizzledSEL,
                            method_getImplementation(originalMethod),
                            method_getTypeEncoding(originalMethod));
    } else {
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self swizzleSEL:@selector(swizzlingBtnClickTest) withSEL:@selector(yyy_swizzlingBtnClickTest)];
        [self swizzleSEL:@selector(textFieldDidEndEditing:) withSEL:@selector(yyy_textFieldDidEndEditing:)];
    });
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(10, 100, self.view.frame.size.width - 20, 50)];
    [btn setTitle:@"下一个" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn setBackgroundColor:[UIColor greenColor]];
    [btn addTarget:self action:@selector(nextVCWithBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    SwizzlingView *swizzlingView = [[SwizzlingView alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(btn.frame) + 20, self.view.frame.size.width - 20, 100)];
    swizzlingView.backgroundColor = [UIColor cyanColor];
    [self.view addSubview:swizzlingView];
    
    UIButton *swizzlingBtn = [[UIButton alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(swizzlingView.frame) + 20, self.view.frame.size.width - 20, 50)];
    swizzlingBtn.backgroundColor = [UIColor cyanColor];
    [swizzlingBtn setTitle:@"swizzling 按钮事件测试" forState:UIControlStateNormal];
    [swizzlingBtn addTarget:self action:@selector(swizzlingBtnClickTest) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:swizzlingBtn];
    
    UITextField *accountTextField = [[UITextField alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(swizzlingBtn.frame) + 20, self.view.frame.size.width - 20, 50)];
    accountTextField.placeholder = @"账号填写";
    accountTextField.borderStyle = UITextBorderStyleRoundedRect;
    accountTextField.delegate = self;
    [self.view addSubview:accountTextField];
}

- (void)nextVCWithBtn:(UIButton *)btn {
    SwizzlingSonViewController *sonVC = [[SwizzlingSonViewController alloc] init];
    [self presentViewController:sonVC animated:YES completion:nil];
}

- (void)swizzlingBtnClickTest {
    NSLog(@"--->>>swizzlingBtnClickTest");
}

- (void)yyy_swizzlingBtnClickTest {
    NSLog(@"--->>>yyy_swizzlingBtnClickTest");
    [self yyy_swizzlingBtnClickTest];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITextFieldDelegate - swizzling

- (void)textFieldDidEndEditing:(UITextField *)textField {
    NSLog(@"--->>>textFieldDidEndEditing");
}

- (void)yyy_textFieldDidEndEditing:(UITextField *)textField {
    NSLog(@"--->>>yyy_textFieldDidEndEditing");
    [self yyy_textFieldDidEndEditing:textField];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    return [textField endEditing:YES];
}

@end
