//
//  ThreadTestVC.m
//  LQFLearnDemo
//
//  Created by liqunfei on 2017/9/1.
//  Copyright © 2017年 LQF. All rights reserved.
//

#import "ThreadTestVC.h"
#import "ThreadTestView.h"

@interface ThreadTestVC ()

@end

@implementation ThreadTestVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navTitle = @"多线程测试";
    
    [self test1];
}

- (void)test1 {
    ThreadTestView *view1 = [ThreadTestView new];
    [self.view addSubview:view1];
    
    [view1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(64);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(200);
    }];
    
    [view1 begin];
}

@end
