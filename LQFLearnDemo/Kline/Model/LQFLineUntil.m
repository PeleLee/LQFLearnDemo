//
//  LQFLineUntil.m
//  SelfStudyDemo
//
//  Created by liqunfei on 2017/7/10.
//  Copyright © 2017年 LQF. All rights reserved.
//

#import "LQFLineUntil.h"

@implementation LQFLineUntil

- (id)initWithValue:(CGFloat)value date:(NSString *)date {
    self = [self init];
    
    if (self) {
        self.value = value;
        self.date = date;
    }
    return self;
}

@end
