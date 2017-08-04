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
#import "MultiThreadView.h"

@interface MultiThreadVC () {
    NSArray *_segList;
}

@property (nonatomic, strong) LQFSegmentHead *segHead;
@property (nonatomic, strong) LQFSegmentScroll *segScroll;

@end

@implementation MultiThreadVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.quoteUrl = @"http://www.cocoachina.com/ios/20170707/19769.html";
    self.navTitle = @"多线程";
    
    [self showSegView];
}

- (void)showSegView {
    _segList = @[@"NSThread",
                 @"CGD",
                 @"NSOperation"];
//    _segList = @[@"NSThreadddddddddddddddddddd",
//                 @"CGD",
//                 @"AFNetworking",
//                 @"Test",
//                 @"Test",
//                 @"Demo"];
    
    _segHead = [[LQFSegmentHead alloc] initWithFrame:CGRectMake(0, 108, DEVICE_WIDTH, 40) titles:_segList headStyle:SegmentHeadStyleArrow layoutStyle:LQFSegmentLayoutCenter];
    _segHead.fontScale = .85;
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
        MultiThreadView *view = [MultiThreadView new];
        view.index = i;
        [arr addObject:view];
    }
    return arr;
}

@end
