//
//  LQFChatVC.m
//  LQFLearnDemo
//
//  Created by liqunfei on 2017/8/18.
//  Copyright © 2017年 LQF. All rights reserved.
//

#import "LQFChatVC.h"

@interface LQFChatVC ()

@end

@implementation LQFChatVC

- (void)viewDidLoad {
    [super viewDidLoad];
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

@end
