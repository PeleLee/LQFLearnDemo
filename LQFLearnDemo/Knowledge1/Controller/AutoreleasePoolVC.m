//
//  AutoreleasePoolVC.m
//  LQFLearnDemo
//
//  Created by liqunfei on 2017/7/19.
//  Copyright © 2017年 LQF. All rights reserved.
//

#import "AutoreleasePoolVC.h"
#import <WebKit/WebKit.h>
#import "KVOController.h"

__weak NSString *string_weak_ = nil;

@interface AutoreleasePoolVC ()<WKUIDelegate,WKNavigationDelegate>

@property (nonatomic, strong) WKWebView *webView;
@property (nonatomic, strong) UIProgressView *progressView;
@property (nonatomic, strong) FBKVOController *kvoController;

@end

@implementation AutoreleasePoolVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navTitle = @"AutoreleasePool";
    self.view.backgroundColor = [UIColor whiteColor];
    
    if (self.type == 1) {
        //Scene 1
        NSString *string = [NSString stringWithFormat:@"autoreleasePool"];
        string_weak_ = string;
    }
    else if (self.type == 2) {
        //Scene 2
        @autoreleasepool {
            NSString *string = [NSString stringWithFormat:@"autoreleasePool"];
            string_weak_ = string;
        }
    }
    else if (self.type == 3) {
        //Scene 3
        NSString *string = nil;
        @autoreleasepool {
            string = [NSString stringWithFormat:@"autoreleasePool"];
            string_weak_ = string;
        }
    }
    
    NSLog(@"string didLoad: %@",string_weak_);
    
    [self showWebView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    NSLog(@"string willAppear: %@",string_weak_);
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    NSLog(@"string didAppear: %@",string_weak_);
}

- (void)showWebView {
    _progressView = [[UIProgressView alloc] initWithFrame:CGRectMake(0, 64, DEVICE_WIDTH, 2)];
    [_progressView setProgressTintColor:[UIColor yellowColor]];
    [self.view addSubview:_progressView];
    
    _webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 66, DEVICE_WIDTH, DEVICE_HEIGHT - 66)];
    _webView.UIDelegate = self;
    _webView.navigationDelegate = self;
    
    NSString *urlStr = @"http://www.cocoachina.com/ios/20150610/12093.html";
    NSURL *url = [NSURL URLWithString:urlStr];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    
    [self.view addSubview:_webView];
    [_webView loadRequest:request];
    
    [self addListener];
}

- (void)addListener {
    FBKVOController *KVOController = [FBKVOController controllerWithObserver:self];
    self.kvoController = KVOController;
    __weak typeof(self) this = self;
    [self.kvoController observe:self.webView keyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld block:^(id  _Nullable observer, id  _Nonnull object, NSDictionary<NSString *,id> * _Nonnull change) {
        [this.progressView setAlpha:1.0f];
        [this.progressView setProgress:_webView.estimatedProgress animated:YES];
        if (this.webView.estimatedProgress >= 1.0f) {
            [this.progressView setAlpha:0.0f];
        }
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
