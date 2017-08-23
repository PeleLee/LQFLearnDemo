//
//  LQFButton.m
//  LQFLearnDemo
//
//  Created by liqunfei on 2017/8/22.
//  Copyright © 2017年 LQF. All rights reserved.
//

#import "LQFButton.h"

@implementation LQFButton

- (CGRect)titleRectForContentRect:(CGRect)contentRect {
    if (CGRectIsEmpty(self.titleRect) || CGRectEqualToRect(self.titleRect, CGRectZero)) {
        return [super titleRectForContentRect:contentRect];
    }
    return self.titleRect;
}

- (CGRect)imageRectForContentRect:(CGRect)contentRect {
    if (CGRectIsEmpty(self.imageRect) || CGRectEqualToRect(self.imageRect, CGRectZero)) {
        return [super imageRectForContentRect:contentRect];
    }
    return self.imageRect;
}

@end
