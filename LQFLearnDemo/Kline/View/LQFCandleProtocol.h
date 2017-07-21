//
//  LQFCandleProtocol.h
//  SelfStudyDemo
//
//  Created by liqunfei on 2017/7/6.
//  Copyright © 2017年 LQF. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol LQFCandleProtocol <NSObject>

@optional

/**
 取得当前屏幕内模型数组的开始下标以及个数

 @param leftPostion 当前屏幕最右边的位置
 @param index 下标
 @param count 个数
 */
- (void)displayScreenleftPostion:(CGFloat)leftPostion startIndex:(NSInteger)index count:(NSInteger)count;


/**
 长按手势获得当前k线下标以及模型

 @param kLineModeIndex 当前k线在可视范围数组的位置下标
 @param kLineModel k线模型
 */
- (void)longPressCandleViewWithIndex:(NSInteger)kLineModeIndex kLineModel:(LQFCandleModel *)kLineModel;

/**
 返回当前屏幕最后一根k线模型

 @param kLineModel k线模型
 */
- (void)displayLastModel:(LQFCandleModel *)kLineModel;

/**
 加载更多数据
 */
- (void)displayMoreData;

@end
