//
//  GitVC.m
//  LQFLearnDemo
//
//  Created by liqunfei on 2017/7/24.
//  Copyright © 2017年 LQF. All rights reserved.
//

#import "GitVC.h"
#import "NSString+LQF.h"

@interface GitVC ()

@property (strong, nonatomic) UITextView *noteTV;@property (nonatomic, strong) NSMutableAttributedString *noteAttStr;

@end

@implementation GitVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.quoteUrl = @"https://www.liaoxuefeng.com/wiki/0013739516305929606dd18361248578c67b8067c8c017b000";
    self.navTitle = @"git语法";
    
    _noteTV = [[UITextView alloc] initWithFrame:CGRectMake(20, 110, DEVICE_WIDTH - 40, DEVICE_HEIGHT - 110)];
    _noteTV.editable = NO;
    _noteTV.showsVerticalScrollIndicator = NO;
    [self.view addSubview:_noteTV];
    
    [self makeNote];
}

- (void)makeNote {
    NSArray *notes = @[
                       [self QStrWithElement:@"git init" explain:@"将目录变成git库"],
                       [self QStrWithElement:@"git add <文件名>" explain:@"单个文件添加到git库"],
                       [self QStrWithElement:@"git commit -m 注释" explain:@"提交"],
                       [self QStrWithElement:@"git status" explain:@"当前状态"],
                       [self QStrWithElement:@"git diff <文件名>" explain:@"某个文件的改动点"],
                       [self QStrWithElement:@"git log" explain:@"历史记录"],
                       [self QStrWithElement:@"git log --pretty=oneline" explain:@"简洁版历史记录"],
                       [self QStrWithElement:@"HEAD" explain:@"当前版本,HEAD^:上个版本,HEAD^^:上上个版本....HEAD~100:往上100个版本"],
                       [self QStrWithElement:@"git reset --hard HEAD^" explain:@"回退到上一个版本"],
                       [self QStrWithElement:@"git reset --hard <版本号>" explain:@"恢复到指定版本"],
                       [self QStrWithElement:@"git reflog" explain:@"命令历史记录"],
                       [self QStrWithElement:@"git diff HEAD -- <文件名>" explain:@"该文件在工作区和仓库中最新版本的区别"],
                       [self QStrWithElement:@"git checkout -- <file>" explain:@"撤销工作区的操作"],
                       [self QStrWithElement:@"git reset HEAD <file>" explain:@"撤销暂存区的操作"],
                       [self QStrWithElement:@"git rm <文件名>" explain:@"删除文件,还需加上git commit语句"],
                       [self QStrWithElement:@"git remote add origin <网址>" explain:@"关联一个远程库"],
                       [self QStrWithElement:@"git push -u origin master" explain:@"第一次推送所有内容"],
                       [self QStrWithElement:@"git push origin master" explain:@"推送修改到远程库"],
                       [self QStrWithElement:@"git clone <网址>" explain:@"从远程克隆仓库到本地"],
                       [self QStrWithElement:@"git branch" explain:@"查看分支"],
                       [self QStrWithElement:@"git branch <name>" explain:@"创建分支"],
                       [self QStrWithElement:@"git checkout <name>" explain:@"切换到某分支"],
                       [self QStrWithElement:@"git checkout -b <name>" explain:@"创建并切换到某分支"],
                       [self QStrWithElement:@"git merge <name>" explain:@"合并某分支到当前分支"],
                       [self QStrWithElement:@"git branch -d <name>" explain:@"删除某分支"],
                       [self QStrWithElement:@"git log --graph" explain:@"查看分支合并图"],
                       [self QStrWithElement:@"git merge --no-ff -m <描述> <分支name>" explain:@"--no-ff参数合并分支,合并后的历史有分支"],
                       [self QStrWithElement:@"git stash" explain:@"将当前工作区储藏起来,方便在其他分支修复bug"],
                       [self QStrWithElement:@"git stash list" explain:@"查看stash历史记录"],
                       [self QStrWithElement:@"git stash pop" explain:@"恢复工作区并删除stash"],
                       [self QStrWithElement:@"git branch -D <分支name>" explain:@"丢弃一个没有被合并过的分支"],
                       [self QStrWithElement:@"git remote -v" explain:@"查看远程库信息"],
                       [self QStrWithElement:@"git push origin <分支name>" explain:@"从本地推送分支到远程库"],
                       [self QStrWithElement:@"git pull" explain:@"抓取远程库的新提交(更新)"],
                       [self QStrWithElement:@"git checkout -b <branch-name> origin/<branch-name>" explain:@"在本地创建和远程分支对应的分支"],
                       [self QStrWithElement:@"git branch --set-upstream <branch-name> origin/<branch-name>" explain:@"建立本地分支和远程分支的关联"],
                       [self QStrWithElement:@"git tag <标签name>" explain:@"在HEAD创建一个标签"],
                       [self QStrWithElement:@"git tag <标签name> <commit id>" explain:@"在某个commit处创建标签"],
                       [self QStrWithElement:@"git tag -a <标签name> -m <注释(需加引号)>" explain:@"创建有标签信息的标签"],
                       [self QStrWithElement:@"git tag" explain:@"查看所有标签"],
                       [self QStrWithElement:@"git show <标签name>" explain:@"查看标签信息"],
                       [self QStrWithElement:@"git push origin <tagname>" explain:@"将本地标签推送到远程库"],
                       [self QStrWithElement:@"git push origin --tags" explain:@"将本地全部位推送的标签推送到远程库"],
                       [self QStrWithElement:@"git tag -d <tagname>" explain:@"删除一个本地标签"],
                       [self QStrWithElement:@"git push origin :refs/tags/<tagname>" explain:@"删除一个远程库标签"]
                       ];
    [self addStrToNoteStr:notes];
}

- (NSMutableAttributedString *)QStrWithElement:(NSString *)element explain:(NSString *)explain {
    NSString *QStr = [NSString stringWithFormat:@"%@ : %@\n\n",[NSString addQuotationMark:element],explain];
    NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithString:QStr];
    [attStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:13.0f] range:NSMakeRange(0, QStr.length)];
    [attStr addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:NSMakeRange(0, QStr.length)];
    [attStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:15.0f] range:NSMakeRange(1, element.length)];
    [attStr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(1, element.length)];
    
    return attStr;
}

- (void)addStrToNoteStr:(NSArray *)subAttStrs {
    for (NSInteger i = 0; i < subAttStrs.count; i++) {
        NSMutableAttributedString *attStr = subAttStrs[i];
        NSAttributedString *indexAttStr = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"%ld.",i + 1]];
        [self.noteAttStr appendAttributedString:indexAttStr];
        [self.noteAttStr appendAttributedString:attStr];
    }
    
    _noteTV.attributedText = _noteAttStr;
}

- (NSMutableAttributedString *)noteAttStr {
    if (!_noteAttStr) {
        _noteAttStr = [[NSMutableAttributedString alloc] init];
    }
    return _noteAttStr;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
