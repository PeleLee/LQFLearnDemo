//
//  LQFMacdModel.m
//  SelfStudyDemo
//
//  Created by liqunfei on 2017/7/10.
//  Copyright © 2017年 LQF. All rights reserved.
//

#import "LQFMacdModel.h"

@implementation LQFMacdModel

- (id)initWithDea:(CGFloat)dea diff:(CGFloat)diff macd:(CGFloat)macd date:(NSString *)date {
    LQFMacdModel *model = [[LQFMacdModel alloc] init];
    model.dea = dea;
    model.diff = diff;
    model.macd = macd;
    model.date = date;
    return model;
}

@end
