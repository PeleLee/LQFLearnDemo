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
    
    [_noteView endEdit];
}

@end
