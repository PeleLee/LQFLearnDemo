//
//  LQFWrLineView.h
//  LQFLearnDemo
//
//  Created by liqunfei on 2017/7/17.
//  Copyright © 2017年 LQF. All rights reserved.
//

#import "LQFBaseChartView.h"

@interface LQFWrLineView : LQFBaseChartView

@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, assign) CGFloat leftPosition;
@property (nonatomic, assign) CGFloat candleWidth;
@property (nonatomic, assign) CGFloat candleSpace;
@property (nonatomic, assign) NSInteger startIndex;
@property (nonatomic, assign) NSInteger displayCount;

- (void)stockFill;

@end
