//
//  KillWarnVC.m
//  LQFLearnDemo
//
//  Created by liqunfei on 2017/8/4.
//  Copyright © 2017年 LQF. All rights reserved.
//

#import "KillWarnVC.h"

@interface KillWarnVC ()

@end

@implementation KillWarnVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navTitle = @"警告收录及消除";

    self.quoteUrl = @"http://www.cocoachina.com/ios/20150831/13287.html";
    
    UILabel *tipsLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 120, DEVICE_WIDTH - 40, 40)];
    tipsLabel.text = @"在上方原文中搜索对应警告的关键字（电脑浏览器中打开），查看解决方案";
    tipsLabel.numberOfLines = 0;
    tipsLabel.font = [UIFont systemFontOfSize:14.0f];
    [self.view addSubview:tipsLabel];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
