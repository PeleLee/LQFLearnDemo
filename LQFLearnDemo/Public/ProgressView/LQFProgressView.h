//
//  LQFProgressView.h
//  LQFLearnDemo
//
//  Created by liqunfei on 2017/8/9.
//  Copyright © 2017年 LQF. All rights reserved.
//  http://blog.csdn.net/hero_wqb/article/details/60143077

#import <UIKit/UIKit.h>
#import "WaveModel.h"

typedef enum : NSUInteger {
    ProgressStyle_Wave,
    ProgressStyle_Circle,
    ProgressStyle_Install
} ProgressStyle;

@interface LQFProgressView : UIView

/**
 风格
 */
@property (nonatomic, assign) ProgressStyle style;

/**
 进度
 */
@property (nonatomic, assign) CGFloat progress;

@end
