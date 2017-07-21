//
//  LQFCandleChartView.h
//  SelfStudyDemo
//
//  Created by liqunfei on 2017/6/30.
//  Copyright © 2017年 LQF. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LQFCandleProtocol.h"
#import "LQFBaseChartView.h"

@interface LQFCandleChartView : LQFBaseChartView

/**
 数据源数组 在调用绘制方法之前设置。
 */
@property (nonatomic,strong) NSMutableArray *dataArray;

/**
 当前屏幕范围内显示的k线模型数组
 */
@property (nonatomic,strong) NSMutableArray *currentDisplayArray;

/**
 当前屏幕范围内显示的k线位置数组
 */
@property (nonatomic,strong) NSMutableArray *currentPositionArray;

/**
 可视区域显示多少根k线
 */
@property (nonatomic,assign) NSInteger displayCount;

/**
 k线之间的距离
 */
@property (nonatomic,assign) CGFloat candleSpace;

/**
 k线的宽度 根据每页k线的根数和k线之间的距离动态计算得出
 */
@property (nonatomic,assign) CGFloat candleWidth;

/**
 k线最小高度
 */
@property (nonatomic,assign) CGFloat minHeight;

/**
 当前屏幕范围内绘制起点位置
 */
@property (nonatomic,assign) CGFloat leftPostion;

/**
 当前绘制的起始下标
 */
@property (nonatomic,assign) NSInteger currentStartIndex;

/**
 滑到最右侧的偏移量
 */
@property (nonatomic,assign) CGFloat previousOffsetX;

/**
 当前偏移量
 */
@property (nonatomic,assign) CGFloat contentOffset;

@property (nonatomic,assign) BOOL kvoEnable;

/**
 长按手势返回对应model的相对位置
 
 @param xPostion 手指在屏幕的位置
 @return 距离手指位置最近的model位置
 */
- (CGPoint)getLongPressModelPostionWithXPostion:(CGFloat)xPostion;

- (void)stockFill;
- (void)calcuteCandleWidth;
- (void)updateWidth;
- (void)drawKLine;

@property (nonatomic,weak) id <LQFCandleProtocol> delegate;

@end
