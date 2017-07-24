//
//  LQFPopOutView.h
//  LQFLearnDemo
//
//  Created by liqunfei on 2017/7/24.
//  Copyright © 2017年 LQF. All rights reserved.
//
//  参考:http://www.jianshu.com/p/45fb85193ca2

#import <UIKit/UIKit.h>

@class LQFPopOutView;

typedef void(^PopOutViewDismissBlock)(LQFPopOutView *popOutView);

@interface LQFPopOutView : UIView

@property (nonatomic, copy) PopOutViewDismissBlock dismissBlock;
@property (nonatomic, strong) NSString *urlStr;

@end
