//
//  UIBezierPath+Draw.m
//  LQFLearnDemo
//
//  Created by liqunfei on 2017/7/18.
//  Copyright © 2017年 LQF. All rights reserved.
//

#import "UIBezierPath+Draw.h"

@implementation UIBezierPath (Draw)

+ (UIBezierPath *)drawLine:(NSMutableArray *)linesArray {
    UIBezierPath *path = [UIBezierPath bezierPath];
    [linesArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        LQFLineModel *model = (LQFLineModel *)obj;
        if (idx == 0) {
            [path moveToPoint:CGPointMake(model.xPosition, model.yPosition)];
        }
        
        else {
            [path addLineToPoint:CGPointMake(model.xPosition, model.yPosition)];
        }
    }];
    return path;
}

+ (NSMutableArray<__kindof UIBezierPath *> *)drawLines:(NSMutableArray<NSMutableArray *> *)linesArray {
    NSAssert(0 != linesArray.count && NULL != linesArray, @"传入的数组为nil,打印结果---->>%@",linesArray);
    
    NSMutableArray *resultArray = [NSMutableArray array];
    for (NSMutableArray *lineArray in linesArray) {
        UIBezierPath *path = [UIBezierPath drawLine:lineArray];
        [resultArray addObject:path];
    }
    return resultArray;
}

+ (UIBezierPath *)drawKLine:(CGFloat)open close:(CGFloat)close high:(CGFloat)high low:(CGFloat)low candleWidth:(CGFloat)candleWidth rect:(CGRect)rect xPosition:(CGFloat)xPosition lineWidth:(CGFloat)lineWidth {
    UIBezierPath *candlePath = [UIBezierPath bezierPathWithRect:rect];
    candlePath.lineWidth = lineWidth;
    [candlePath moveToPoint:CGPointMake(xPosition + (candleWidth / 2) - (lineWidth / 2) , high)];
    [candlePath addLineToPoint:CGPointMake(xPosition + (candleWidth / 2) - (lineWidth / 2), low)];
    return candlePath;
}

@end
