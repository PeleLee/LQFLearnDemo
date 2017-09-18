//
//  Runtime_Archiving2.m
//  LQFLearnDemo
//
//  Created by liqunfei on 2017/9/18.
//  Copyright © 2017年 LQF. All rights reserved.
//

#import "Runtime_Archiving2.h"
#import <objc/runtime.h>

#define encodeRuntime(A) \
\
unsigned int count = 0;\
Ivar *ivarList = class_copyIvarList([A class], &count);\
\
for (NSInteger i = 0; i < count; i++) {\
    Ivar ivar = ivarList[i];\
    NSString *key = [NSString stringWithUTF8String:ivar_getName(ivar)];\
    id value = [self valueForKey:key];\
    [encoder encodeObject:value forKey:key];\
}\
free(ivarList);\
\

#define initCoderRuntime(A) \
\
if (self = [super init]) {\
    unsigned int count = 0;\
    Ivar *ivarList = class_copyIvarList([A class], &count);\
    for (NSInteger i = 0; i < count; i++) {\
        Ivar ivar = ivarList[i];\
        const char *name = ivar_getName(ivar);\
        NSString *key = [NSString stringWithUTF8String:name];\
        id value = [aDecoder decodeObjectForKey:key];\
        [self setValue:value forKey:key];\
    }\
    free(ivarList);\
}\
return self;\
\

@implementation Runtime_Archiving2

- (void)encodeWithCoder:(NSCoder *)encoder {
    /*写法一
    unsigned int count = 0;
    Ivar *ivarList = class_copyIvarList([self class], &count);
    
    for (NSInteger i = 0; i < count; i++) {
        Ivar ivar = ivarList[i];
        NSString *key = [NSString stringWithUTF8String:ivar_getName(ivar)];
        id value = [self valueForKey:key];
        [encoder encodeObject:value forKey:key];
    }
    free(ivarList);
    */
    //写法二
    encodeRuntime(self);
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    //写法一
    /*
    if (self = [super init]) {
        unsigned int count = 0;
        Ivar *ivarList = class_copyIvarList([self class], &count);
        for (NSInteger i = 0; i < count; i++) {
            Ivar ivar = ivarList[i];
            const char *name = ivar_getName(ivar);
            NSString *key = [NSString stringWithUTF8String:name];
            id value = [aDecoder decodeObjectForKey:key];
            [self setValue:value forKey:key];
        }
        free(ivarList);
    }
    return self;*/
    initCoderRuntime(self);
}

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
