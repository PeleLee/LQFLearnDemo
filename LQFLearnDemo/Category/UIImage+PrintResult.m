//
//  UIImage+PrintResult.m
//  LQFLearnDemo
//
//  Created by liqunfei on 2017/9/14.
//  Copyright © 2017年 LQF. All rights reserved.
//

#import "UIImage+PrintResult.h"
#import <objc/message.h>

@implementation UIImage (PrintResult)

//load方法: 把类加载进内存的时候调用,只会调用一次
+ (void)load {
    Method imageNamedMethod = class_getClassMethod(self, @selector(imageNamed:));
    Method print_imageNamedMethod = class_getClassMethod(self, @selector(printResult_imageNamed:));
    
    //交换方法地址
    method_exchangeImplementations(imageNamedMethod, print_imageNamedMethod);
}

+ (UIImage *)printResult_imageNamed:(NSString *)name {
    UIImage *image = [UIImage printResult_imageNamed:name];
    if (image) {
        NSLog(@"加载图片%@成功",name);
    }
    else {
        NSLog(@"加载图片%@失败",name);
    }
    return image;
}

@end
