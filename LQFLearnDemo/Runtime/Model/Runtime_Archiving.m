//
//  Runtime_Archiving.m
//  LQFLearnDemo
//
//  Created by liqunfei on 2017/9/18.
//  Copyright © 2017年 LQF. All rights reserved.
//

#import "Runtime_Archiving.h"

@implementation Runtime_Archiving

- (instancetype)initWithDict:(NSDictionary *)dict {
    if (self = [super init]) {
        [self setValue:dict[@"one"] forKey:@"proPerty1"];
        [self setValue:dict[@"two"] forKey:@"proPerty2"];
        [self setValue:dict[@"three"] forKey:@"proPerty3"];
        [self setValue:dict[@"four"] forKey:@"proPerty4"];
        [self setValue:dict[@"five"] forKey:@"proPerty5"];
    }
    return self;
}

@end
