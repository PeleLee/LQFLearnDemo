//
//  LQFMacdPositionModel.m
//  LQFLearnDemo
//
//  Created by liqunfei on 2017/7/17.
//  Copyright © 2017年 LQF. All rights reserved.
//

#import "LQFMacdPositionModel.h"

@implementation LQFMacdPositionModel

+ (instancetype)initPosition:(CGPoint)startPoint endPoint:(CGPoint)endPoint {
    LQFMacdPositionModel *model = [[LQFMacdPositionModel alloc] init];
    model.startPoint = startPoint;
    model.endPoint = endPoint;
    return model;
}

@end
