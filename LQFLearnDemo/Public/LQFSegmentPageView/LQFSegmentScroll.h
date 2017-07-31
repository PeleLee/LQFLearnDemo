//
//  LQFSegmentScroll.h
//  LQFLearnDemo
//
//  Created by liqunfei on 2017/7/27.
//  Copyright © 2017年 LQF. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LQFSegmentScroll : UIScrollView
/**
 第一次进入是否加载,YES加载countLimit个页面,默认NO
 */
@property (nonatomic, assign) BOOL loadAll;
/**
 缓存页面数目,默认 -all
 */
@property (nonatomic, assign) NSInteger countLimit;
/**
 默认显示开始的位置,默认 -1
 */
@property (nonatomic, assign) NSInteger showIndex;

- (instancetype)initWithFrame:(CGRect)frame vcOrViews:(NSArray *)sources;

@end
