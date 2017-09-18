//
//  Person_Runtime.m
//  LQFLearnDemo
//
//  Created by liqunfei on 2017/9/14.
//  Copyright © 2017年 LQF. All rights reserved.
//

#import "Person_Runtime.h"
#import <objc/runtime.h>

@implementation Person_Runtime

- (void)eat {
    NSLog(@"--------eat-------");
}

+ (void)runM:(NSInteger)param {
    NSLog(@"--------run:%ld-------",(long)param);
}
#pragma mark -
+ (instancetype)modelWithDict:(NSDictionary *)dict {
    id objc = [[self alloc] init];
    
    unsigned int count = 0;
    Ivar *ivarList = class_copyIvarList(self, &count);
    
    for (NSInteger i = 0; i < count; i++) {
        Ivar ivar = ivarList[i];
        //变量名称
        NSString *ivarName = [NSString stringWithUTF8String:ivar_getName(ivar)];
        
        NSString *key = [ivarName substringFromIndex:1];
        
        id value = dict[key];
        
        if (value) {
            [objc setValue:value forKey:key];
        }
    }
    
    return objc;
}

+ (instancetype)modelWithDict2:(NSDictionary *)dict {
    id objc = [[self alloc] init];
    
    unsigned int count = 0;
    
    Ivar *ivarList = class_copyIvarList(self, &count);
    
    for (NSInteger i = 0; i < count; i++) {
        Ivar ivar = ivarList[i];
        
        NSString *ivarName = [NSString stringWithUTF8String:ivar_getName(ivar)];
        //变量类型
        NSString *ivarType = [NSString stringWithUTF8String:ivar_getTypeEncoding(ivar)];
    
        ivarType = [ivarType stringByReplacingOccurrencesOfString:@"\"" withString:@""];
        ivarType = [ivarType stringByReplacingOccurrencesOfString:@"@" withString:@""];
        
        NSString *key = [ivarName substringFromIndex:1];
        
        id value = dict[key];
        
        if ([value isKindOfClass:[NSDictionary class]] && ![ivarType hasPrefix:@"NS"]) {
            Class modelClass = NSClassFromString(ivarType);
            if (modelClass) {
                value = [modelClass modelWithDict2:value];
            }
        }
        
        if (value) {
            [objc setValue:value forKey:key];
        }
    }
    
    return objc;
}

+ (instancetype)modelWithDict3:(NSDictionary *)dict {
    id objc = [[self alloc] init];
    unsigned int count = 0;
    Ivar *ivarList = class_copyIvarList(self, &count);
    
    for (NSInteger i = 0; i < count; i++) {
        Ivar ivar = ivarList[i];
        
        NSString *ivarName = [NSString stringWithUTF8String:ivar_getName(ivar)];
        NSString *key = [ivarName substringFromIndex:1];
        id value = dict[key];
        
        if ([value isKindOfClass:[NSArray class]]) {
            
            if ([self respondsToSelector:@selector(arrayContainModelClass)]) {
                NSString *type = [self arrayContainModelClass][key];
                
                Class classModel = NSClassFromString(type);
                NSMutableArray *arrM = [NSMutableArray array];
                for (NSDictionary *dict in value) {
                    id model = [classModel modelWithDict3:dict];
                    [arrM addObject:model];
                }
                value = arrM;
            }
        }
        if (value) {
            [objc setValue:value forKey:key];
        }
    }
    return objc;
}

//【用在三级数组转换】
+ (NSDictionary *)arrayContainModelClass
{
    return @{@"pic_urls" : @"Runtime_Array"};
}
#pragma mark -
void bbb(id self, SEL _cmd, NSNumber *meter) {
    NSLog(@"跑了%@米",meter);
}

+ (BOOL)resolveInstanceMethod:(SEL)sel {
    if (sel == NSSelectorFromString(@"run:")) {
        class_addMethod(self, sel, (IMP)bbb, "v@:@");
        return YES;
    }
    return [super resolveInstanceMethod:sel];
}
@end
