//
//  GitVC.m
//  LQFLearnDemo
//
//  Created by liqunfei on 2017/7/24.
//  Copyright © 2017年 LQF. All rights reserved.
//

#import "GitVC.h"

@interface GitVC ()

@property (weak, nonatomic) IBOutlet UITextView *noteTV;
@property (nonatomic, strong) LQFPopOutView *popOutView;

@end

@implementation GitVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    NSString *node = [NSString stringWithFormat:@"%@\n%@\n%@\n%@\n%@\n%@\n%@\n%@\n%@\n%@\n%@",
                      @"1.将目录变成git库: git init",
                      @"2.单个文件添加到git库: git add <文件名>",
                      @"3.提交: git commit -m 注释",
                      @"4.当前状态: git status",
                      @"5.某个文件的改动点: git diff <文件名>",
                      @"6.历史记录: git log",
                      @"7.简洁版历史记录: git log --pretty=oneline",
                      @"8.HEAD:当前版本,HEAD^:上个版本,HEAD^^:上上个版本....HEAD~100:往上100个版本",
                      @"9.回退到上一个版本: git reset --hard HEAD^",
                      @"10.git reset --hard <版本号> : 恢复到指定版本",
                      @"11.git reflog : 命令历史记录"];
    
    _noteTV.text = node;
}

- (IBAction)popWebView:(UIButton *)sender {
    [[LQFPopTool sharedInstance] popView:self.popOutView animated:YES];
}

- (LQFPopOutView *)popOutView {
    if (!_popOutView) {
        _popOutView = [[LQFPopOutView alloc] init];
        _popOutView.urlStr = @"https://www.liaoxuefeng.com/wiki/0013739516305929606dd18361248578c67b8067c8c017b000";
        _popOutView.dismissBlock = ^(LQFPopOutView *popOutView) {
            [[LQFPopTool sharedInstance] closeAnimated:YES];
        };
    }
    return _popOutView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
