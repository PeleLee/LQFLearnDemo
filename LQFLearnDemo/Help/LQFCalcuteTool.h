//
//  LQFCalcuteTool.h
//  SelfStudyDemo
//
//  Created by liqunfei on 2017/7/10.
//  Copyright © 2017年 LQF. All rights reserved.
//

#import "ta_libc.h"
#import "LQFLineData.h"
#import "LQFLineUntil.h"

LQFLineData *computeMAData(NSArray *items,int period);
NSMutableArray *computeMACDData(NSArray * items);
NSMutableArray *computeKDJData(NSArray *items);
NSMutableArray *computeWRData(NSArray *items,int period);
