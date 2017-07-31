//
//  LQFSegmentManager.m
//  LQFLearnDemo
//
//  Created by liqunfei on 2017/7/27.
//  Copyright © 2017年 LQF. All rights reserved.
//

#import "LQFSegmentManager.h"

@implementation LQFSegmentManager

+ (void)associateHead:(LQFSegmentHead *)head
           withScroll:(LQFSegmentScroll *)scroll
           completion:(void (^)())completion {
    [LQFSegmentManager associateHead:head withScroll:scroll contentChangeAni:YES completion:completion selectEnd:nil];
}

+ (void)associateHead:(LQFSegmentHead *)head
           withScroll:(LQFSegmentScroll *)scroll
     contentChangeAni:(BOOL)ani
           completion:(void(^)())completion
            selectEnd:(void(^)(NSInteger index))selectEnd {
    NSInteger showIndex;
    showIndex = head.showIndex?head.showIndex:scroll.showIndex;
    head.showIndex = showIndex;
    [head defaultAndCreateView];
}

@end
