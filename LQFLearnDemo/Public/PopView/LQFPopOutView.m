//
//  LQFPopOutView.m
//  LQFLearnDemo
//
//  Created by liqunfei on 2017/7/24.
//  Copyright © 2017年 LQF. All rights reserved.
//

#import "LQFPopOutView.h"
#import <WebKit/WebKit.h>

@interface LQFPopOutView()

@property (nonatomic, strong) UIView *backView;
@property (nonatomic, strong) WKWebView *webView;
@property (nonatomic, strong) UIButton *closeButton;
@property (nonatomic, strong) FBKVOController *kvoController;
@property (nonatomic, strong) UIProgressView *progressView;

@end

@implementation LQFPopOutView

#pragma mark setter

- (void)setUrlStr:(NSString *)urlStr {
    _urlStr = urlStr;
    NSURL *url = [NSURL URLWithString:urlStr];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [_webView loadRequest:request];
}

- (instancetype)init {
    if (self = [super init]) {
        self.frame = CGRectMake(0, 0, DEVICE_WIDTH, DEVICE_HEIGHT);
        
        _backView = [[UIView alloc] init];
        _backView.backgroundColor = [UIColor blackColor];
        _backView.alpha = 0.55;
        [self addSubview:_backView];
        
        _webView = [[WKWebView alloc] init];
        [self addSubview:_webView];
        
        _closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_closeButton setBackgroundImage:[UIImage imageNamed:@"delete"] forState:UIControlStateNormal];
        [_closeButton addTarget:self action:@selector(close) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_closeButton];
        
        _progressView = [[UIProgressView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.frame), 2)];
        [self addSubview:_progressView];
        
        [self addListener];
    }
    return self;
}

- (void)addListener {
    FBKVOController *KVOController = [FBKVOController controllerWithObserver:self];
    self.kvoController = KVOController;
    __weak typeof(self) this = self;
    [self.kvoController observe:self.webView keyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld block:^(id  _Nullable observer, id  _Nonnull object, NSDictionary<NSString *,id> * _Nonnull change) {
        [this.progressView setAlpha:1.0];
        [this.progressView setProgress:_webView.estimatedProgress animated:YES];
        if (this.webView.estimatedProgress >= 1.0f) {
            [this.progressView setAlpha:0];
        }
    }];
}

- (void)layoutSubviews {
    [super layoutSubviews];

    CGFloat webW = DEVICE_WIDTH * 0.9;
    CGFloat webH = DEVICE_HEIGHT * 0.85;
    CGRect webRect = CGRectMake((DEVICE_WIDTH - webW) / 2, (DEVICE_HEIGHT - webH) / 2, webW, webH);
    _backView.frame = self.bounds;
    _webView.frame = webRect;
    _closeButton.frame = CGRectMake(CGRectGetMinX(webRect) - 15, CGRectGetMinY(webRect) -15, 30, 30);
}

/*
 让超出父视图的子视图可以响应事件
 */
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    UIView *view = [super hitTest:point withEvent:event];
    if (view == nil) {
        for (UIView *subView in self.subviews) {
            CGPoint tp = [subView convertPoint:point toView:self];
            if (CGRectContainsPoint(self.bounds, tp)) {
                view = subView;
            }
        }
    }
    return view;
}

- (void)close {
    if (_dismissBlock) {
        _dismissBlock(self);
    }
}

@end
