//
//  VHSToast.h
//  GongYunTong
//
//  Created by pingjun lin on 16/9/20.
//  Copyright © 2016年 vhs_health. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface VHSToast : NSObject

@property (nonatomic, assign)NSTimeInterval duration;

+ (VHSToast *)shareToast;

+ (void)toast:(NSString *)msg;

@end
