//
//  LQFChatListViewVC.m
//  LQFLearnDemo
//
//  Created by liqunfei on 2017/8/16.
//  Copyright © 2017年 LQF. All rights reserved.
//

#import "LQFChatListViewVC.h"
#import "LQFChatVC.h"

@interface LQFChatListViewVC ()

@property (nonatomic, strong) UIView *customNavbar;

@property (nonatomic, strong) UIButton *backButton;

@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation LQFChatListViewVC

- (instancetype)init {
    self = [super init];
    if (self) {
        //设置需要显示哪些类型的会话
        [self setDisplayConversationTypes:@[@(ConversationType_PRIVATE),
                                            @(ConversationType_DISCUSSION),
                                            @(ConversationType_CHATROOM),
                                            @(ConversationType_GROUP),
                                            @(ConversationType_APPSERVICE),
                                            @(ConversationType_SYSTEM)]];
        
        //设置需要将哪些类型的会话在会话列表中聚合显示
        [self setCollectionConversationType:@[@(ConversationType_DISCUSSION),
                                              @(ConversationType_GROUP)]];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBarHidden = YES;
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self customNavigationBar];
    _titleLabel.text = @"融云";
    
    CGRect tvRect = self.conversationListTableView.frame;
    tvRect = CGRectMake(0, 64, DEVICE_WIDTH, DEVICE_HEIGHT - 64);
    [self.conversationListTableView setFrame:tvRect];
    
    [self setConversationAvatarStyle:RC_USER_AVATAR_CYCLE];
}

- (void)willDisplayConversationTableCell:(RCConversationBaseCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    RCConversationModel *model = self.conversationListDataSource[indexPath.row];

    if (model.conversationModelType == RC_CONVERSATION_MODEL_TYPE_COLLECTION) {
        //设置聚合显示的昵称为绿色
//        RCConversationCell *conversationCell = (RCConversationCell *)cell;
//        
//        conversationCell.conversationTitle.textColor = [UIColor greenColor];
    }
    else if (model.conversationType == ConversationType_PRIVATE) {
        //设置私聊昵称为蓝色
        
        RCConversationCell *conversationCell = (RCConversationCell *)cell;
        
        conversationCell.conversationTitle.textColor = MyBlue;
    }
}

- (void)onSelectedTableRow:(RCConversationModelType)conversationModelType conversationModel:(RCConversationModel *)model atIndexPath:(NSIndexPath *)indexPath {
    
    if (conversationModelType == RC_CONVERSATION_MODEL_TYPE_COLLECTION) {
        //聚合页面
        LQFChatListViewVC *temp = [[LQFChatListViewVC alloc] init];
        
        NSArray *array = [NSArray arrayWithObject:[NSNumber numberWithInt:model.conversationType]];
    
        [temp setDisplayConversationTypes:array];
        
        [temp setCollectionConversationType:nil];
        
        temp.isEnteredToCollectionViewController = YES;
        
        [self.navigationController pushViewController:temp animated:YES];
    }
    
    else if (model.conversationType == ConversationType_PRIVATE) {
        LQFChatVC *converSationVC = [[LQFChatVC alloc] init];
        
        converSationVC.conversationType = model.conversationType;
        
        converSationVC.targetId = model.targetId;
        
        converSationVC.title = model.targetId;
        
        [self.navigationController pushViewController:converSationVC animated:YES];
    }
    
}

- (void)didTapCellPortrait:(RCConversationModel *)model {
    [super didTapCellPortrait:model];
}

#pragma mark - 自定义UI
/*
- (NSMutableArray *)willReloadTableData:(NSMutableArray *)dataSource {

}

- (RCConversationBaseCell *)rcConversationListTableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

}

- (CGFloat)rcConversationListTableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

}
*/

#pragma mark - TableView
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.1;
}

#pragma mark - 自定义导航栏
- (void)customNavigationBar {
    _customNavbar = [[UIView alloc] initWithFrame:CGRectMake(0, 0, DEVICE_WIDTH, 64)];
    UIImageView *navImageView = [[UIImageView alloc] initWithFrame:_customNavbar.bounds];
    navImageView.image = ImageNamed(@"navgationBackground");
    [_customNavbar addSubview:navImageView];
    [self.view addSubview:_customNavbar];
    
    _backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_backButton setFrame:CGRectMake(0, 20, 44, 44)];
    [_backButton setBackgroundImage:ImageNamed(@"Back") forState:UIControlStateNormal];
    [_backButton addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
    [_customNavbar addSubview:_backButton];
    
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, DEVICE_WIDTH, 200)];
    _titleLabel.textColor = [UIColor darkGrayColor];
    _titleLabel.font = [UIFont systemFontOfSize:16.0f];
    _titleLabel.center = CGPointMake(DEVICE_WIDTH / 2, 44);
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    [_customNavbar addSubview:_titleLabel];
}

- (void)back:(UIButton *)button {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
