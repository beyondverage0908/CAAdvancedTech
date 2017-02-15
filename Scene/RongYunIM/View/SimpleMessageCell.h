//
//  SimpleMessageCell.h
//  CAAdvancedTech
//
//  Created by pingjun lin on 2017/1/11.
//  Copyright © 2017年 pingjun lin. All rights reserved.
//

#import <RongIMKit/RongIMKit.h>

@interface SimpleMessageCell : RCMessageCell

/**
 * 消息显示Label
 */
@property(strong, nonatomic) RCAttributedLabel *textLabel;

/**
 * 消息背景
 */
@property(nonatomic, strong) UIImageView *bubbleBackgroundView;

/**
 * 设置消息数据模型
 *
 * @param model 消息数据模型
 */
- (void)setDataModel:(RCMessageModel *)model;

@end
