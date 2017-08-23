//
//  LQFRCloudNoteVC.m
//  LQFLearnDemo
//
//  Created by liqunfei on 2017/8/18.
//  Copyright © 2017年 LQF. All rights reserved.
//

#import "LQFRCloudNoteVC.h"
#import "LQFNoteView.h"

@interface LQFRCloudNoteVC ()

@property (nonatomic, strong) LQFNoteView *noteView;

@end

@implementation LQFRCloudNoteVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navTitle = @"融云2.8.15";
    
    [self buildUI];
    
    [self write];
}

- (void)buildUI {
    _noteView = [LQFNoteView new];
    [self.view addSubview:_noteView];
    
    [_noteView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(65);
        make.leading.mas_equalTo(20);
        make.trailing.mas_equalTo(-20);
        make.bottom.mas_equalTo(-20);
    }];
}

- (void)write {
    [_noteView addNounText:@"Token:"];
    [_noteView addContent:@"当前用户连接融云的身份凭证,需要向服务器端请求,开发者后台提供了API调试的功能,手动获取 Token "];
    
    [_noteView addTitle:@"初始化"];
    [_noteView addNounText:@"RCIM单例 "];
    [_noteView addContent:@"传入 initWithAppKey: 方法"];
    
    [_noteView addTitle:@"连接服务器"];
    [_noteView addNounText:@"RCIM单例 "];
    [_noteView addContent:@"传入 -connectWithToken:success:error:tokenIncorrect: 方法"];
    
    [_noteView addTitle:@"会话列表"];
    [_noteView addNounText:@"默认 "];
    [_noteView addContent:@"直接使用或继承 RCConversationListViewController"];
    
    [_noteView addNounText:@"会话类型"];
    [_noteView addContent:@""];
    [_noteView addNounText:@"聚合显示"];    
    [_noteView addContent:@""];
    
    [_noteView addTitle:@"进入聊天"];
    [_noteView addContent:@"聚合的cell和其他的cell点击之后进入的页面不一样,聚合点击之后跳转一个新的会话列表页面,其他的进入聊天会话界面"];
    
    [_noteView addTitle:@"用户信息"];
    [_noteView addContent:@"设置在会话列表中显示的会话类型、会话类型聚合、头像和昵称的显示、昵称的字体颜色、会话列表 cell 的背景色等。"];
    [_noteView addContent:@"AppDelegate --> "];
    [_noteView addNounText:@"RCIMUserInfoDataSource 数据源"];
    [_noteView addContent:@""];
    [_noteView addContent:@"会话列表页面 --> "];
    [_noteView addNounText:@"willDisplayConversationTableCell 方法"];
    [_noteView addContent:@""];
    
    [_noteView addTitle:@"聊天页面的设置"];
    [_noteView addNounText:@"conversationMessageCollectionView "];
    [_noteView addContent:@"消息载体"];
    [_noteView addNounText:@"willDisplayMessageCell 方法 "];
    [_noteView addContent:@"在该方法中定制UI"];
    
    [_noteView addTitle:@"断开连接"];
    [_noteView addNounText:@"- (void)disconnect:(BOOL)isReceivePush;"];
    [_noteView addContent:@"App在断开连接之后，是否还接收远程推送"];
    [_noteView addNounText:@"- (void)disconnect;"];
    [_noteView addContent:@" 断开与融云服务器的连接，但仍然接收远程推送"];
    [_noteView addNounText:@"- (void)logout;"];
    [_noteView addContent:@"断开与融云服务器的连接，并不再接收远程推送"];
    
    [_noteView addTitle:@"连接融云"];
    [_noteView addNounText:@"错误处理"];
    [_noteView addContent:@"tokenIncorrect与error的处理"];
    
    [_noteView addTitle:@"用户信息"];
    [_noteView addNounText:@"设计原理"];
    [_noteView addContent:@""];
    
    [_noteView addNounText:@"刷新SDK缓存:"];
    [_noteView addContent:@"当用户信息或者群组信息发生变化之后，需要刷新缓存"];
    [_noteView addNounText:@"-refreshUserInfoCache:withUserId:"];
    [_noteView addContent:@"更新用户信息缓存"];
    [_noteView addNounText:@"-refreshGroupInfoCache:withGroupId:"];
    [_noteView addContent:@"更新群组信息缓存"];
    [_noteView addNounText:@"- (void)refreshGroupUserInfoCache:withUserId:               withGroupId:"];
    [_noteView addContent:@"更新缓存的群名片信息"];
    
    [_noteView addNounText:@"获取缓存的信息:"];
    [_noteView addContent:@"用户信息、群组信息、群名片信息"];
    
    [_noteView addNounText:@"清除缓存数据"];
    [_noteView addContent:@""];
    
    [_noteView addNounText:@"持久化保存"];
    [_noteView addContent:@""];
    
    [_noteView addTitle:@"基础功能"];
    [_noteView addNounText:@"单聊ConversationType_PRIVATE:"];
    [_noteView addContent:@"targetId --> userId"];
    
    [_noteView addNounText:@"讨论组ConversationType_DISCUSSION:"];
    [_noteView addContent:@"targetId --> 创建讨论组成功后融云生成返回的"];
    [_noteView addContent:@"创建讨论组、讨论组加人、讨论组踢人、退出当前讨论组、获取讨论组信息 、设置讨论组名称 、设置讨论组加人权限的方法"];
    
    [_noteView addNounText:@"群组ConversationType_GROUP:"];
    [_noteView addContent:@"调用自家服务器接口"];
    
    [_noteView addNounText:@"聊天室ConversationType_CHATROOM"];
    [_noteView addContent:@""];
    
    [_noteView addNounText:@"系统会话ConversationType_SYSTEM"];
    [_noteView addContent:@""];
    
    [_noteView addNounText:@"客服ConversationType_CUSTOMERSERVICE"];
    [_noteView addContent:@""];
    
    [_noteView addNounText:@"公众号"];
    [_noteView addContent:@""];
    
    [_noteView addTitle:@"消息发送"];
    [_noteView addNounText:@"远程推送"];
    [_noteView addContent:@""];
    
    [_noteView addNounText:@"本地通知:"];
    [_noteView addContent:@"没找到用法"];
    
    [_noteView addNounText:@"文本消息"];
    [_noteView addContent:@""];
    
    [_noteView addNounText:@"位置消息"];
    [_noteView addContent:@""];
    
    [_noteView addNounText:@"语音消息"];
    [_noteView addContent:@""];
    
    [_noteView addNounText:@"图文(富文本)消息"];
    [_noteView addContent:@""];
    
    [_noteView addNounText:@"图片消息"];
    [_noteView addContent:@""];
    
    [_noteView addNounText:@"文件消息"];
    [_noteView addContent:@""];
    
    [_noteView addTitle:@"消息接收监听"];
    [_noteView addNounText:@"RCIMReceiveMessageDelegate"];
    [_noteView addContent:@"代理设置给AppDelegate"];
    [_noteView addNounText:@"接收消息"];
    [_noteView addContent:@""];
    [_noteView addContent:@"onRCIMReceiveMessage:left: 在前台和后台活动状态时收到任何消息都会执行。在此之前消息已经被存入了 SDK 内置数据库中。"];
    
    [_noteView addNounText:@"关闭某个会话"];
    [_noteView addContent:@""];
    
    [_noteView addNounText:@"按时间段关闭某个会话"];
    [_noteView addContent:@""];
    [_noteView addContent:@"设置屏蔽、删除屏蔽、查询屏蔽"];
    
    [_noteView addNounText:@"关闭所有前台提示音"];
    [_noteView addContent:@""];
    
    [_noteView addNounText:@"关闭某个(类)消息的提示音"];
    [_noteView addContent:@""];
    
    [_noteView addNounText:@"关闭后台本地通知"];
    
    [_noteView endEdit];
}

@end
