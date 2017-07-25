//
//  LQFPopTool.m
//  LQFLearnDemo
//
//  Created by liqunfei on 2017/7/24.
//  Copyright © 2017年 LQF. All rights reserved.
//

#import "LQFPopTool.h"

@interface LQFPopTool();

/**
 当前弹出的view
 */
@property (nonatomic, strong) UIView *currentView;

@end

@implementation LQFPopTool

+ (instancetype)sharedInstance {
    static LQFPopTool *_popTool = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _popTool = [[LQFPopTool alloc] init];
    });
    return _popTool;
}

- (void)popView:(UIView *)view animated:(BOOL)animated {
    _currentView = view;
    CGFloat halfScreenWidth = DEVICE_WIDTH * 0.5;
    CGFloat halfScreenHeight = DEVICE_HEIGHT * 0.5;
    CGPoint screenCenter = CGPointMake(halfScreenWidth, halfScreenHeight);
    view.center = screenCenter;
    
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    [keyWindow addSubview:view];
    
    if (animated) {
        //将view宽高缩至无限小
        view.transform = CGAffineTransformScale(CGAffineTransformIdentity, CGFLOAT_MIN, CGFLOAT_MIN);
        [UIView animateWithDuration:0.3 animations:^{
           //将view放大至原始大小的1.2倍
            view.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.2, 1.2);
        } completion:^(BOOL finished) {
            //将view恢复至原始大小
            [UIView animateWithDuration:0.2 animations:^{
                view.transform = CGAffineTransformIdentity;
            }];
        }];
    }
}

- (void)closeAnimated:(BOOL)animated {
    if (animated) {
        [UIView animateWithDuration:0.2 animations:^{
            _currentView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.2, 1.2);
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.3 animations:^{
                _currentView.transform = CGAffineTransformScale(CGAffineTransformIdentity, CGFLOAT_MIN, CGFLOAT_MIN);
            } completion:^(BOOL finished) {
                [_currentView removeFromSuperview];
            }];
        }];
    }
    else {
        [_currentView removeFromSuperview];
    }
}

@end
