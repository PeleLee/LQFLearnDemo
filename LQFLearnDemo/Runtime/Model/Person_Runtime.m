//
//  Person_Runtime.m
//  LQFLearnDemo
//
//  Created by liqunfei on 2017/9/14.
//  Copyright © 2017年 LQF. All rights reserved.
//

#import "Person_Runtime.h"

@implementation Person_Runtime

- (void)eat {
    NSLog(@"--------eat-------");
}

+ (void)runM:(NSInteger)param {
    NSLog(@"--------run:%ld-------",(long)param);
}

@end
