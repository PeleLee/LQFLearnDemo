//
//  LQFOperation.m
//  LQFLearnDemo
//
//  Created by liqunfei on 2017/8/2.
//  Copyright © 2017年 LQF. All rights reserved.
//

#import "LQFOperation.h"

@implementation LQFOperation

- (void)main {
    for (NSInteger i = 0; i < 3; i++) {
        NSLog(@"NSOperation的子类LQFOperation======%@",[NSThread currentThread]);
    }
}

@end
