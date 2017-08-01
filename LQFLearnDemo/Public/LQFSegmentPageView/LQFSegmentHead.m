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

static CGFloat animation_time = .3;

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
    
    //滑块view
    UIView *slideView;
    UIScrollView *slideScroll;
    
    //分割线
    UIView *bottomLineView;
    
    //当前选中的按钮
    NSInteger currentIndex;
    
    //在与外侧scroll关联时,动画结束之后将其设置为NO
    BOOL isSelected;//区分是点击还是滑动
    
    //button宽度的数组
    NSMutableArray *titleWidthArray;
    //总宽度
    CGFloat sum_width;
    
    //用来判断向左还是向右
    CGFloat endScale;
}

#pragma mark - initMethod

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
    
    buttonArray = [NSMutableArray arrayWithCapacity:0];
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

#pragma mark - layout

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
    }
    
    //判断总宽度
    if (sum_width > SCROLL_WIDTH && _layoutStyle == LQFSegmentLayoutCenter) {
        _layoutStyle = LQFSegmentLayoutLeft;
    }
    
    _showIndex = MIN(_titlesArray.count - 1, MAX(0, _showIndex));
    
    [self createView];
    
    if (_showIndex != 0) {
        currentIndex = _showIndex;
        [self changeContentOffset];
        [self changeBtnFrom:0 to:_showIndex];
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
    [self scrollViewSubviews:titlesScroll];
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
            [lineView.layer addSublayer:arrow_layer];
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

#pragma mark - create customScroll

- (UIScrollView *)customScroll {
    if (!_titlesArray) {
        return nil;
    }
    UIScrollView *scroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCROLL_WIDTH, SCROLL_HEIGHT)];
    scroll.contentSize = CGSizeMake(MAX(SCROLL_WIDTH, sum_width), SCROLL_HEIGHT);
    scroll.backgroundColor = _headColor;
//    scroll.backgroundColor = [UIColor orangeColor];
    scroll.showsVerticalScrollIndicator = NO;
    scroll.showsHorizontalScrollIndicator = NO;
    scroll.bounces = NO;
    return scroll;
}

#pragma mark - titlesScroll subviews

- (void)scrollViewSubviews:(UIScrollView *)scroll {
    BOOL titles = [scroll isEqual:titlesScroll];
    
    CGFloat start_x = 0;
    
    if (_layoutStyle == LQFSegmentLayoutCenter) {
        //计算布局的起点
//        start_x = SCROLL_WIDTH / 2;
//        for (NSInteger i = 0; i < titleWidthArray.count / 2; i++) {
//            start_x -= CURRENT_WIDTH(i);
//        }
//        if (_titlesArray.count % 2 != 0) {
//            start_x -= CURRENT_WIDTH(titleWidthArray.count / 2) / 2;
//        }
        start_x = (SCROLL_WIDTH - sum_width) / 2;
    }
    [self createBtn:_titlesArray addScroll:scroll startX:start_x start_index:0];
    
    if (titles && _headStyle != SegmentHeadStyleSlide) {
        UIButton *curBtn = buttonArray[_showIndex];
        if (_fontScale != 1) {
            curBtn.titleLabel.font = [UIFont systemFontOfSize:_fontScale * _fontSize];
        }
        [curBtn setTintColor:_selectColor];
    }
}

#pragma mark - createBtn

- (void)createBtn:(NSArray *)titlesArr addScroll:(UIScrollView *)scroll startX:(CGFloat)start_x start_index:(NSInteger)start_index {
    BOOL titles = [scroll isEqual:titlesScroll];
    CGFloat width;
    for (NSInteger i = start_index; i < titlesArr.count; i++) {
        width = CURRENT_WIDTH(i);
        UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
        [button setTitle:titlesArr[i] forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:_fontSize];
        button.frame = CGRectMake(start_x, 0, width, SCROLL_HEIGHT);
        start_x += width;
        if (titles) {
            [button setTintColor:_deSelectColor];
            [button addTarget:self action:@selector(selectedHeadTitles:) forControlEvents:UIControlEventTouchUpInside];
            [buttonArray addObject:button];
        }
        else {
            [button setTintColor:_selectColor];
        }
        [scroll addSubview:button];
    }
    scroll.contentSize = CGSizeMake(MAX(SCROLL_WIDTH, sum_width), SCROLL_HEIGHT);
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

#pragma mark - bottom line

- (UIView *)bottomLineView {
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, SCROLL_HEIGHT, self.width, _bottomLineHeight)];
    line.backgroundColor = _bottomLineColor;
    return line;
}

