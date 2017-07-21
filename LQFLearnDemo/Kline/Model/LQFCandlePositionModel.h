//
//  LQFCandlePositionModel.h
//  LQFLearnDemo
//
//  Created by liqunfei on 2017/7/17.
//  Copyright © 2017年 LQF. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LQFCandlePositionModel : NSObject

/**
 开盘点
 */
@property (nonatomic, assign) CGPoint openPoint;

/**
 收盘点
 */
@property (nonatomic, assign) CGPoint closePoint;

/**
 最高点
 */
@property (nonatomic, assign) CGPoint hightPoint;

/**
 最低点
 */
@property (nonatomic, assign) CGPoint lowPoint;

/**
 日期
 */
@property (nonatomic, copy) NSString *date;

@property (nonatomic, assign) BOOL isDrawDate;

+ (instancetype)modelWithOpen:(CGPoint)openPoint close:(CGPoint)closePoint hight:(CGPoint)highPoint low:(CGPoint)lowPoint date:(NSString *)date;

@end
