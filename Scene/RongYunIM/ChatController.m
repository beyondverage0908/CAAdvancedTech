//
//  ChatController.m
//  CAAdvancedTech
//
//  Created by pingjun lin on 2017/1/10.
//  Copyright © 2017年 pingjun lin. All rights reserved.
//

#import "ChatController.h"
#import "SimpleMessageCell.h"
#import "SimpleMessage.h"

@interface ChatController ()

@end

#define ScreenW             [UIScreen mainScreen].bounds.size.width

@implementation ChatController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.conversationMessageCollectionView.backgroundColor = [UIColor yellowColor];
    
    /// 超过一个屏幕的显示，右上角显示未读消息数
    self.enableUnreadMessageIcon = YES;
    /// 右下角的未读消息数提示
    self.enableNewComingMessageIcon = NO;
    
    /// 自定义输入面板
    [self setupPluginBoardView];

    [self registerClass:[SimpleMessageCell class] forMessageClass:[SimpleMessage class]];
//    [self registerClass:[SimpleMessageCell class] forCellWithReuseIdentifier:@"SimpleMessageCell"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - 自定义输入面板

- (void)setupPluginBoardView {
    RCPluginBoardView *pluginBoardView = self.chatSessionInputBarControl.pluginBoardView;
    [pluginBoardView insertItemWithImage:[UIImage imageNamed:@"im_rc_broadcast"]
                                   title:@"公告"
                                     tag:20000];
}

-(void)pluginBoardView:(RCPluginBoardView*)pluginBoardView clickedItemWithTag:(NSInteger)tag {
    [super pluginBoardView:pluginBoardView clickedItemWithTag:tag];

    if (tag == 20000) {
        NSLog(@"自定义输入面板事件回调");
        
        RCMessageContent *msgContent = [[RCMessageContent alloc] init];
        msgContent.senderUserInfo = [[RCUserInfo alloc] initWithUserId:@"10012" name:@"jjjj" portrait:nil];
        msgContent.mentionedInfo = [[RCMentionedInfo alloc] initWithMentionedType:RC_Mentioned_All
                                                                       userIdList:@[@"10012"]
                                                                 mentionedContent:@"起床了"];
        [self sendMessage:msgContent pushContent:@"啊啊啊啊"];
    }
}

#pragma mark - 消息将要显示的时候调用

- (void)willDisplayMessageCell:(RCMessageBaseCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    if ([cell isKindOfClass:[RCTextMessageCell class]]) {
        RCTextMessageCell *textMsgCell = (RCTextMessageCell *)cell;
        textMsgCell.textLabel.textColor = [UIColor redColor];
    }
}

#pragma mark - 自定义消息类型，Cell的使用

//- (RCMessageBaseCell *)rcConversationCollectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
//    RCMessageModel *model = self.conversationDataRepository[indexPath.row];
////    NSString *cellIndentifier = @"SimpleMessageCell";
////    RCMessageBaseCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIndentifier           forIndexPath:indexPath];
//    SimpleMessageCell *simpleMsgCell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([SimpleMessage class]) forIndexPath:indexPath];
//    if (!simpleMsgCell) {
//
//    }
//    [simpleMsgCell setDataModel:model];
//    return simpleMsgCell;
//}
//
//- (CGSize)rcConversationCollectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
//    //返回自定义cell的实际高度
//    return CGSizeMake(300, 60);
//}

@end
