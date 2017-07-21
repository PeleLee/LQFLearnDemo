//
//  LQFMacdView.m
//  LQFLearnDemo
//
//  Created by liqunfei on 2017/7/17.
//  Copyright © 2017年 LQF. All rights reserved.
//

#import "LQFMacdView.h"
#import "LQFMacdPositionModel.h"
#import "LQFLineModel.h"
#import "UIBezierPath+Draw.h"

static inline bool isEqualZero(float value)
{
    return fabs(value) <= 0.00001f;
}

@interface LQFMacdView()

@property (nonatomic, strong) NSMutableArray *displayArray;
@property (nonatomic, strong) NSMutableArray *macdArray;
@property (nonatomic, strong) NSMutableArray *deaArray;
@property (nonatomic, strong) NSMutableArray *diffArray;
@property (nonatomic, strong) CAShapeLayer   *macdLayer;

@end

@implementation LQFMacdView

#pragma mark calcute
- (void)calcuteMaxAndMinValue {
    CGFloat maxPrice = 0;
    CGFloat minPrice = 0;
    
    LQFMacdModel *first = [self.displayArray objectAtIndex:0];
    maxPrice = MAX(first.dea, MAX(first.diff, first.macd));
    minPrice = MIN(first.dea, MIN(first.diff, first.macd));
    
    for (NSInteger i = 1; i < self.displayArray.count; i++) {
        LQFMacdModel *macdData = [self.displayArray objectAtIndex:i];
        maxPrice = MAX(maxPrice, MAX(macdData.dea, MAX(macdData.diff, macdData.macd)));
        minPrice = MIN(minPrice, MIN(macdData.dea, MIN(macdData.diff, macdData.macd)));
    }
    self.maxY = maxPrice;
    self.minY = minPrice;
    if (self.maxY - self.minY < 0.5) {
        self.maxY += 0.5;
        self.minY -= 0.5;
    }
    self.topMargin = 0;
    self.bottomMargin = 5;
    self.scaleY = (self.maxY - self.minY) / (self.height - self.topMargin - self.bottomMargin);
}

- (void)initMaModelPosition {
    for (NSInteger i = 0; i < self.displayArray.count; i++) {
        LQFMacdModel *lineData = [self.displayArray objectAtIndex:i];
        CGFloat xPosition = self.leftPosition + ((self.candleSpace + self.candleWidth) * i);
        CGFloat yPosition = ABS((self.maxY - lineData.macd) / self.scaleY) + self.topMargin;
        //macd
        LQFMacdPositionModel *model = [[LQFMacdPositionModel alloc] init];
        model.endPoint = CGPointMake(xPosition, yPosition);
        model.startPoint = CGPointMake(xPosition, self.maxY / self.scaleY);
        
        float x = model.startPoint.y - model.endPoint.y;
        if (isEqualZero(x)) {
            //柱线的最小高度
            model.endPoint = CGPointMake(xPosition, self.maxY / self.scaleY + 1);
        }
        [self.macdArray addObject:model];
        
        //diff
        CGFloat diffPosition = ABS((self.maxY - lineData.diff) / self.scaleY) + self.topMargin;
        LQFLineModel *diffModel = [LQFLineModel initPosition:xPosition + self.candleWidth / 2 yPosition:diffPosition color:[UIColor redColor]];
        [self.diffArray addObject:diffModel];
        
        //dea
        CGFloat deayPosition = ABS((self.maxY - lineData.dea) / self.scaleY) + self.topMargin;
        LQFLineModel *deaModel = [LQFLineModel initPosition:xPosition + self.candleWidth/2 yPosition:deayPosition color:[UIColor redColor]];
        [self.deaArray addObject:deaModel];
    }
}

- (CAShapeLayer *)drawMacdLayer:(LQFMacdPositionModel *)modle candleModel:(LQFMacdModel *)candleModel {
    CGRect rect;
    if (modle.startPoint.y <= 0) {
        rect = CGRectMake(modle.startPoint.x, self.topMargin, self.candleWidth, modle.endPoint.y - modle.startPoint.y);
    }
    
    else {
        rect = CGRectMake(modle.startPoint.x, modle.startPoint.y, self.candleWidth, modle.endPoint.y - modle.startPoint.y);
    }
    
    UIBezierPath *path = [UIBezierPath bezierPathWithRect:rect];
    CAShapeLayer *subLayer = [CAShapeLayer layer];
    subLayer.path = path.CGPath;
    if (candleModel.macd > 0) {
        subLayer.strokeColor = RoseColor.CGColor;
        subLayer.fillColor = RoseColor.CGColor;
    }
    else {
        subLayer.strokeColor = DropColor.CGColor;
        subLayer.fillColor = DropColor.CGColor;
    }
    return subLayer;
}

