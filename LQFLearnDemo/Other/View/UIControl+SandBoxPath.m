//
//  UIControl+SandBoxPath.m
//  LQFLearnDemo
//
//  Created by liqunfei on 2017/8/30.
//  Copyright © 2017年 LQF. All rights reserved.
//

#import "UIControl+SandBoxPath.h"
#import "objc/runtime.h"

static const void *sandBoxBy = &sandBoxBy;

@implementation UIControl (SandBoxPath)
@dynamic sandBoxPath;

- (void)setSandBoxPath:(NSString *)sandBoxPath {
    objc_setAssociatedObject(self, sandBoxBy, sandBoxPath, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (NSString *)sandBoxPath {
    return objc_getAssociatedObject(self, sandBoxBy);
}

@end
