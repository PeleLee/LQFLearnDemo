//
//  LQFKdjLineView.m
//  LQFLearnDemo
//
//  Created by liqunfei on 2017/7/17.
//  Copyright © 2017年 LQF. All rights reserved.
//

#import "LQFKdjLineView.h"
#import "LQFLineData.h"
#import "LQFLineUntil.h"
#import "UIBezierPath+Draw.h"

@interface LQFKdjLineView()

@property (nonatomic, strong) CAShapeLayer *kLineLayer;
@property (nonatomic, strong) CAShapeLayer *dLineLayer;
@property (nonatomic, strong) CAShapeLayer *jLineLayer;
@property (nonatomic, strong) NSMutableArray *kPostionArray;
@property (nonatomic, strong) NSMutableArray *dPostionArray;
@property (nonatomic, strong) NSMutableArray *jPostionArray;

@end

@implementation LQFKdjLineView

#pragma layer相关

- (void)initLayer {
    if (self.kLineLayer) {
        [self.kLineLayer removeFromSuperlayer];
        self.kLineLayer = nil;
    }
    
    if (!self.kLineLayer) {
        self.kLineLayer = [CAShapeLayer layer];
        self.kLineLayer.frame = CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame));
        self.kLineLayer.lineWidth = self.lineWidth;
        self.kLineLayer.lineCap = kCALineCapRound;
        self.kLineLayer.lineJoin = kCALineJoinRound;
    }
    [self.layer addSublayer:self.kLineLayer];
    
    if (self.dLineLayer) {
        [self.dLineLayer removeFromSuperlayer];
        self.dLineLayer = nil;
    }
    
    if (!self.dLineLayer) {
        self.dLineLayer = [CAShapeLayer layer];
        self.dLineLayer.frame = CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame));
        self.dLineLayer.lineWidth = self.lineWidth;
        self.dLineLayer.lineCap = kCALineCapRound;
        self.dLineLayer.lineJoin = kCALineJoinRound;
    }
    
    [self.layer addSublayer:self.dLineLayer];
    
    if (self.jLineLayer) {
        [self.jLineLayer removeFromSuperlayer];
        self.jLineLayer = nil;
    }
    
    if (!self.jLineLayer) {
        self.jLineLayer = [CAShapeLayer layer];
        self.jLineLayer.frame = CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame));
        self.jLineLayer.lineWidth = self.lineWidth;
        self.jLineLayer.lineCap = kCALineCapRound;
        self.jLineLayer.lineJoin = kCALineJoinRound;
    }
    [self.layer addSublayer:self.jLineLayer];
}

- (void)initMaxAndMinValue {
    [self layoutIfNeeded];
    self.maxY = CGFLOAT_MIN;
    self.minY = CGFLOAT_MAX;
    
    for (LQFLineData *lineData in _dataArray) {
        NSArray *array = [lineData.data subarrayWithRange:NSMakeRange(_startIndex, _displayCount)];
        for (NSInteger j = 0; j < array.count; j++) {
            LQFLineUntil *until = array[j];
            self.minY = self.minY < until.value ? self.minY : until.value;
            self.maxY = self.maxY > until.value ? self.maxY : until.value;
        }
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
    [self.kPostionArray removeAllObjects];
    [self.dPostionArray removeAllObjects];
    [self.jPostionArray removeAllObjects];
    
    for (LQFLineData *lineData in _dataArray) {
        NSArray *array = [lineData.data subarrayWithRange:NSMakeRange(_startIndex, _displayCount)];
        for (NSInteger j = 0; j < array.count; j++) {
            LQFLineUntil *until = array[j];
            CGFloat xPosition = self.leftPosition + ((self.candleWidth + self.candleSpace) * j) + self.candleWidth/2;
            CGFloat yPosition = ((self.maxY - until.value) * self.scaleY) + self.topMargin;
            LQFLineModel *model = [LQFLineModel initPosition:xPosition yPosition:yPosition color:lineData.color];
            if ([lineData.title isEqualToString:@"K"]) {
                [self.kPostionArray addObject:model];
            }
            
            else if ([lineData.title isEqualToString:@"D"]) {
                [self.dPostionArray addObject:model];
            }
            
            else if ([lineData.title isEqualToString:@"J"]) {
                [self.jPostionArray addObject:model];
            }
        }
    }
}

- (void)drawLineLayer {
    LQFLineData *kData = self.dataArray[0];
    UIBezierPath *kPath = [UIBezierPath drawLine:self.kPostionArray];
    self.kLineLayer.path = kPath.CGPath;
    self.kLineLayer.strokeColor = kData.color.CGColor;
    self.kLineLayer.fillColor = [UIColor clearColor].CGColor;
    self.kLineLayer.contentsScale = [UIScreen mainScreen].scale;
    
    LQFLineData *dData = self.dataArray[1];
    UIBezierPath *dPath = [UIBezierPath drawLine:self.dPostionArray];
    self.dLineLayer.path = dPath.CGPath;
    self.dLineLayer.strokeColor = dData.color.CGColor;
    self.dLineLayer.fillColor = [UIColor clearColor].CGColor;
    self.dLineLayer.contentsScale = [UIScreen mainScreen].scale;
    
    LQFLineData *jData = self.dataArray[2];
    UIBezierPath *jPath = [UIBezierPath drawLine:self.jPostionArray];
    self.jLineLayer.path = jPath.CGPath;
    self.jLineLayer.strokeColor = jData.color.CGColor;
    self.jLineLayer.fillColor = [UIColor clearColor].CGColor;
    self.jLineLayer.contentsScale = [UIScreen mainScreen].scale;
}

- (void)stockFill {
    [self initMaxAndMinValue];
    [self initLayer];
    [self initLinesModelPosition];
    [self drawLineLayer];
}

#pragma mark lazyMethod

- (NSMutableArray *)kPostionArray {
    if (!_kPostionArray) {
        _kPostionArray = [NSMutableArray array];
    }
    return _kPostionArray;
}

- (NSMutableArray *)dPostionArray {
    if (!_dPostionArray) {
        _dPostionArray = [NSMutableArray array];
    }
    return _dPostionArray;
}

- (NSMutableArray *)jPostionArray {
    if (!_jPostionArray) {
        _jPostionArray = [NSMutableArray array];
    }
    return _jPostionArray;
}

@end
