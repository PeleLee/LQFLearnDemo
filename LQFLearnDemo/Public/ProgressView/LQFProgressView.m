//
//  LQFProgressView.m
//  LQFLearnDemo
//
//  Created by liqunfei on 2017/8/9.
//  Copyright © 2017年 LQF. All rights reserved.
//

#import "LQFProgressView.h"
#import "NSString+LQF.h"

#define KProgressColor [UIColor colorWithRed:0/255.0 green:191/255.0 blue:255/255.0 alpha:1]

#define KHWWaveFillColor [UIColor groupTableViewBackgroundColor] //填充颜色
#define KHWWaveTopColor [UIColor colorWithRed:0/255.0 green:191/255.0 blue:255/255.0 alpha:1.0f] //前面波浪颜色
#define KHWWaveBottomColor [UIColor colorWithRed:0/255.0 green:191/255.0 blue:255/255.0 alpha:0.4f] //后面波浪颜色

@interface LQFProgressView()

/**
 显示百分比数字
 */
@property (nonatomic, strong) UILabel *percentLabel;

/**
 线宽
 */
@property (nonatomic, assign) CGFloat circleLineWidth;

/**
 半径
 */
@property (nonatomic, assign) CGFloat circleRadius;

/**
 波浪参数
 */
@property (nonatomic, strong) WaveModel *waveModel;
@property (nonatomic, strong) CADisplayLink *displayLink;

@end

@implementation LQFProgressView

- (instancetype)init {
    if (self = [super init]) {
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextClearRect(context, rect);
    
    switch (_style) {
        case ProgressStyle_Circle:
        {
            [self drawCirclePathWithRect:rect];
        }
            break;
        case ProgressStyle_Install:
        {
            [self drawInstallWithRect:rect];
        }
            break;
        case ProgressStyle_Wave:
        {
            [self drawWaveWithRect:rect];
        }
            break;
        default:
            break;
    }
}

- (void)setStyle:(ProgressStyle)style {
    _style = style;
    switch (style) {
        case ProgressStyle_Circle:
        {
            [self circleView];
            _circleLineWidth = 10;
        }
            break;
        case ProgressStyle_Wave:
        {
            [self initWaveInfo];
        }
            break;
        default:
            break;
    }
}

- (void)setProgress:(CGFloat)progress {
    
    _progress = progress;
    
    if (!(_style == ProgressStyle_Wave)) {
        [self setNeedsDisplay];
    }
}

#pragma mark - Draw

#pragma mark drawCirclePath

- (void)drawCirclePathWithRect:(CGRect)rect {
    NSString *percent = [NSString stringWithFormat:@"%.f%%",_progress * 100];
    
    //Label宽度
    [_percentLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo([NSString calculateSizeWithText:percent width:MAXFLOAT font:26]);
    }];
    
    _percentLabel.text = percent;
    
    UIBezierPath *path = [[UIBezierPath alloc] init];
    path.lineWidth = _circleLineWidth;
    //颜色
    [KProgressColor set];
    
    path.lineCapStyle = kCGLineCapRound;
    path.lineJoinStyle = kCGLineJoinRound;
    //半径
    CGFloat radius = (MIN(rect.size.width, rect.size.height) - _circleLineWidth) * 0.5;
    
    [path addArcWithCenter:(CGPoint){rect.size.width * 0.5, rect.size.height * 0.5} radius:radius startAngle:-M_PI_2 endAngle:-M_PI_2 + (2 * M_PI) * _progress clockwise:YES];
    //连线
    [path stroke];
}

#pragma mark drawInstall

- (void)drawInstallWithRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGFloat xCenter = rect.size.width / 2;
    CGFloat yCenter = rect.size.height / 2;
    CGFloat radiu = MIN(rect.size.width, rect.size.height) / 2 - 10;

    [KProgressColor set];
    
    CGContextSetLineWidth(context, 1);
    CGContextMoveToPoint(context, xCenter, yCenter);
    CGContextAddLineToPoint(context, xCenter, 0);
    CGFloat endAndle = -M_PI_2 + _progress * 2 * M_PI + 0.001;
    CGContextAddArc(context, xCenter, yCenter, radiu, -M_PI_2, endAndle, 1);
    CGContextFillPath(context);
}

