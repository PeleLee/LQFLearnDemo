//
//  LQFLineData.m
//  SelfStudyDemo
//
//  Created by liqunfei on 2017/7/10.
//  Copyright © 2017年 LQF. All rights reserved.
//

#import "LQFLineData.h"

@implementation LQFLineData

- (id)initWithData:(NSMutableArray *)data color:(UIColor *)color title:(NSString *)title {
    self = [self init];
    if (self) {
        self.data = data;
        self.color = color;
        self.title = title;
    }
    return self;
}

@end
