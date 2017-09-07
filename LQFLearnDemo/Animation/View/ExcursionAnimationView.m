//
//  ExcursionAnimationView.m
//  LQFLearnDemo
//
//  Created by liqunfei on 2017/9/6.
//  Copyright © 2017年 LQF. All rights reserved.
//

#import "ExcursionAnimationView.h"

@interface ExcursionAnimationView()

@property (nonatomic, strong) NSTimer *imageSwappingTimer;
/**
 20.0f 单个imageview做偏移动画的时间
 */
@property (nonatomic, assign) NSTimeInterval timePerImage;
/**
 2.0f 两个imageview切换的时间
 */
@property (nonatomic, assign) CGFloat imageSwappingAnimationDuration;

/**
 150
 */
@property (nonatomic, assign) CGFloat imageViewsBorderOffset;
/**
 存放两个用来交换的imageview
 */
@property (nonatomic, strong) NSArray *imageViews;
/**
 切换两个imageview时使用 : 0与1
 */
@property (nonatomic, assign) NSUInteger currentlyDisplayingImageViewIndex;
/**
 需要交换的imageview的个数
 */
@property (nonatomic, assign) NSUInteger totalImages;

/**
 背景上显示的图片
 */
@property (nonatomic, assign) UIImage *showImg;

@property (nonatomic, assign) BOOL animating;

@end

@implementation ExcursionAnimationView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        [self initWithData];
        
        NSMutableArray *imageViews = [NSMutableArray arrayWithCapacity:0];
        for (NSInteger i = 0; i < 2; i++) {
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:
                                      CGRectMake(-self.imageViewsBorderOffset*3,
                                                 -self.imageViewsBorderOffset,
                                                 DEVICE_WIDTH + self.imageViewsBorderOffset*3.5,
                                                 DEVICE_HEIGHT + self.imageViewsBorderOffset*2)
                                      ];
            imageView.contentMode = UIViewContentModeScaleAspectFill;
            [self addSubview:imageView];
            
            [imageViews addObject:imageView];
        }
        
        _imageViews = [imageViews copy];
        
    }
    return self;
}

- (void)initWithData {
    _imageViewsBorderOffset = 150;
    _showImg = ImageNamed(@"login_background");
    _animating = NO;
    _totalImages = 2;
    _imageSwappingAnimationDuration = 2.0;
    _timePerImage = 20.0f;
}

- (void)startAnimating {
    if (!_animating) {
        _animating = YES;
        [self.imageSwappingTimer fire];
    }
}

- (void)stopAnimating {
    if (_animating) {
        [_imageSwappingTimer invalidate];
        _imageSwappingTimer = nil;
        for (UIImageView *imageView in self.imageViews) {
            imageView.alpha = 0.0;
        }
        _animating = NO;
    }
}

- (void)bringNextImage {
    //切换两个imageview的状态 一个开始动画，一个隐藏
    
    UIImageView *imageViewToHide = [_imageViews objectAtIndex:_currentlyDisplayingImageViewIndex];
    
    _currentlyDisplayingImageViewIndex = _currentlyDisplayingImageViewIndex ==0 ? 1 : 0;

    UIImageView *imageViewToShow = [_imageViews objectAtIndex:_currentlyDisplayingImageViewIndex];
    
    imageViewToShow.image = _showImg;
    
    static const CGFloat kMovementAndTransitionTimeOffset = 0.1;
    
    [UIView animateWithDuration:self.timePerImage + _imageSwappingAnimationDuration + kMovementAndTransitionTimeOffset
                          delay:0.0f
                        options:UIViewAnimationOptionBeginFromCurrentState|
                                UIViewAnimationCurveLinear
                     animations:^{
                         //可以随机产生 每次移动的速度
                         NSInteger randomTranslationValueX = self.imageViewsBorderOffset * 3 - [[self class] randomIntBetweenNumber:0 andNumber:self.imageViewsBorderOffset];
                         
                         NSInteger randomTranslationValueY = 0;
                         
                         //平移
                         CGAffineTransform translationTransform = CGAffineTransformMakeTranslation(randomTranslationValueX, randomTranslationValueY);
                         
                         CGFloat randomScaleTransformValue = [[self class] randomIntBetweenNumber:115 andNumber:120] / 100;
                         
                         //放大
                         CGAffineTransform scaleTransform = CGAffineTransformMakeScale(randomScaleTransformValue, randomScaleTransformValue);
                         
                         imageViewToShow.transform = CGAffineTransformConcat(scaleTransform, translationTransform);
    }
                     completion:nil];
    
    [UIView animateWithDuration:_imageSwappingAnimationDuration
                          delay:kMovementAndTransitionTimeOffset
                        options:UIViewAnimationOptionBeginFromCurrentState |
                                UIViewAnimationCurveLinear
                     animations:^{
        imageViewToShow.alpha = 1.0;
        imageViewToHide.alpha = 0.0;
    }
                     completion:^(BOOL finished) {
        if (finished) {
            imageViewToHide.transform = CGAffineTransformIdentity;
        }
                     }];
}

#pragma mark - lazy getter

- (NSTimer *)imageSwappingTimer {
    if (!_imageSwappingTimer) {
        _imageSwappingTimer = [NSTimer scheduledTimerWithTimeInterval:self.timePerImage
                                                               target:self
                                                             selector:@selector(bringNextImage)
                                                             userInfo:nil
                                                              repeats:YES];
    }
    
    return _imageSwappingTimer;
}

#pragma mark -

+ (NSUInteger)randomIntBetweenNumber:(NSUInteger)minNumber
                           andNumber:(NSUInteger)maxNumber {
    if (minNumber > maxNumber) {
        return [self randomIntBetweenNumber:maxNumber andNumber:minNumber];
    }
    
    NSUInteger i = (arc4random() % (maxNumber - minNumber + 1)) + minNumber;
    return i;
}

#pragma mark - dealloc

- (void)dealloc {
    [_imageSwappingTimer invalidate];
    _imageSwappingTimer = nil;
}

@end