#pragma mark - drawWave

- (void)drawWaveWithRect:(CGRect)rect {
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:rect];
    [KHWWaveFillColor setFill];
    [path fill];
    [path addClip];
    
    //绘制两个波形图
    [self drawWaveColor:KHWWaveTopColor offsetx:0 offsety:0];
    [self drawWaveColor:KHWWaveBottomColor offsetx:_waveModel.distance_h offsety:_waveModel.distanch_v];
}

- (void)drawWaveColor:(UIColor *)color offsetx:(CGFloat)offsetx offsety:(CGFloat)offsety
{
    //波浪动画，进度的实际操作范围是，多加上两个振幅的高度，到达设置进度的位置y
    CGFloat end_offY = (1 - _progress) * (self.frame.size.height + 2 * _waveModel.amplitude);
    if (_waveModel.offsety != end_offY) {
        if (end_offY < _waveModel.offsety) {
            _waveModel.offsety = MAX(_waveModel.offsety -= (_waveModel.offsety - end_offY) * _waveModel.offsety_scale, end_offY);
        }else {
            _waveModel.offsety = MIN(_waveModel.offsety += (end_offY - _waveModel.offsety) * _waveModel.offsety_scale, end_offY);
        }
    }
    
    UIBezierPath *wavePath = [UIBezierPath bezierPath];
    for (float next_x = 0.f; next_x <= self.bounds.size.width; next_x ++) {
        //正弦函数，绘制波形
        CGFloat next_y = _waveModel.amplitude * sin(_waveModel.cycle * next_x + _waveModel.offsetx + offsetx / self.bounds.size.width * 2 * M_PI) + _waveModel.offsety + offsety;
        if (next_x == 0) {
            [wavePath moveToPoint:CGPointMake(next_x, next_y - _waveModel.amplitude)];
        }else {
            [wavePath addLineToPoint:CGPointMake(next_x, next_y - _waveModel.amplitude)];
        }
    }
    
    [wavePath addLineToPoint:CGPointMake(self.bounds.size.width, self.bounds.size.height)];
    [wavePath addLineToPoint:CGPointMake(0, self.bounds.size.height)];
    [color set];
    [wavePath fill];
}

#pragma mark - UI

- (void)circleView {
    _percentLabel = [UILabel new];
    [self addSubview:_percentLabel];
    
    [_percentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.centerY.equalTo(self);
        make.width.mas_equalTo(0);
        make.height.mas_equalTo(30);
    }];
    
    _percentLabel.font = [UIFont systemFontOfSize:25];
    _percentLabel.textAlignment = NSTextAlignmentCenter;
    _percentLabel.textColor = KProgressColor;
}

#pragma mark - WaveInfo
- (void)initWaveInfo {
    _progress = 0;
    
    _waveModel = [[WaveModel alloc] init];
    _waveModel.amplitude = self.bounds.size.height / 25;
    _waveModel.cycle = 2 * M_PI / (self.bounds.size.width * 0.9);
    _waveModel.distance_h = 2 * M_PI / _waveModel.cycle * 0.6;
    _waveModel.distanch_v = _waveModel.amplitude * 0.4;
    _waveModel.move_width = 0.5;
    _waveModel.scale = 0.4;
    _waveModel.offsety_scale = 0.1;
    _waveModel.offsety = (1 - _progress) * (self.frame.size.height + 2 * _waveModel.amplitude);
    
    [self addDisplayLinkAction];
}

- (void)addDisplayLinkAction {
    _displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(displayLinkAction)];
    [_displayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
}

- (void)displayLinkAction {
    _waveModel.offsetx += _waveModel.move_width * _waveModel.scale;
    
    //完成
    if (_waveModel.offsety <= 0.01) {
        [self removeDisplayLinAction];
    }
    [self setNeedsDisplay];
}

- (void)removeDisplayLinAction {
    [_displayLink invalidate];
    _displayLink = nil;
}

@end
