//
//  TestOfBundleController.m
//  CAAdvancedTech
//
//  Created by pingjun lin on 2016/12/29.
//  Copyright © 2016年 pingjun lin. All rights reserved.
//

#import "TestOfBundleController.h"

@interface TestOfBundleController ()

@property (weak, nonatomic) IBOutlet UIImageView *fImageView;
@property (weak, nonatomic) IBOutlet UIImageView *sImageView;

@end

@implementation TestOfBundleController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *bundlePath = [[NSBundle mainBundle] pathForResource:@"image" ofType:@"bundle"];
    NSBundle *myImageBundle = [NSBundle bundleWithPath:bundlePath];
//    NSString *path = [bundlePath stringByAppendingPathComponent:@"btn_confirm_big.png"];
    
    UIImage *image = [UIImage imageWithContentsOfFile:[myImageBundle pathForResource:@"btn_confirm_big" ofType:@"png"]];
    _fImageView.image = image;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
