//
//  Person.h
//  LQFLearnDemo
//
//  Created by liqunfei on 2017/7/13.
//  Copyright © 2017年 LQF. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Dog;

@interface Person : BaseModel

@property (nonatomic, copy)   NSString *name;
@property (nonatomic, assign) int age;

@property (nonatomic, strong) Dog *dog;
@property (nonatomic, strong) NSArray *dogs;

- (void)printHeight;

@end