#pragma mark - button Action

- (void)selectedHeadTitles:(UIButton *)button {
    NSInteger selectIndex = [buttonArray indexOfObject:button];
    [self setSelectIndex:selectIndex];
}

- (void)animationEnd {
    isSelected = NO;
}

#pragma mark - set index

- (void)setSelectIndex:(NSInteger)index {
    if (index == currentIndex) {
        return;
    }
    //before
    NSInteger before = currentIndex;
    currentIndex = index;
    [self changeContentOffset];
    //select
    [UIView animateWithDuration:animation_time animations:^{
        [self changeBtnFrom:before to:currentIndex];
    } completion:^(BOOL finished) {
        nil;
    }];
    
    isSelected = YES;
    if ([self.delegate respondsToSelector:@selector(didSelectedIndex:)]) {
        [self.delegate didSelectedIndex:currentIndex];
    }
    else if (self.selectedIndex) {
        self.selectedIndex(currentIndex);
    }
}

- (void)changeContentOffset {
    if (sum_width > SCROLL_WIDTH) {
        UIButton *currentBtn = buttonArray[currentIndex];
        if (currentBtn.center.x < SCROLL_WIDTH / 2) {
            [titlesScroll setContentOffset:CGPointMake(0, 0) animated:YES];
        }
        else if (currentBtn.center.x > (sum_width - SCROLL_WIDTH / 2)) {
            [titlesScroll setContentOffset:CGPointMake(sum_width - SCROLL_WIDTH, 0) animated:YES];
        }
        else {
            [titlesScroll setContentOffset:CGPointMake(currentBtn.center.x - SCROLL_WIDTH / 2, 0) animated:YES];
        }
    }
}

- (void)changeBtnFrom:(NSInteger)from to:(NSInteger)to {
    UIButton *before_btn = buttonArray[from];
    UIButton *select_btn = buttonArray[to];
    if (_headStyle != SegmentHeadStyleSlide) {
        [before_btn setTintColor:_deSelectColor];
        [select_btn setTintColor:_selectColor];
    }
    
    if (_fontScale) {
        before_btn.titleLabel.font = [UIFont systemFontOfSize:_fontSize];
        select_btn.titleLabel.font = [UIFont systemFontOfSize:_fontSize * _fontScale];
    }
    
    if (lineView) {
        lineView.width = select_btn.width * _lineScale;
        lineView.center = CGPointMake(select_btn.center.x, lineView.center.y);
    }
    
    if (arrow_layer) {
        arrow_layer.position = CGPointMake(lineView.width / 2, lineView.height / 2);
    }
    
    if (slideView) {
        //slide位置变化
        slideView.width = select_btn.width * _slideScale;
        slideView.center = CGPointMake(select_btn.center.x, slideView.center.y);
        //偏移
        CGRect convertRect = [slideView convertRect:titlesScroll.frame fromView:titlesScroll];
        slideScroll.frame = CGRectMake(convertRect.origin.x, convertRect.origin.y, slideScroll.contentSize.width, slideScroll.contentSize.height);
    }
}

#pragma mark - animation
//外部关联的scrollView的变化
- (void)changePointScale:(CGFloat)scale {
    if (isSelected) {
        return;
    }
    if (scale < 0) {
        return;
    }
    //区分向左 还是向右
    BOOL left = endScale > scale;
    endScale = scale;
    
    //1.将scale变为对应titleScroll的titleScale
    CGFloat per_view = 1.0 / (CGFloat)_titlesArray.count;
    NSInteger changeIndex = scale / per_view + (left ? 1 : 0);
    NSInteger nextIndex = changeIndex + (left ? -1 : 1);
    
    //超出范围
    if (nextIndex >= _titlesArray.count || changeIndex >= _titlesArray.count) {
        return;
    }
    
    //currentBtn
    UIButton *currentBtn = buttonArray[changeIndex];
    UIButton *nextBtn = buttonArray[nextIndex];
    
    CGFloat start_scale = 0;
    for (NSInteger i = 0; i < nextIndex; i++) {
        start_scale += CURRENT_WIDTH(i) / sum_width;
    }
    //滑块选中位置所占的相对百分比
    CGFloat current_title_Scale = CURRENT_WIDTH(changeIndex) / sum_width;
    //单个view偏移的百分比
    CGFloat single_offset_Scale = (scale - per_view * changeIndex) / per_view;
    CGFloat titleScale = single_offset_Scale * current_title_Scale + start_scale;
    CGFloat change_scale = (left ? -1 : 1) * (titleScale - start_scale) / current_title_Scale;
    
    switch (_headStyle) {
        case SegmentHeadStyleArrow:
        {
            if (lineView) {
                lineView.width = [self widthChangeCurWidth:CURRENT_WIDTH(changeIndex) nextWidth:CURRENT_WIDTH(nextIndex) changeScale:change_scale endScale:_lineScale];
                CGFloat center_x = [self centerChangeCurBtn:currentBtn nextBtn:nextBtn changeScale:change_scale];
                lineView.center = CGPointMake(center_x, lineView.center.y);
            }
            if (arrow_layer) {
                arrow_layer.position = CGPointMake(lineView.width / 2, lineView.height / 2);
            }
            //颜色变化
            [self colorChangeCurBtn:currentBtn nextBtn:nextBtn changeScale:change_scale];
            //字体大小变化
            [self fontChangeCurbtn:currentBtn nextBtn:nextBtn changeScale:change_scale];
        }
            break;
            
        default:
            break;
    }
}

