//
//  CAShapeLayerController.m
//  CAAdvancedTech
//
//  Created by pingjun lin on 16/7/25.
//  Copyright © 2016年 pingjun lin. All rights reserved.
//

#import "CAShapeLayerController.h"

@interface CAShapeLayerController ()

@property (weak, nonatomic) IBOutlet UIView *containView;
@property (weak, nonatomic) IBOutlet UIView *container2View;

@property (nonatomic, copy) NSString *jjj;

@end

@implementation CAShapeLayerController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self drawPeople];
}

- (void)viewDidLayoutSubviews {
    [self drawConner];
}

- (void)drawPeople {
    
    UIBezierPath *path  = [[UIBezierPath alloc] init];
    
    [path moveToPoint:CGPointMake(175, 100)];
    [path addArcWithCenter:CGPointMake(150, 100) radius:25 startAngle:0 endAngle:2*M_PI clockwise:YES];
    
    [path moveToPoint:CGPointMake(150, 125)];
    [path addLineToPoint:CGPointMake(150, 175)];
    [path addLineToPoint:CGPointMake(125, 225)];
    [path moveToPoint:CGPointMake(150, 175)];
    [path addLineToPoint:CGPointMake(175, 225)];
    [path moveToPoint:CGPointMake(100, 150)];
    [path addLineToPoint:CGPointMake(200, 150)];
    
    // create shape layer
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.strokeColor = [UIColor redColor].CGColor;
    shapeLayer.fillColor = [UIColor clearColor].CGColor;
    shapeLayer.lineWidth = 5;
    shapeLayer.lineJoin = kCALineJoinRound;
    shapeLayer.lineCap = kCALineCapRound;
    shapeLayer.path = path.CGPath;
    
    // add it to our view
    [self.containView.layer addSublayer:shapeLayer];
    
    
    NSMutableString *bb = [NSMutableString stringWithString:@"jjjjj"];
    self.jjj = bb;
    
    [bb appendString:@"xxxx"];
    
    NSLog(@"jjj = %@", _jjj);
    
    NSArray *array = @[@[@"a", @"b"], @[@"c", @"d"]];
    NSArray *copyArray = [array copy];
    //copyArray = nil;
    NSArray *copyArray1 = array;
    copyArray1 = nil;
    NSMutableArray *mCopyArray = [array mutableCopy];
    NSLog(@"array : %p  copyArray : %p   copyArray1 : %p  mCopyArray : %p",array,copyArray,copyArray1,mCopyArray);
}

- (void)drawConner {
    //define path parameters
    CGRect rect = CGRectMake(50, 50, 100, 100);
    CGSize radii = CGSizeMake(20, 20);
    UIRectCorner corners = UIRectCornerTopRight | UIRectCornerBottomRight | UIRectCornerBottomLeft;
    //create path
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:rect byRoundingCorners:corners cornerRadii:radii];
    
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.path = path.CGPath;
    
    // 添加图层蒙版 － 只显示蒙版指定的部分 － 其他部分被挡住
    self.container2View.layer.mask = shapeLayer;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
