//
//  LQFChatVC.m
//  LQFLearnDemo
//
//  Created by liqunfei on 2017/8/18.
//  Copyright © 2017年 LQF. All rights reserved.
//

#import "LQFChatVC.h"

@interface LQFChatVC ()

@property (nonatomic, strong) UIView *customNavbar;

@property (nonatomic, strong) UIButton *backButton;

@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation LQFChatVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self customNavigationBar];
    //聊天背景颜色
//    self.conversationMessageCollectionView.backgroundColor = [UIColor clearColor];
    
    //聊天背景图
//    self.view.backgroundColor = [UIColor colorWithPatternImage:ImageNamed(@"Chat_BG")];
}

- (void)willDisplayMessageCell:(RCMessageBaseCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    if ([cell isMemberOfClass:[RCTextMessageCell class]]) {
        RCTextMessageCell *testMsgCell = (RCTextMessageCell *)cell;
        testMsgCell.textLabel.textColor = [UIColor yellowColor];
    }
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
    _titleLabel.text = @"会话页面";
    [_customNavbar addSubview:_titleLabel];
}

- (void)back:(UIButton *)button {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
