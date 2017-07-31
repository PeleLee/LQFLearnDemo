//
//  LQFSegmentHead.m
//  LQFLearnDemo
//
//  Created by liqunfei on 2017/7/27.
//  Copyright © 2017年 LQF. All rights reserved.
//

#import "LQFSegmentHead.h"

#define SCROLL_WIDTH (self.frame.size.width - _moreButton_width)
#define SCROLL_HEIGHT (self.frame.size.height - _bottomLineHeight)
#define CURRENT_WIDTH(s) [titleWidthArray[s] floatValue]
//箭头高 宽
static CGFloat arrow_H = 6;
static CGFloat arrow_W = 18;

@interface LQFSegmentHead()

@property (nonatomic, assign) LQFSegmentHeadStyle headStyle;
@property (nonatomic, assign) LQFSegmentLayoutStyle layoutStyle;

@end

@implementation LQFSegmentHead {
    //标题数组
    NSMutableArray *_titlesArray;
    UIScrollView *titlesScroll;
    
    //按钮数组
    NSMutableArray *buttonArray;
    
    //下划线view
    UIView *lineView;
    //箭头layer
    CAShapeLayer *arrow_layer;
    
    UIScrollView *slideScroll;
    
    //分割线
    UIView *bottomLineView;
    
    //当前选中的按钮
    NSInteger currentIndex;
    
    //按钮数组
    NSMutableArray *_buttonArray;
    //button宽度的数组
    NSMutableArray *titleWidthArray;
    //总宽度
    CGFloat sum_width;
}

- (instancetype)initWithFrame:(CGRect)frame
                       titles:(NSArray *)titles
                    headStyle:(LQFSegmentHeadStyle)style
                  layoutStyle:(LQFSegmentLayoutStyle)layout {
    if (self = [super initWithFrame:frame]) {
        _headStyle = style;
        _layoutStyle = layout;
        _titlesArray = [titles mutableCopy];
        [self initCustom];
    }
    return self;
}

#pragma mark - custom init
- (void)initCustom {
    _headColor = [UIColor whiteColor];
    _selectColor = [UIColor blackColor];
    _deSelectColor = [UIColor lightGrayColor];
    
    _moreButton_width = 0;
    
    _buttonArray = [NSMutableArray arrayWithCapacity:0];
    _showIndex = 0;
    
    _fontSize = 13;
    _fontScale = 1;
    
    _singleW_Add = 20;
    
    _lineColor = _selectColor;
    _lineHeight = 2.5;
    _lineScale = 1;
    
    _arrowColor = _selectColor;
    
    _slideHeight = SCROLL_HEIGHT;
    _slideColor = _deSelectColor;
    _slideCorner = _slideHeight/2;
    _slideScale = 1;
    
    _maxTitles = 5.0;
    
    _bottomLineColor = [UIColor grayColor];
    _bottomLineHeight = 1;
}

- (void)defaultAndCreateView {
    if (!titleWidthArray) {
        titleWidthArray = [NSMutableArray arrayWithCapacity:_titlesArray.count];
    }
    [titleWidthArray removeAllObjects];
    
    _maxTitles = _maxTitles > _titlesArray.count ? _titlesArray.count : _maxTitles;
    
    [self titlesWidth];
    
    if (_equalSize) {
        self.width = sum_width + _moreButton_width;
        
        if (titlesScroll) {
            titlesScroll.width = DEVICE_WIDTH;
        }
        
        if (slideScroll) {
            slideScroll.width = DEVICE_WIDTH;
        }
        
        //判断总宽度
        if (sum_width > SCROLL_WIDTH && _layoutStyle == LQFSegmentLayoutCenter) {
            _layoutStyle = LQFSegmentLayoutLeft;
        }
        
        _showIndex = MIN(_titlesArray.count - 1, MAX(0, _showIndex));
        
        [self createView];
    }
}

#pragma mark - 根据文字计算宽度
- (void)titlesWidth {
    sum_width = 0;
    CGFloat width = SCROLL_WIDTH/_maxTitles;
    for (NSString *title in _titlesArray) {
        if (_layoutStyle != LQFSegmentLayoutDefault) {
            width = [self titleWidth:title];
        }
        [titleWidthArray addObject:@(width)];
        sum_width += width;
    }
}

- (CGFloat)titleWidth:(NSString *)title {
    CGFloat sys_font = _fontScale > 1 ? _fontSize * _fontScale : _fontSize;
    return [title boundingRectWithSize:CGSizeMake(MAXFLOAT, CGRectGetHeight(self.frame)) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:sys_font]} context:nil].size.width + _singleW_Add;
}

#pragma mark - create View
- (void)createView {
    _fontScale = _headStyle == SegmentHeadStyleSlide ? 1 : _fontScale;
    titlesScroll = [self customScroll];
    [self addSubview:titlesScroll];
    
    if (_moreButton) {
        _moreButton.frame = CGRectMake(CGRectGetMaxX(titlesScroll.frame), 0, _moreButton_width, titlesScroll.height);
        [self addSubview:_moreButton];
    }
    
    if (_bottomLineHeight) {
        bottomLineView = [self bottomLineView];
        [self addSubview:bottomLineView];
    }
    
    switch (_headStyle) {
        case SegmentHeadStyleArrow:
        {
            _lineHeight = arrow_H;
            _lineScale = 1;
            lineView = [self lineView];
            lineView.backgroundColor = [UIColor clearColor];
            [titlesScroll addSubview:lineView];
            //arrow
            [self drawArrowLayer];
            arrow_layer.position = CGPointMake(lineView.width / 2, lineView.height / 2);
        }
            break;
            
        default:
            break;
    }
}

#pragma mark - draw arrow
- (void)drawArrowLayer {
    arrow_layer = [[CAShapeLayer alloc] init];
    arrow_layer.bounds = CGRectMake(0, 0, arrow_W, arrow_H);
    [arrow_layer setFillColor:_arrowColor.CGColor];
    UIBezierPath *arrowPath = [UIBezierPath bezierPath];
    [arrowPath moveToPoint:CGPointMake(arrow_W / 2, 0)];
    [arrowPath addLineToPoint:CGPointMake(arrow_W, arrow_H)];
    [arrowPath addLineToPoint:CGPointMake(0, arrow_H)];
    [arrowPath closePath];
    arrow_layer.path = arrowPath.CGPath;
}

#pragma mark - create line
- (UIView *)lineView {
    _lineScale = fabs(_lineScale) > 1 ? 1 : fabs(_lineScale);
    
    CGFloat line_w = CURRENT_WIDTH(currentIndex);
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, SCROLL_HEIGHT - _lineHeight, line_w * _lineScale, _lineHeight)];
    UIButton *current_btn = buttonArray[currentIndex];
    line.center = CGPointMake(current_btn.center.x, line.center.y);
    line.backgroundColor = _lineColor;
    return line;
}

#pragma mark - create customScroll
- (UIScrollView *)customScroll {
    if (!_titlesArray) {
        return nil;
    }
    UIScrollView *scroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCROLL_WIDTH, SCROLL_HEIGHT)];
    scroll.contentSize = CGSizeMake(MAX(SCROLL_WIDTH, sum_width), SCROLL_HEIGHT);
    scroll.backgroundColor = _headColor;
    scroll.showsVerticalScrollIndicator = NO;
    scroll.showsHorizontalScrollIndicator = NO;
    scroll.bounces = NO;
    return scroll;
}

#pragma mark - bottom line
- (UIView *)bottomLineView {
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, SCROLL_HEIGHT, self.width, _bottomLineHeight)];
    line.backgroundColor = _bottomLineColor;
    return line;
}

@end