#pragma mark - 长度变化
- (CGFloat)widthChangeCurWidth:(CGFloat)curWidth nextWidth:(CGFloat)nextWidth changeScale:(CGFloat)changeScale endScale:(CGFloat)endscale {
    //改变的宽度
    CGFloat change_width = curWidth - nextWidth;
    //宽度变化
    CGFloat width = curWidth * endscale - changeScale * change_width;
    return width;
}

#pragma mark - 中心位置的变化
- (CGFloat)centerChangeCurBtn:(UIButton *)curBtn nextBtn:(UIButton *)nextBtn changeScale:(CGFloat)changeScale {
    //lineView改变的中心
    CGFloat change_center = nextBtn.center.x - curBtn.center.x;
    CGFloat center_x = curBtn.center.x + changeScale * change_center;
    return center_x;
}

#pragma mark - 字体大小变化
- (void)fontChangeCurbtn:(UIButton *)curBtn nextBtn:(UIButton *)nextBtn changeScale:(CGFloat)changeScale {
    CGFloat btn_font_change = _fontSize * (_fontScale - 1);
    CGFloat next_font = _fontSize + changeScale * btn_font_change;
    CGFloat cur_font = _fontSize * _fontScale - changeScale * btn_font_change;
    nextBtn.titleLabel.font = [UIFont systemFontOfSize:next_font];
    curBtn.titleLabel.font = [UIFont systemFontOfSize:cur_font];
}

#pragma mark - 颜色变化
- (void)colorChangeCurBtn:(UIButton *)curBtn nextBtn:(UIButton *)nextBtn changeScale:(CGFloat)changeScale {
    CGFloat sel_red;
    CGFloat sel_green;
    CGFloat sel_blue;
    CGFloat sel_alpha;
    
    CGFloat de_sel_red;
    CGFloat de_sel_green;
    CGFloat de_sel_blue;
    CGFloat de_sel_alpha;
    
    if ([_selectColor getRed:&sel_red green:&sel_green blue:&sel_blue alpha:&sel_alpha] &&
        [_deSelectColor getRed:&de_sel_red green:&de_sel_green blue:&de_sel_blue alpha:&de_sel_alpha]) {
        //颜色变化的大小
        CGFloat red_change = sel_red - de_sel_red;
        CGFloat green_change = sel_green - de_sel_green;
        CGFloat blue_change = sel_blue - de_sel_blue;
        CGFloat alpha_change = sel_alpha - de_sel_alpha;
        //颜色变化
        [nextBtn setTintColor:[UIColor colorWithRed:de_sel_red + red_change * changeScale
                                              green:de_sel_green + green_change * changeScale
                                               blue:de_sel_blue + blue_change * changeScale
                                              alpha:de_sel_alpha + alpha_change * changeScale]];
        [curBtn setTintColor:[UIColor colorWithRed:sel_red - red_change * changeScale
                                             green:sel_green - green_change * changeScale
                                              blue:sel_blue - blue_change * changeScale
                                             alpha:sel_alpha - alpha_change * changeScale]];
    }
}

#pragma mark - dealloc
- (void)dealloc {
    arrow_layer.delegate = nil;
    [arrow_layer removeFromSuperlayer];
    arrow_layer = nil;
}

@end
