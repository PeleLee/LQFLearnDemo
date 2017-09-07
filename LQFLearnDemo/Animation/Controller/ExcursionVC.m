//
//  ExcursionVC.m
//  LQFLearnDemo
//
//  Created by liqunfei on 2017/9/6.
//  Copyright © 2017年 LQF. All rights reserved.
//

#import "ExcursionVC.h"
#import "ExcursionAnimationView.h"

@interface ExcursionVC ()

@property (nonatomic, strong) ExcursionAnimationView *animatedImagesView;

@end

@implementation ExcursionVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navTitle = @"背景动图";
    
    self.animatedImagesView = [[ExcursionAnimationView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:self.animatedImagesView];
    [self.view sendSubviewToBack:self.animatedImagesView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.animatedImagesView startAnimating];
}

- (void)viewDidDisappear:(BOOL)animated {
    [self.animatedImagesView stopAnimating];
    self.animatedImagesView.alpha = 0;
    [self.animatedImagesView removeFromSuperview];
    [super viewDidDisappear:animated];
}

@end
