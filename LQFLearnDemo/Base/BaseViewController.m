//
//  BaseViewController.m
//  LQFLearnDemo
//
//  Created by liqunfei on 2017/7/13.
//  Copyright © 2017年 LQF. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@property (nonatomic, strong) UIButton *quoteButton;
@property (nonatomic, strong) LQFPopOutView *popOutView;

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

- (LQFPopOutView *)popOutView {
    if (!_popOutView) {
        _popOutView = [[LQFPopOutView alloc] init];
        _popOutView.dismissBlock = ^(LQFPopOutView *popOutView) {
            [[LQFPopTool sharedInstance] closeAnimated:YES];
        };
    }
    return _popOutView;
}

- (UIButton *)quoteButton {
    if (!_quoteButton) {
        _quoteButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _quoteButton.frame = CGRectMake(0, 64, 100, 44);
        [_quoteButton setTitle:@"原文-->" forState:UIControlStateNormal];
        [_quoteButton.titleLabel setFont:[UIFont systemFontOfSize:13.0f]];
        [_quoteButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [_quoteButton addTarget:self action:@selector(showQuoteView:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_quoteButton];
    }
    return _quoteButton;
}

- (void)showQuoteView:(UIButton *)button {
    [[LQFPopTool sharedInstance] popView:self.popOutView animated:YES];
}

- (void)setQuoteUrl:(NSString *)quoteUrl {
    [self.view addSubview:self.quoteButton];
    self.popOutView.urlStr = quoteUrl;
}

@end
