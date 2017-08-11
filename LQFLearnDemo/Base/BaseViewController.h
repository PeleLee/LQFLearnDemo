//
//  BaseViewController.h
//  LQFLearnDemo
//
//  Created by liqunfei on 2017/7/13.
//  Copyright © 2017年 LQF. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseViewController : UIViewController

@property (nonatomic, assign) CGFloat navAlpha;

@property (nonatomic, strong) NSString *navTitle;

@property (nonatomic, strong) UIButton *quoteButton;

/**
 是否隐藏返回按钮
 */
@property (nonatomic, assign) BOOL hiddenBackBtn;

/**
 原文地址
 */
@property (nonatomic, strong) NSString *quoteUrl;

@property (nonatomic, strong) NSString *showUrl;

@end
