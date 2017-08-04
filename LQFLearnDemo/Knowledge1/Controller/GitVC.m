//
//  GitVC.m
//  LQFLearnDemo
//
//  Created by liqunfei on 2017/7/24.
//  Copyright © 2017年 LQF. All rights reserved.
//

#import "GitVC.h"

@interface GitVC ()

@property (strong, nonatomic) UITextView *noteTV;

@end

@implementation GitVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.quoteUrl = @"https://www.liaoxuefeng.com/wiki/0013739516305929606dd18361248578c67b8067c8c017b000";
    self.navTitle = @"git语法";
    
    _noteTV = [[UITextView alloc] initWithFrame:CGRectMake(20, 110, DEVICE_WIDTH - 40, DEVICE_HEIGHT - 110)];
    _noteTV.editable = NO;
    [self.view addSubview:_noteTV];
    
    NSString *node = [NSString stringWithFormat:@"笔记\n\n%@\n\n%@\n\n%@\n\n%@\n\n%@\n\n%@\n\n%@\n\n%@\n\n%@\n\n%@\n\n%@\n\n%@\n\n%@\n\n%@\n\n%@\n\n%@\n\n%@\n\n%@\n\n%@\n\n%@\n\n%@\n\n%@\n\n%@\n\n%@\n\n%@\n\n%@\n\n%@\n\n%@\n\n%@\n\n%@\n\n%@\n\n%@\n\n%@\n\n%@\n\n%@\n\n%@\n\n%@\n\n%@\n\n%@\n\n%@\n\n%@\n\n%@\n\n%@\n\n%@\n\n%@\n\n%@\n\n",
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
                      @"11.git reflog : 命令历史记录",
                      @"12.git diff HEAD -- <文件名> : 该文件在工作区和仓库中最新版本的区别",
                      @"13.git checkout -- <file> : 撤销工作区的操作",
                      @"14.git reset HEAD <file> : 撤销暂存区的操作",
                      @"15.git rm <文件名> : 删除文件,还需加上git commit语句",
                      @"16.git remote add origin <网址> : 关联一个远程库",
                      @"17.git push -u origin master : 第一次推送所有内容",
                      @"18.git push origin master : 推送修改到远程库",
                      @"19.git clone <网址> : 从远程克隆仓库到本地",
                      @"20.git branch : 查看分支",
                      @"21.git branch <name> : 创建分支",
                      @"22.git checkout <name> : 切换到某分支",
                      @"23.git checkout -b <name> : 创建并切换到某分支",
                      @"24.git merge <name> : 合并某分支到当前分支",
                      @"25.git branch -d <name> : 删除某分支",
                      @"26.git log --graph : 查看分支合并图",
                      @"27.git merge --no-ff -m <描述> <分支name> : --no-ff参数合并分支,合并后的历史有分支",
                      @"28.git stash : 将当前工作区储藏起来,方便在其他分支修复bug",
                      @"29.git stash list : 查看stash历史记录",
                      @"30.git stash pop : 恢复工作区并删除stash",
                      @"31.git branch -D <分支name> : 丢弃一个没有被合并过的分支",
                      @"32.git remote -v : 查看远程库信息",
                      @"33.git push origin <分支name> : 从本地推送分支到远程库",
                      @"34.git pull : 抓取远程库的新提交(更新)",
                      @"35.git checkout -b <branch-name> origin/<branch-name> : 在本地创建和远程分支对应的分支",
                      @"36.git branch --set-upstream <branch-name> origin/<branch-name> : 建立本地分支和远程分支的关联",
                      @"37.git clone : 从远程库克隆项目到本地",
                      @"38.git tag <标签name> : 在HEAD创建一个标签",
                      @"39.git tag <标签name> <commit id> : 在某个commit处创建标签",
                      @"40.git tag -a <标签name> -m <注释(需加引号)> : 创建有标签信息的标签",
                      @"41.git tag : 查看所有标签",
                      @"42.git show <标签name> : 查看标签信息",
                      @"43.git push origin <tagname> : 将本地标签推送到远程库",
                      @"44.git push origin --tags : 将本地全部位推送的标签推送到远程库",
                      @"45.git tag -d <tagname> : 删除一个本地标签",
                      @"46.git push origin :refs/tags/<tagname> : 删除一个远程库标签"
                      ];
    
    _noteTV.text = node;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
