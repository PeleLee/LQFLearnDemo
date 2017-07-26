//
//  MultiThreadVC.m
//  LQFLearnDemo
//
//  Created by liqunfei on 2017/7/26.
//  Copyright © 2017年 LQF. All rights reserved.
//

#import "MultiThreadVC.h"

@interface MultiThreadVC ()

@end

@implementation MultiThreadVC

- (void)viewDidLoad {
    [super viewDidLoad];
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            
        });
    });
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
