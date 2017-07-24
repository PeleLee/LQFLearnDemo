//
//  LQFPopTool.h
//  LQFLearnDemo
//
//  Created by liqunfei on 2017/7/24.
//  Copyright © 2017年 LQF. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LQFPopTool : NSObject

+ (instancetype)sharedInstance;

/**
 弹出视图

 @param view 被弹出的视图
 @param animated 是否需要动画
 */
- (void)popView:(UIView *)view animated:(BOOL)animated;

/**
 关闭视图

 @param animated 是否需要动画
 */
- (void)closeAnimated:(BOOL)animated;

@end
