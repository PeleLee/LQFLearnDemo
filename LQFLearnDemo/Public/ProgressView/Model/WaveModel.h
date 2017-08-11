//
//  WaveModel.h
//  LQFLearnDemo
//
//  Created by liqunfei on 2017/8/11.
//  Copyright © 2017年 LQF. All rights reserved.
//

#import "BaseModel.h"

@interface WaveModel : BaseModel

/**
 振幅（y = asin(wx+φ) + k）
 */
@property (nonatomic, assign) CGFloat amplitude;
/**
 周期
 */
@property (nonatomic, assign) CGFloat cycle;
/**
 两个水波水平之间的偏移
 */
@property (nonatomic, assign) CGFloat distance_h;
/**
 两个水波垂直方向的偏移
 */
@property (nonatomic, assign) CGFloat distanch_v;
/**
 水波速率
 */
@property (nonatomic, assign) CGFloat scale;
/**
 波峰所在位置的y坐标
 */
@property (nonatomic, assign) CGFloat offsety;
/**
 移动的距离,配合速率设置
 */
@property (nonatomic, assign) CGFloat move_width;
/**
 偏移
 */
@property (nonatomic, assign) CGFloat offsetx;
/**
 上升的速度
 */
@property (nonatomic, assign) CGFloat offsety_scale;

@end
