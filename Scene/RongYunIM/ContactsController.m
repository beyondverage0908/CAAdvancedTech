//
//  ContactsController.m
//  CAAdvancedTech
//
//  Created by pingjun lin on 2017/1/10.
//  Copyright © 2017年 pingjun lin. All rights reserved.
//

#import "ContactsController.h"
#import "ChatController.h"

@interface ContactsController ()<RCIMUserInfoDataSource>

@end

@implementation ContactsController

- (instancetype)init {
    self = [super init];
    if (self) {
        // 集中在一个聊天类中
        // 设置需要显示哪些类型的会话
        [self setDisplayConversationTypeArray:@[@(ConversationType_PRIVATE),
                                                @(ConversationType_DISCUSSION),
                                                @(ConversationType_CHATROOM),
                                                @(ConversationType_GROUP),
                                                @(ConversationType_APPSERVICE),
                                                @(ConversationType_SYSTEM)]];
        // 设置需要将哪些类型的会话在会话列表中聚合显示
        [self setCollectionConversationType:@[@(ConversationType_DISCUSSION),
                                              @(ConversationType_GROUP)]];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.showConnectingStatusOnNavigatorBar = YES;
//    self.topCellBackgroundColor = [UIColor yellowColor];
//    self.cellBackgroundColor = [UIColor purpleColor];
    
    [self setConversationAvatarStyle:RC_USER_AVATAR_RECTANGLE];
    [self setConversationPortraitSize:CGSizeMake(40, 40)];
    
    [[RCIM sharedRCIM] setUserInfoDataSource:self];
    
    [self setupNavigationBarBtn];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
//    self.conversationListDataSource = self.contactList;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)setupNavigationBarBtn {
    self.navigationItem.rightBarButtonItem
    = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                                                    target:self
                                                    action:@selector(rightAddChat)];
}

- (void)rightAddChat {
    [[RCIMClient sharedRCIMClient] createDiscussion:[NSString stringWithFormat:@"dis_%@", @(arc4random() % 5)]
                                         userIdList:@[@"10010", @"10012", @"10013", @"100001"] success:^(RCDiscussion *discussion) {
        NSLog(@"创建讨论组成功，成员ID是: %@", [discussion.memberIdList componentsJoinedByString:@"-"]);
    } error:^(RCErrorCode status) {
        NSLog(@"创建讨论组失败，错误码是: %@", @(status));
    }];
}

#pragma mark - 自定义RC联系人列表

//- (CGFloat)rcConversationListTableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    return 150;
//}
//
//- (RCConversationBaseCell *)rcConversationListTableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    NSString *reuse_identifier = @"reuse_identifier";
//    RCConversationCell *cell = [[RCConversationCell alloc] initWithStyle:UITableViewCellStyleDefault
//                                                         reuseIdentifier:reuse_identifier];
//    return cell;
//}

#pragma mark - 重写父类RCConversationListViewController方法

- (void)onSelectedTableRow:(RCConversationModelType)conversationModelType conversationModel:(RCConversationModel *)model atIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"----%@-------%@-----%@", [RCIM sharedRCIM].currentUserInfo.userId, model.conversationTitle, model.senderUserId);
    
    if (conversationModelType == RC_CONVERSATION_MODEL_TYPE_COLLECTION) {
        ContactsController *collectionVC = [[ContactsController alloc] init];
        NSArray *conversationType = [NSArray arrayWithObjects:[NSNumber numberWithInteger:model.conversationType], nil];
        [collectionVC setDisplayConversationTypeArray:conversationType];
        [collectionVC setCollectionConversationType:@[]];
        collectionVC.title = model.conversationTitle;
        [self.navigationController pushViewController:collectionVC animated:YES];
        return;
    }
    
    ChatController *chatVC = [[ChatController alloc] init];
    chatVC.conversationType = model.conversationType;
    chatVC.targetId = model.targetId;
    chatVC.title = model.conversationTitle;
    [self.navigationController pushViewController:chatVC animated:YES];
}

#pragma mark - RCIMUserInfoDataSource设置用户的显示

- (void)getUserInfoWithUserId:(NSString *)userId
                   completion:(void (^)(RCUserInfo *userInfo))completion{
    RCUserInfo *userInfo = [[RCUserInfo alloc] init];
    userInfo.userId = userId;
    userInfo.portraitUri = @"http://pic1.win4000.com/pic/3/67/6aae1242216.jpg_195.jpg";
    userInfo.name = [NSString stringWithFormat:@"用户%@", userId];
    
    completion(userInfo);
}

#pragma mark - Cell加载显示的回调

- (void)willDisplayConversationTableCell:(RCConversationBaseCell *)cell
                             atIndexPath:(NSIndexPath *)indexPath {
    // 获取会话列表数据
    RCConversationModel *model = self.conversationListDataSource[indexPath.row];
//    NSLog(@"-----------%@-----%@", model.conversationTitle, model.senderUserId);
    
    if (model.conversationModelType == ConversationType_PRIVATE) {
        RCConversationCell *conversationCell = (RCConversationCell *)cell;
        conversationCell.conversationTitle.textColor = [UIColor blueColor];
    }
}

@end
