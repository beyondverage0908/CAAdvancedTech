//
//  ThreeDTransformController.m
//  CAAdvancedTech
//
//  Created by pingjun lin on 16/7/23.
//  Copyright © 2016年 pingjun lin. All rights reserved.
//

#import "ThreeDTransformController.h"

@interface ThreeDTransformController ()

@property (weak, nonatomic) IBOutlet UIImageView *monkeyImageView;

@property (weak, nonatomic) IBOutlet UIView *containView;
@property (weak, nonatomic) IBOutlet UIImageView *firstLayerView;
@property (weak, nonatomic) IBOutlet UIImageView *secondLayerView;

@property (weak, nonatomic) IBOutlet UILabel *transformLabel;

@end

@implementation ThreeDTransformController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 在Y轴方向上旋转45度
//    CATransform3D transform = CATransform3DMakeRotation(M_PI_4, 0, 1, 0);
//    transform.m34 = -1.0 / 500.0;
//    self.monkeyImageView.layer.transform = transform;
    
#pragma mark - sublayerTransform
    // 使用sublayerTransform统一对容器内的子图层或者视图设置灭点
    CATransform3D miedian = CATransform3DIdentity;
    miedian.m34 = - 1.0 / 500.0;
    self.containView.layer.sublayerTransform = miedian;
    
    // 对容器视图中的子视图进行灭点的设置
    // 对视图一进行旋转变换
    CATransform3D transform1 = CATransform3DMakeRotation(M_PI_4, 0, 1, 0);
    self.firstLayerView.layer.transform = transform1;
    
    // 对视图二进行Y轴-45度的旋转
    CATransform3D transform2 = CATransform3DMakeRotation(- M_PI_4, 0, 1, 0);
    self.secondLayerView.layer.transform = transform2;
    
    // 对label文字进行纵向排列 - 对图层方向的z轴进行旋转90度
    CATransform3D transform_label = CATransform3DMakeRotation(M_PI_2, 0, 0, 1);
    self.transformLabel.layer.transform = transform_label;
    self.transformLabel.layer.doubleSided = NO; // 设置是否进行双面绘画渲染，当进行x，y轴上旋转180度的时候，背面视图将不再显示
    
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
#pragma mark - 灭点设置，旋转
    [UIView animateWithDuration:1.0 animations:^{
        CATransform3D transform = CATransform3DIdentity;
        transform.m34 = -1.0 / 500.0;
        transform = CATransform3DRotate(transform, M_PI_4, 0, 1, 0);
        self.monkeyImageView.layer.transform = transform;
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
