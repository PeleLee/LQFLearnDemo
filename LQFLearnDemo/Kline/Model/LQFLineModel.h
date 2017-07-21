//
//  LQFLineModel.h
//  LQFLearnDemo
//
//  Created by liqunfei on 2017/7/14.
//  Copyright © 2017年 LQF. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LQFLineModel : NSObject

@property (nonatomic, assign) CGFloat xPosition;
@property (nonatomic, assign) CGFloat yPosition;
@property (nonatomic, strong) UIColor *lineColor;

+ (instancetype)initPosition:(CGFloat)xPosition yPosition:(CGFloat)yPosition color:(UIColor *)color;

@end
