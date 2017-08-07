//
//  BaseViewController.m
//  LQFLearnDemo
//
//  Created by liqunfei on 2017/7/13.
//  Copyright © 2017年 LQF. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@property (nonatomic, strong) LQFPopOutView *popOutView;
@property (nonatomic, strong) UIView *customNavbar;
@property (nonatomic, strong) UIButton *backButton;
@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation BaseViewController

#pragma mark - set
- (void)setHiddenBackBtn:(BOOL)hiddenBackBtn {
    _hiddenBackBtn = hiddenBackBtn;
    _backButton.hidden = hiddenBackBtn;
}

- (void)setNavAlpha:(CGFloat)navAlpha {
    _customNavbar.alpha = navAlpha;
}

- (void)setNavTitle:(NSString *)navTitle {
    _titleLabel.text = navTitle;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //侧滑返回
    self.navigationController.interactivePopGestureRecognizer.delegate = (id)self;
    self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    
    self.navigationController.navigationBarHidden = YES;
    [self customNavigationBar];
}

#pragma mark - 自定义导航栏
- (void)customNavigationBar {
    _customNavbar = [[UIView alloc] initWithFrame:CGRectMake(0, 0, DEVICE_WIDTH, 64)];
    UIImageView *navImageView = [[UIImageView alloc] initWithFrame:_customNavbar.bounds];
    navImageView.image = ImageNamed(@"navgationBack");
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
    [_customNavbar addSubview:_titleLabel];
}

- (void)back:(UIButton *)button {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - 弹出webView

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
        [_quoteButton setTitle:@"☞ ☞ 原文" forState:UIControlStateNormal];
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
