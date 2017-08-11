//
//  XcodeGitVC.m
//  LQFLearnDemo
//
//  Created by liqunfei on 2017/8/9.
//  Copyright © 2017年 LQF. All rights reserved.
//

#import "XcodeGitVC.h"
#import <WebKit/WebKit.h>
#import "LQFProgressView.h"

@interface XcodeGitVC ()

@property (nonatomic, strong) WKWebView *webView;
@property (nonatomic, strong) FBKVOController *kvoController;
@property (nonatomic, strong) LQFProgressView *progressView;

@end

@implementation XcodeGitVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navTitle = @"Xcode - SourceControl";
    
    [self buidlWebView];
    
    [self buildProgress];
}

- (void)buildProgress {
    _progressView = [LQFProgressView new];
    [self.view addSubview:_progressView];
    
    [_progressView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.centerY.equalTo(self.view);
        make.width.mas_equalTo(150);
        make.height.mas_equalTo(150);
    }];
    
    _progressView.style = ProgressStyle_Install;
    _progressView.progress = 0;
}

- (void)buidlWebView {
    _webView = [WKWebView new];
    [self.view addSubview:_webView];
    
    [_webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(64);
        make.trailing.mas_equalTo(0);
        make.leading.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
    }];
    
    [self addWebviewLisener];
//     https://stackoverflow.com/
    NSURL *url = [NSURL URLWithString:@"http://www.cocoachina.com/ios/20140524/8536.html"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [_webView loadRequest:request];
}

- (void)addWebviewLisener {
    FBKVOController *KVOController = [FBKVOController controllerWithObserver:self];
    self.kvoController = KVOController;
    __weak typeof(self) this = self;
    
    [self.kvoController observe:self.webView keyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld block:^(id  _Nullable observer, id  _Nonnull object, NSDictionary<NSString *,id> * _Nonnull change) {
        this.progressView.progress = this.webView.estimatedProgress;
    }];
}

@end
