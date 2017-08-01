//
//  LQFSegmentManager.m
//  LQFLearnDemo
//
//  Created by liqunfei on 2017/7/27.
//  Copyright © 2017年 LQF. All rights reserved.
//

#import "LQFSegmentManager.h"
#import "UIView+ViewController.h"

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
    showIndex = head.showIndex ? head.showIndex : scroll.showIndex;
    head.showIndex = showIndex;
    [head defaultAndCreateView];
    
    head.selectedIndex = ^(NSInteger index) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [scroll setContentOffset:CGPointMake(index *scroll.width, 0) animated:ani];
        });
    };
//    /*
    scroll.scrollEnd = ^(NSInteger index) {
        [head setSelectIndex:index];
        [head animationEnd];
        if (selectEnd && ani) {
            selectEnd(index);
        }
    };
    
    scroll.animationEnd = ^(NSInteger index) {
        [head setSelectIndex:index];
        [head animationEnd];
        if (selectEnd) {
            selectEnd(index);
        }
    };
    
    scroll.offSetScale = ^(CGFloat scale) {
        [head changePointScale:scale];
    };
    
    scroll.showIndex = showIndex;
    
    [scroll createView];
    
    UIView *view = head.nextResponder ? head : scroll;
    UIViewController *currentVC = [view viewController];
    currentVC.automaticallyAdjustsScrollViewInsets = NO;
    //     */
    
    if (completion) {
        completion();
    }
}

@end
