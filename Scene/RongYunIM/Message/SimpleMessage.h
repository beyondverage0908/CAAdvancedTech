//
//  SimpleMessage.h
//  CAAdvancedTech
//
//  Created by pingjun lin on 2017/1/11.
//  Copyright © 2017年 pingjun lin. All rights reserved.
//

#import <RongIMLib/RongIMLib.h>

@interface SimpleMessage : RCMessageContent<NSCoding,RCMessageContentView>

/** 文本消息内容 */
@property(nonatomic, strong) NSString* content;

/**
 * 附加信息
 */
@property(nonatomic, strong) NSString* extra;

/**
 * 根据参数创建文本消息对象
 * @param content 文本消息内容
 */
+(instancetype)messageWithContent:(NSString *)content;

@end
