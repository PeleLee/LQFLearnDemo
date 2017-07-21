//
//  LQFMacdView.h
//  LQFLearnDemo
//
//  Created by liqunfei on 2017/7/17.
//  Copyright © 2017年 LQF. All rights reserved.
//

#import "LQFBaseChartView.h"
#import "LQFMacdModel.h"

@interface LQFMacdView : LQFBaseChartView

@property (nonatomic,strong) NSMutableArray <__kindof LQFMacdModel*> *dataArray;

@property (nonatomic, assign) CGFloat   leftPosition;
@property (nonatomic, assign) NSInteger startIndex;
@property (nonatomic, assign) NSInteger displayCount;
@property (nonatomic, assign) CGFloat   candleWidth;
@property (nonatomic, assign) CGFloat   candleSpace;

- (void)stockFill;

@end
