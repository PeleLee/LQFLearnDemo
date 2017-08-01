//
//  LQFSegmentScroll.h
//  LQFLearnDemo
//
//  Created by liqunfei on 2017/7/27.
//  Copyright © 2017年 LQF. All rights reserved.
//

#import <UIKit/UIKit.h>

//添加子视图的时机
typedef enum : NSUInteger {
    SegmentAddNormal,//滑动或者动画结束
    SegmentAddScale//根据设置滑动百分比添加0-1
} SegmentAddTiming;

@protocol LQFSegmentScrollDelegate <NSObject>
/**
 滑动结束

 @param index index
 */
- (void)scrollEndIndex:(NSInteger)index;
/**
 动画结束

 @param index index
 */
- (void)animationEndIndex:(NSInteger)index;
/**
 偏移的百分比

 @param scale scale
 */
- (void)scrollOffsetScale:(CGFloat)scale;

@end

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

@property (nonatomic, weak) id<LQFSegmentScrollDelegate> segDelegate;

@property (nonatomic, copy) void (^scrollEnd)(NSInteger index);
@property (nonatomic, copy) void (^animationEnd)(NSInteger index);
@property (nonatomic, copy) void (^offSetScale)(CGFloat scale);

- (instancetype)initWithFrame:(CGRect)frame vcOrViews:(NSArray *)sources;

/**
 添加时机,默认动画或者滑动结束添加
 */
@property (nonatomic, assign) SegmentAddTiming addTiming;
/**
 SegmentAddScale 时使用
 */
@property (nonatomic, assign) CGFloat addScale;

/**
 创建之后,初始化
 */
- (void)createView;

@end
