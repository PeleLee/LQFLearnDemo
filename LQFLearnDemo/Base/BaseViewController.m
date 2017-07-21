//
//  BaseViewController.m
//  LQFLearnDemo
//
//  Created by liqunfei on 2017/7/13.
//  Copyright © 2017年 LQF. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

#pragma mark - set
- (void)setNavAlpha:(CGFloat)navAlpha {
    self.navigationController.navigationBar.alpha = navAlpha;
}

- (void)setNavTitle:(NSString *)navTitle {
    self.navigationController.navigationItem.title = navTitle;
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
