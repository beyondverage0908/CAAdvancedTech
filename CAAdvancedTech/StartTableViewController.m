//
//  StartTableViewController.m
//  CAAdvancedTech
//
//  Created by pingjun lin on 16/7/23.
//  Copyright © 2016年 pingjun lin. All rights reserved.
//

#import "StartTableViewController.h"
#import "FirstViewController.h"
#import "ThreeDTransformController.h"
#import "CABaseViewController.h"
#import "CAShapeLayerController.h"
#import "TestOfBundleController.h"
#import "AESRSA128Controller.h"

@interface StartTableViewController ()

@property (nonatomic, strong) NSMutableArray       *   controllersTitleArr;
@property (nonatomic, strong) NSMutableArray       *   controllersArr;

@end

@implementation StartTableViewController

- (void)initData
{
    _controllersTitleArr = [NSMutableArray new];
    [_controllersTitleArr addObjectsFromArray:@[@"第一个控制器",
                                                @"3D旋转变换",
                                                @"基础动画",
                                                @"CAShapeLayer",
                                                @"测试Bundle文件",
                                                @"RSA,AES128数据加密"]];
    
    _controllersArr = [NSMutableArray new];
    [_controllersArr addObjectsFromArray:@[@"FirstViewController",
                                           @"ThreeDTransformController",
                                           @"CABaseViewController",
                                           @"CAShapeLayerController",
                                           @"TestOfBundleController",
                                           @"AESRSA128Controller"]];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.controllersArr count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *reuseIdentifier = @"reuseIdentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    cell.textLabel.text = _controllersTitleArr[indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UIViewController *controller = [[NSClassFromString(self.controllersArr[indexPath.row]) alloc] init];
    controller.title = self.controllersTitleArr[indexPath.row];
    [self.navigationController pushViewController:controller animated:YES];
    
//    if (indexPath.row == 0) {
//        FirstViewController *controller = [[FirstViewController alloc] init];
//        controller.title = _controllersTitleArr[indexPath.row];
//        [self.navigationController pushViewController:controller animated:YES];
//    }
//    else if (indexPath.row == 1) {
//        ThreeDTransformController *threeDVC = [[ThreeDTransformController alloc] init];
//        threeDVC.title = _controllersTitleArr[indexPath.row];
//        [self.navigationController pushViewController:threeDVC animated:YES];
//    }
//    else if (indexPath.row == 2) {
//        CABaseViewController *baseVC = [[CABaseViewController alloc] init];
//        baseVC.title = _controllersTitleArr[indexPath.row];
//        [self.navigationController pushViewController:baseVC animated:YES];
//    }
//    else if (indexPath.row == 3) {
//        CAShapeLayerController *shapeVC = [[CAShapeLayerController alloc] init];
//        shapeVC.title = _controllersTitleArr[indexPath.row];
//        [self.navigationController pushViewController:shapeVC animated:YES];
//    }
}
@end
