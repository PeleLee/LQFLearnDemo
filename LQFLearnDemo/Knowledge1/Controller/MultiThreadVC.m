//
//  MultiThreadVC.m
//  LQFLearnDemo
//
//  Created by liqunfei on 2017/7/26.
//  Copyright © 2017年 LQF. All rights reserved.
//

#import "MultiThreadVC.h"
#import "LQFSegmentHead.h"
#import "LQFSegmentScroll.h"
#import "LQFSegmentManager.h"

@interface MultiThreadVC () {
    NSArray *_segList;
}

@property (nonatomic, strong) LQFSegmentHead *segHead;
@property (nonatomic, strong) LQFSegmentScroll *segScroll;

@end

@implementation MultiThreadVC

- (void)viewDidLoad {
    self.quoteUrl = @"http://www.cocoachina.com/ios/20170707/19769.html";
    [self showSegView];
}

- (void)showSegView {
    _segList = @[@"NSThread",
                 @"CGD",
                 @"NSOperation"];
    
    _segHead = [[LQFSegmentHead alloc] initWithFrame:CGRectMake(0, 108, DEVICE_WIDTH, 40) titles:_segList headStyle:SegmentHeadStyleArrow layoutStyle:LQFSegmentLayoutCenter];
    _segHead.fontScale = 1.2;
    _segHead.fontSize = 14;
    _segHead.maxTitles = 3;
    
    _segScroll = [[LQFSegmentScroll alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_segHead.frame), DEVICE_WIDTH, DEVICE_HEIGHT - CGRectGetMaxY(_segHead.frame)) vcOrViews:[self vcArr:_segList.count]];
    _segScroll.loadAll = NO;
    
    [LQFSegmentManager associateHead:_segHead withScroll:_segScroll completion:^{
        [self.view addSubview:_segHead];
        [self.view addSubview:_segScroll];
    }];
}

#pragma mark - 数据源
- (NSArray *)vcArr:(NSInteger)count {
    NSMutableArray *arr = [NSMutableArray array];
    for (NSInteger i = 0; i < count; i++) {
        UIView *view = [UIView new];
        view.tag = 1000+i;
        [arr addObject:view];
    }
    return arr;
}

@end
