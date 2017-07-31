//
//  LQFSegmentScroll.m
//  LQFLearnDemo
//
//  Created by liqunfei on 2017/7/27.
//  Copyright © 2017年 LQF. All rights reserved.
//

#import "LQFSegmentScroll.h"

@interface LQFSegmentScroll()<UIScrollViewDelegate> {
    NSMutableArray *viewsArray;
}


@end

@implementation LQFSegmentScroll

- (instancetype)initWithFrame:(CGRect)frame vcOrViews:(NSArray *)sources {
    if (self = [super initWithFrame:frame]) {
        viewsArray = [sources mutableCopy];
        [self defaultSet];
    }
    return self;
}

- (void)defaultSet {
    self.showsVerticalScrollIndicator = NO;
    self.showsHorizontalScrollIndicator = NO;
    self.pagingEnabled = YES;
    self.bounces = NO;
    self.delegate = self;
    [self setContentSize:CGSizeMake(viewsArray.count * self.frame.size.width, self.frame.size.height)];
    
    _countLimit = viewsArray.count;
}

@end
