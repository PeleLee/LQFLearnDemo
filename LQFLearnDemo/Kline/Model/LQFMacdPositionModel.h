//
//  LQFMacdPositionModel.h
//  LQFLearnDemo
//
//  Created by liqunfei on 2017/7/17.
//  Copyright © 2017年 LQF. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LQFMacdPositionModel : NSObject

@property (nonatomic, assign) CGPoint startPoint;
@property (nonatomic, assign) CGPoint endPoint;

+ (instancetype)initPosition:(CGPoint)startPoint endPoint:(CGPoint)endPoint;

@end
