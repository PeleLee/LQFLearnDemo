//
//  LQFWrLineView.m
//  LQFLearnDemo
//
//  Created by liqunfei on 2017/7/17.
//  Copyright © 2017年 LQF. All rights reserved.
//

#import "LQFWrLineView.h"
#import "LQFLineData.h"
#import "LQFLineUntil.h"
#import "UIBezierPath+Draw.h"

@interface LQFWrLineView()

@property (nonatomic, strong) CAShapeLayer *wrLineLayer;
@property (nonatomic, strong) NSMutableArray *wrPostionArray;

@end

@implementation LQFWrLineView

- (void)initLayer {
    if (self.wrLineLayer) {
        [self.wrLineLayer removeFromSuperlayer];
        self.wrLineLayer = nil;
    }
    
    if (!self.wrLineLayer) {
        self.wrLineLayer = [CAShapeLayer layer];
        self.wrLineLayer.frame = CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame));
        self.wrLineLayer.lineWidth = self.lineWidth;
        self.wrLineLayer.lineCap = kCALineCapRound;
        self.wrLineLayer.lineJoin = kCALineJoinRound;
    }
    [self.layer addSublayer:self.wrLineLayer];
}

- (void)initMaxAndMinValue {
    [self layoutIfNeeded];
    self.maxX = CGFLOAT_MIN;
    self.minY = CGFLOAT_MAX;
    
    LQFLineData *lineData = _dataArray[0];
    NSArray *lineArray = [lineData.data subarrayWithRange:NSMakeRange(_startIndex, _displayCount)];
    for (NSInteger i = 0; i < lineArray.count; i++) {
        LQFLineUntil *until = lineArray[i];
        self.minY = self.minY < until.value ? self.minY : until.value;
        self.maxY = self.maxY > until.value ? self.maxY : until.value;
    }
    
    if (self.maxY - self.minY < 0.5) {
        self.maxY += 0.5;
        self.minY += 0.5;
    }
    
    self.topMargin = 0;
    self.bottomMargin = 5;
    
    self.scaleY = (self.height - self.topMargin - self.bottomMargin) / (self.maxY - self.minY);
}

- (void)initLinesModelPosition {
    [self.wrPostionArray removeAllObjects];
    LQFLineData *lineData = _dataArray.firstObject;
    NSArray *array = [lineData.data subarrayWithRange:NSMakeRange(_startIndex, _displayCount)];
    for (NSInteger j = 0; j < array.count; j++) {
        LQFLineUntil *until = array[j];
        CGFloat xPosition = self.leftPosition + ((self.candleWidth + self.candleSpace) * j) + self.candleWidth / 2;
        CGFloat yPositon = ((self.maxY - until.value) * self.scaleY) + self.topMargin;
        LQFLineModel *model = [LQFLineModel initPosition:xPosition yPosition:yPositon color:lineData.color];
        [self.wrPostionArray addObject:model];
    }
}

- (void)drawLineLayer {
    LQFLineData *wrData = self.dataArray[0];
    UIBezierPath *wrPath = [UIBezierPath drawLine:self.wrPostionArray];
    self.wrLineLayer.path = wrPath.CGPath;
    self.wrLineLayer.strokeColor = wrData.color.CGColor;
    self.wrLineLayer.fillColor = [UIColor clearColor].CGColor;
    self.wrLineLayer.contentsScale = [UIScreen mainScreen].scale;
}

#pragma mark 绘制
- (void)stockFill {
    [self initMaxAndMinValue];
    [self initLayer];
    [self initLinesModelPosition];
    [self drawLineLayer];
}

#pragma mark setter

- (NSMutableArray *)wrPostionArray {
    if (!_wrPostionArray) {
        _wrPostionArray = [NSMutableArray array];
    }
    return _wrPostionArray;
}

@end
