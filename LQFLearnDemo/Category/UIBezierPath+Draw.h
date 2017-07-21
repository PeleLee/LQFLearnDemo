//
//  UIBezierPath+Draw.h
//  LQFLearnDemo
//
//  Created by liqunfei on 2017/7/18.
//  Copyright © 2017年 LQF. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBezierPath (Draw)

/**
 绘制单个折线

 @param linesArray 单个折线数组
 @return 绘制的path
 */
+ (UIBezierPath *)drawLine:(NSMutableArray *)linesArray;

/**
 绘制多个折线

 @param linesArray 多个折线数组
 @return 绘制的path数组
 */
+ (NSMutableArray<__kindof UIBezierPath *> *)drawLines:(NSMutableArray<NSMutableArray *> *)linesArray;

/**
 绘制蜡烛图

 @param open 开盘价
 @param close 收盘价
 @param high 最高价
 @param low 最低价
 @param candleWidth 蜡烛线宽度
 @param rect 绘制区域
 @param xPosition 绘制x坐标
 @param lineWidth 直线宽度
 @return 绘制的path
 */
+ (UIBezierPath *)drawKLine:(CGFloat)open close:(CGFloat)close high:(CGFloat)high low:(CGFloat)low candleWidth:(CGFloat)candleWidth rect:(CGRect)rect xPosition:(CGFloat)xPosition lineWidth:(CGFloat)lineWidth;

@end
