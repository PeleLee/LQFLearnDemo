//
//  CustomButtonVC.m
//  LQFLearnDemo
//
//  Created by liqunfei on 2017/8/22.
//  Copyright © 2017年 LQF. All rights reserved.
//

#import "CustomButtonVC.h"
#import "LQFButton.h"

@interface CustomButtonVC ()

@property (nonatomic, assign) CGFloat contentHeight;

@end

@implementation CustomButtonVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navTitle = @"图文按钮";
    self.quoteUrl = @"https://github.com/HelloYeah/YLButton";
    
    [self buildUI];
}

- (void)buildUI {
    _contentHeight = 65;
    CGFloat gap = 30;
    CGFloat buttonW = (DEVICE_HEIGHT - 65 - gap*5) / 4;
    
    for (NSInteger i = 0; i < 4; i++) {
        
        LQFButton *button = [LQFButton buttonWithType:UIButtonTypeCustom];
        [self.view addSubview:button];
        
        _contentHeight += gap;
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(_contentHeight);
            make.centerX.equalTo(self.view);
            make.width.mas_equalTo(buttonW);
            make.height.mas_equalTo(buttonW);
        }];
        
        [button setBackgroundColor:[UIColor lightGrayColor]];
        [button setImage:ImageNamed(@"rocket") forState:UIControlStateNormal];
        button.imageView.contentMode = UIViewContentModeScaleAspectFit;
        [button setTitle:@"按钮" forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button.titleLabel setFont:SystemFont(13)];
        [button.titleLabel setTextAlignment:NSTextAlignmentCenter];
        
        CGRect titleRect = CGRectZero;
        CGRect imageRect = CGRectZero;
        if (i == 0) {
            //title在上，image在下
            titleRect = CGRectMake(0, 0, buttonW, buttonW * 0.2);
            imageRect = CGRectMake(0, buttonW * 0.2, buttonW, buttonW * 0.8);
        }
        else if (i == 1) {
            //title在下，image在上
            titleRect = CGRectMake(0, buttonW * 0.8, buttonW, buttonW * 0.2);
            imageRect = CGRectMake(0, 0, buttonW, buttonW * 0.8);
        }
        else if (i == 2) {
            //title在左，image在右
            titleRect = CGRectMake(0, 0, buttonW * 0.3, buttonW);
            imageRect = CGRectMake(buttonW * 0.3, 0, buttonW * 0.7, buttonW);
        }
        else if (i == 3) {
            //title在右，image在左
            titleRect = CGRectMake(buttonW * 0.7, 0, buttonW * 0.3, buttonW);
            imageRect = CGRectMake(0, 0, buttonW * 0.7, buttonW);
        }
        
        button.titleRect = titleRect;
        button.imageRect = imageRect;
        
        _contentHeight += buttonW;
    }
}

@end
