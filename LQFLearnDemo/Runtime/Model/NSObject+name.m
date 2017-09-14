//
//  NSObject+name.m
//  LQFLearnDemo
//
//  Created by liqunfei on 2017/9/14.
//  Copyright © 2017年 LQF. All rights reserved.
//

#import "NSObject+name.h"
#import <objc/runtime.h>

@implementation NSObject (name)

- (NSString *)name {
    return objc_getAssociatedObject(self, @"name");
}

- (void)setName:(NSString *)name {
    objc_setAssociatedObject(self, @"name", name, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

@end
