//
//  RuntimeNavBarSetVC.m
//  LQFLearnDemo
//
//  Created by liqunfei on 2017/9/20.
//  Copyright © 2017年 LQF. All rights reserved.
//

#import "RuntimeNavBarSetVC.h"
#import "WRNavigationBar.h"

@interface RuntimeNavBarSetVC ()

@property (nonatomic, strong) UIScrollView *myScrollView;

@end

@implementation RuntimeNavBarSetVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.custemBarHidden = YES;
    self.navigationController.navigationBarHidden = NO;
    self.title = @"runtime导航栏";
    [self buildUI];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.navigationController.navigationBarHidden = YES;
    self.custemBarHidden = NO;
}

- (UIScrollView *)myScrollView {
    if (!_myScrollView) {
        _myScrollView = [UIScrollView new];
        [self.view addSubview:_myScrollView];
        
        [_myScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.view).mas_offset(64);
            make.left.bottom.right.equalTo(self.view);
        }];
    }
    return _myScrollView;
}

- (void)buildUI {
    NSArray *titles = @[@"appearance setTintColor(无效，需在Appdelegate中设置才有效)",
                        @"appearance setBarTintColor(无效)",
                        @"appearance setBackgroundColor(无效)",
                        @"navigationBar setBarTintColor(有效,会被图片挡)",
                        @"navigationBar setBackgroundColor(有效)",
                        @"navigationBar setTintColor(有效)",
                        @"navigationBar setBackgroundImage(有效)",
                        @"appearance setBackgroundImage(无效)",
                        @"navigationBar setTitleTextAttributes(有效)",
                        @"----- 以下为runtime实现 -----",
                        @"UIColor wr_setDefaultNavBarTintColor(需在Appdelegate中设置才有效)",
                        @"UIColor wr_setDefaultNavBarBarTintColor(需在Appdelegate中设置才有效)",
                        @"self wr_setNavBarBackgroundImage(无效)",
                        @"self wr_setNavBarBarTintColor(无效)"];
    
    for (NSInteger i = 0; i < titles.count; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setFrame:CGRectMake(20, 40*i, DEVICE_WIDTH - 40, 40)];
        [button setTitle:titles[i] forState:UIControlStateNormal];
        [button setTitleColor:MyBlue forState:UIControlStateNormal];
        [button addTarget:self action:@selector(style:) forControlEvents:UIControlEventTouchUpInside];
        [button setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
        [button.titleLabel setFont:[UIFont systemFontOfSize:13]];
        [button.titleLabel setAdjustsFontSizeToFitWidth:YES];
        button.tag = 1000 + i;
        [self.myScrollView addSubview:button];
        
        if (i == titles.count - 1) {
            [self.myScrollView setContentSize:CGSizeMake(DEVICE_WIDTH,
                                                         CGRectGetMaxY(button.frame))];
        }
    }
}

- (void)style:(UIButton *)button {
    if (button.tag == 1000) {
        [[UINavigationBar appearance] setTintColor:MyBlue];
    }
    else if (button.tag == 1001) {
        [[UINavigationBar appearance] setBarTintColor:[UIColor yellowColor]];
    }
    else if (button.tag == 1002) {
        [[UINavigationBar appearance] setBackgroundColor:[UIColor orangeColor]];
    }
    else if (button.tag == 1003) {
        [self.navigationController.navigationBar setBackgroundImage:ImageNamed(@"") forBarMetrics:UIBarMetricsDefault];
        [self.navigationController.navigationBar setBarTintColor:MyBlue];
    }
    else if (button.tag == 1004) {
        //使用WRNavigationBar的话会失效
        [self.navigationController.navigationBar setBackgroundColor:[UIColor yellowColor]];
    }
    else if (button.tag == 1005) {
        [self.navigationController.navigationBar setTintColor:[UIColor yellowColor]];
    }
    else if (button.tag == 1006) {
        [self.navigationController.navigationBar setBackgroundImage:ImageNamed(@"navgationBackground") forBarMetrics:UIBarMetricsDefault];
    }
    else if (button.tag == 1007) {
        [[UINavigationBar appearance] setBackgroundImage:ImageNamed(@"Sun") forBarMetrics:UIBarMetricsDefault];
    }
    else if (button.tag == 1008) {
        [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:MyBlue,NSFontAttributeName:[UIFont systemFontOfSize:13]}];
    }
    else if (button.tag == 1010) {
        [UIColor wr_setDefaultNavBarTintColor:[UIColor redColor]];
    }
    else if (button.tag == 1011) {
        [UIColor wr_setDefaultNavBarBarTintColor:[UIColor orangeColor]];
    }
    else if (button.tag == 1012) {
        [self wr_setNavBarBackgroundImage:ImageNamed(@"rocket")];
    }
    else if (button.tag == 1013) {
        [self wr_setNavBarBarTintColor:[UIColor orangeColor]];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