- (void)drawLine {
    __weak typeof(self) this = self;
    [_macdArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        LQFMacdPositionModel *positionModel = (LQFMacdPositionModel *)obj;
        LQFMacdModel *model = this.displayArray[idx];
        CAShapeLayer *layer = [this drawMacdLayer:positionModel candleModel:model];
        [this.macdLayer addSublayer:layer];
    }];
    
    UIBezierPath *deaPath = [UIBezierPath drawLine:self.deaArray];
    CAShapeLayer *deaLayer = [CAShapeLayer layer];
    deaLayer.path = deaPath.CGPath;
    deaLayer.strokeColor = [UIColor redColor].CGColor;
    deaLayer.fillColor = [UIColor clearColor].CGColor;
    deaLayer.contentsScale = [UIScreen mainScreen].scale;
    [self.macdLayer addSublayer:deaLayer];
    
    UIBezierPath *diffPath = [UIBezierPath drawLine:self.diffArray];
    CAShapeLayer *diffLayer = [CAShapeLayer layer];
    diffLayer.path = diffPath.CGPath;
    diffLayer.strokeColor = [UIColor blackColor].CGColor;
    diffLayer.fillColor = [UIColor clearColor].CGColor;
    diffLayer.contentsScale = [UIScreen mainScreen].scale;
    [self.macdLayer addSublayer:diffLayer];
}

- (void)removeFromSubLayer {
    for (NSInteger i = 0; i < self.macdLayer.sublayers.count; i++) {
        CAShapeLayer *layer = (CAShapeLayer *)self.macdLayer.sublayers[i];
        [layer removeFromSuperlayer];
        layer = nil;
    }
    [self.macdLayer removeFromSuperlayer];
    self.macdLayer = nil;
}

- (void)removeAllObjectFromArray {
    if (self.displayArray.count > 0) {
        [self.displayArray removeAllObjects];
        [self.macdArray removeAllObjects];
        [self.deaArray removeAllObjects];
        [self.diffArray removeAllObjects];
    }
}

- (void)initLayer {
    if (!self.macdLayer.sublayers.count) {
        [self.layer addSublayer:self.macdLayer];
    }
}

#pragma mark setter,getter

- (void)stockFill {
    [self removeFromSubLayer];
    [self removeAllObjectFromArray];
    if (_startIndex + _displayCount > _dataArray.count) {
        NSAssert(_startIndex+(_displayCount-1)>self.dataArray.count, @"数组越界,源代码这里有错误");
        [self.displayArray addObjectsFromArray:[self.dataArray subarrayWithRange:NSMakeRange(_startIndex, _displayCount-1)]];
    }
    
    else {
        [self.displayArray addObjectsFromArray:[self.dataArray subarrayWithRange:NSMakeRange(_startIndex, _displayCount)]];
    }
    [self layoutIfNeeded];
    [self calcuteMaxAndMinValue];
    [self initMaModelPosition];
    [self initLayer];
    [self drawLine];
}

#pragma mark lazyLoad
- (NSMutableArray *)macdArray {
    if (!_macdArray) {
        _macdArray = [NSMutableArray array];
    }
    return _macdArray;
}

- (NSMutableArray *)deaArray {
    if (!_deaArray) {
        _deaArray = [NSMutableArray array];
    }
    return _deaArray;
}

- (NSMutableArray *)diffArray {
    if (!_diffArray) {
        _diffArray = [NSMutableArray array];
    }
    return _diffArray;
}

- (NSMutableArray *)displayArray {
    if (!_displayArray) {
        _displayArray = [NSMutableArray array];
    }
    return _displayArray;
}

- (CAShapeLayer *)macdLayer {
    if (!_macdLayer) {
        _macdLayer = [CAShapeLayer layer];
        _macdLayer.lineWidth = _lineWidth;
        _macdLayer.strokeColor = [UIColor clearColor].CGColor;
        _macdLayer.fillColor = [UIColor clearColor].CGColor;
    }
    return _macdLayer;
}

@end
