//
//  LQFSegmentScroll.m
//  LQFLearnDemo
//
//  Created by liqunfei on 2017/7/27.
//  Copyright © 2017年 LQF. All rights reserved.
//

#import "LQFSegmentScroll.h"
#import "UIView+ViewController.h"

@interface LQFSegmentScroll()<UIScrollViewDelegate,NSCacheDelegate> {
    NSMutableArray *viewsArray;
    
    CGFloat start_offset_x;
}

//存储页面(使用计数功能)
@property (nonatomic, strong) NSCache *viewsCache;

@end

@implementation LQFSegmentScroll

- (void)dealloc {
    self.delegate = nil;
    _viewsCache.delegate = nil;
    _viewsCache = nil;
}

- (instancetype)initWithFrame:(CGRect)frame vcOrViews:(NSArray *)sources {
    if (self = [super initWithFrame:frame]) {
        viewsArray = [sources mutableCopy];
        [self defaultSet];
    }
    return self;
}

#pragma mark - default setting
- (void)defaultSet {
    self.showsVerticalScrollIndicator = NO;
    self.showsHorizontalScrollIndicator = NO;
    self.pagingEnabled = YES;
    self.bounces = NO;
    self.delegate = self;
    [self setContentSize:CGSizeMake(viewsArray.count * self.frame.size.width, self.frame.size.height)];
    
    _countLimit = viewsArray.count;
}

#pragma mark - viewsCache
- (NSCache *)viewsCache {
    if (!_viewsCache) {
        _viewsCache = [[NSCache alloc] init];
        _viewsCache.countLimit = _countLimit;
        _viewsCache.delegate = self;
        _viewsCache.evictsObjectsWithDiscardedContent = YES;
    }
    return _viewsCache;
}

- (void)createView {
    _showIndex = MIN(viewsArray.count - 1, MAX(0, _showIndex));
    [self setContentOffset:CGPointMake(_showIndex * self.frame.size.width, 0)];
    
    if (_loadAll) {
        NSInteger startIndex;
        if (viewsArray.count - _showIndex > _countLimit) {
            startIndex = _showIndex;
        }
        else {
            startIndex = viewsArray.count - _countLimit;
        }
        for (NSInteger i = startIndex; i < startIndex + _countLimit; i++) {
            [self addViewCacheIndex:i];
        }
    }
    else {
        [self setContentOffset:CGPointMake(_showIndex * self.width, 0) animated:NO];
    }
}

- (void)addViewCacheIndex:(NSInteger)index {
    id object = viewsArray[index];
    if ([object isKindOfClass:[NSString class]]) {
        Class class = NSClassFromString(object);
        if ([class isSubclassOfClass:[UIViewController class]]) {
            UIViewController *vc = [class new];
            [self addVC:vc atIndex:index];
        }
        else if ([class isSubclassOfClass:[UIView class]]) {
            UIView *view = [class new];
            [self addView:view atIndex:index];
        }
        else {
            NSLog(@"please enter the correct name of class!");
        }
    }
    else {
        if ([object isKindOfClass:[UIViewController class]]) {
            [self addVC:object atIndex:index];
        }
        else if ([object isKindOfClass:[UIView class]]) {
            [self addView:object atIndex:index];
        }
        else {
            NSLog(@"this class was not found!");
        }
    }
}

#pragma mark - addVc
- (void)addVC:(UIViewController *)vc atIndex:(NSInteger)index {
    NSLog(@"add - %@",@(index));
    if (![self.viewsCache objectForKey:@(index)]) {
        [self.viewsCache setObject:vc forKey:@(index)];
    }
    
    vc.view.frame = CGRectMake(index * self.width, 0, self.width, self.height);
    [self.viewController addChildViewController:vc];
    [self addSubview:vc.view];
}

- (void)addView:(UIView *)view atIndex:(NSInteger)index {
    if (![self.viewsCache objectForKey:@(index)]) {
        [self.viewsCache setObject:view forKey:@(index)];
    }
    view.frame = CGRectMake(index * self.width, 0, self.width, self.height);
//    view.backgroundColor = RandomColor;
    view.alpha = 0.4;
    [self addSubview:view];
}

- (void)setContentOffset:(CGPoint)contentOffset animated:(BOOL)animated {
    [super setContentOffset:contentOffset animated:animated];
    NSInteger currentIndex = contentOffset.x / self.width;
    if (!animated) {
        if ([self.segDelegate respondsToSelector:@selector(animationEndIndex:)]) {
            [self.segDelegate animationEndIndex:currentIndex];
        }
        else if (self.animationEnd) {
            self.animationEnd(currentIndex);
        }
    }
    if (![_viewsCache objectForKey:@(currentIndex)]) {
        [self addViewCacheIndex:currentIndex];
    }
}

#pragma mark - ScrollDelegate

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    start_offset_x = scrollView.contentOffset.x;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat scale = self.contentOffset.x / self.contentSize.width;
    if ([self.segDelegate respondsToSelector:@selector(scrollOffsetScale:)]) {
        [self.segDelegate scrollOffsetScale:scale];
    }
    else if (self.offSetScale) {
        self.offSetScale(scale);
    }
    
    if (_addTiming == SegmentAddScale) {
        NSInteger currentIndex = self.contentOffset.x / self.width;
        BOOL left = start_offset_x >= self.contentOffset.x;
        NSInteger next_index = MAX(MIN(viewsArray.count - 1, left ? currentIndex : currentIndex + 1), 0);
        if (fabs(scale * viewsArray.count - next_index) < (1 - _addScale)) {
            if (![_viewsCache objectForKey:@(next_index)]) {
                [self addViewCacheIndex:next_index];
            }
        }
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    //滑动结束
    NSInteger currentIndex = self.contentOffset.x / self.frame.size.width;
    if ([self.segDelegate respondsToSelector:@selector(scrollEndIndex:)]) {
        [self.segDelegate scrollEndIndex:currentIndex];
    }
    else if (self.scrollEnd) {
        self.scrollEnd(currentIndex);
    }
}

#pragma mark - NSCacheDelegate

- (void)cache:(NSCache *)cache willEvictObject:(id)obj {
    //进入后台不清理
    if ([UIApplication sharedApplication].applicationState == UIApplicationStateBackground) {
        return;
    }
    NSLog(@"remove- %@",NSStringFromClass([obj class]));
    if ([obj isKindOfClass:[UIViewController class]]) {
        UIViewController *vc = obj;
        [vc.view removeFromSuperview];
        vc.view = nil;
        [vc removeFromParentViewController];
    }
    else {
        UIView *vw = obj;
        [vw removeFromSuperview];
        vw = nil;
    }
}

@end
