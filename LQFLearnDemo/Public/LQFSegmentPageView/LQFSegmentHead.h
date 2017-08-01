//
//  LQFSegmentHead.h
//  LQFLearnDemo
//
//  Created by liqunfei on 2017/7/27.
//  Copyright © 2017年 LQF. All rights reserved.
//  https://github.com/MengLiMing/MLMSegmentPage

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    /**
     *  arrow(箭头)
     */
    SegmentHeadStyleArrow,
    /**
     *  Slide(滑块)
     */
    SegmentHeadStyleSlide
} LQFSegmentHeadStyle;

typedef enum : NSUInteger {
    LQFSegmentLayoutDefault,
    /*
     * 居中(标题不足一屏时选择样式，反之设置后按照居左)
     */
    LQFSegmentLayoutCenter,
    /*
     * 居左
     */
    LQFSegmentLayoutLeft
} LQFSegmentLayoutStyle;

@protocol LQFSegmentHeadDelegate <NSObject>

- (void)didSelectedIndex:(NSInteger)index;

@end

@interface LQFSegmentHead : UIView

/**
 初始化显示的下标 默认为0
 */
@property (nonatomic, assign) NSInteger showIndex;

/**
 seg导航条的背景颜色
 */
@property (nonatomic, strong) UIColor *headColor;

/**
 非均分样式下按钮的宽度 = 计算 + singleW_Add
 */
@property (nonatomic, assign) CGFloat singleW_Add;
/**
 设置完成后更改self的宽度 
 */
@property (nonatomic, assign) BOOL equalSize;

/**
 选择状态下的颜色
 */
@property (nonatomic, strong) UIColor *selectColor;

/**
 未选中状态下的颜色
 */
@property (nonatomic, strong) UIColor *deSelectColor;

/**
 字体的大小
 */
@property (nonatomic, assign) CGFloat fontSize;

/**
 选中状态 的缩放比例
 */
@property (nonatomic, assign) CGFloat fontScale;

#pragma mark - 添加更多按钮样式
/**
 添加更多样式
 */
@property (nonatomic, strong) UIView *moreButton;
/**
 更多按钮宽度
 */
@property (nonatomic, assign) CGFloat moreButton_width;

#pragma mark - 下划线风格
/**
 下划线颜色
 */
@property (nonatomic, strong) UIColor *lineColor;
/**
 下划线高度
 */
@property (nonatomic, assign) CGFloat lineHeight;
/**
 下划线相对正常状态下的百分比
 */
@property (nonatomic, assign) CGFloat lineScale;

#pragma mark - 箭头风格
/**
 箭头的颜色
 */
@property (nonatomic, strong) UIColor *arrowColor;
#pragma mark - 滑块风格
/**
 滑块的颜色
 */
@property (nonatomic, strong) UIColor *slideColor;
/**
 滑块高度
 */
@property (nonatomic, assign) CGFloat slideHeight;
/**
 滑块的圆角大小
 */
@property (nonatomic, assign) CGFloat slideCorner;
/**
 滑块相对于正常状态下的百分比,默认是1
 */
@property (nonatomic, assign) CGFloat slideScale;
/**
 顶部导航栏下方的边线
 */
@property (nonatomic, assign) CGFloat bottomLineHeight;
@property (nonatomic, strong) UIColor *bottomLineColor;

/**
 设置当前屏幕最多显示的按钮数
 */
@property (nonatomic, assign) CGFloat maxTitles;

@property (nonatomic, weak) id <LQFSegmentHeadDelegate> delegate;

/**
 block
 */
@property (nonatomic, copy) void(^selectedIndex)(NSInteger index);

/**
 居中箭头样式的segview

 @param frame 位置
 @param titles title数组
 @param style 样式
 @param layout 布局
 @return nil
 */
- (instancetype)initWithFrame:(CGRect)frame
                       titles:(NSArray *)titles
                    headStyle:(LQFSegmentHeadStyle)style
                  layoutStyle:(LQFSegmentLayoutStyle)layout;

/**
 创建之后,初始化
 */
- (void)defaultAndCreateView;

/**
 set currentIndex

 @param index currentIndex
 */
- (void)setSelectIndex:(NSInteger)index;

/**
 点击结束
 */
- (void)animationEnd;

/**
 animation by scale

 @param scale scale
 */
- (void)changePointScale:(CGFloat)scale;

@end
