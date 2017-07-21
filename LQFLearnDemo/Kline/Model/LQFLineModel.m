//
//  LQFLineModel.m
//  LQFLearnDemo
//
//  Created by liqunfei on 2017/7/14.
//  Copyright © 2017年 LQF. All rights reserved.
//

#import "LQFLineModel.h"

@implementation LQFLineModel

+ (instancetype)initPosition:(CGFloat)xPosition yPosition:(CGFloat)yPosition color:(UIColor *)color {
    LQFLineModel *model = [[LQFLineModel alloc] init];
    model.xPosition = xPosition;
    model.yPosition = yPosition;
    model.lineColor = color;
    return model;
}

@end
