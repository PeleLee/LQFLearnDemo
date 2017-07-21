//
//  LQFCandlePositionModel.m
//  LQFLearnDemo
//
//  Created by liqunfei on 2017/7/17.
//  Copyright © 2017年 LQF. All rights reserved.
//

#import "LQFCandlePositionModel.h"

@implementation LQFCandlePositionModel

+ (instancetype)modelWithOpen:(CGPoint)openPoint close:(CGPoint)closePoint hight:(CGPoint)highPoint low:(CGPoint)lowPoint date:(NSString *)date {
    LQFCandlePositionModel *candleModel = [LQFCandlePositionModel new];
    candleModel.openPoint = openPoint;
    candleModel.closePoint = closePoint;
    candleModel.hightPoint = highPoint;
    candleModel.lowPoint = lowPoint;
    candleModel.date = date;
    return candleModel;
}

@end
