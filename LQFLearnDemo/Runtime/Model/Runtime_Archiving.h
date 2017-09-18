//
//  Runtime_Archiving.h
//  LQFLearnDemo
//
//  Created by liqunfei on 2017/9/18.
//  Copyright © 2017年 LQF. All rights reserved.
//  归档与解归档

#import <Foundation/Foundation.h>

@interface Runtime_Archiving : NSObject

@property (nonatomic, strong) NSString *proPerty1;
@property (nonatomic, strong) NSString *proPerty2;
@property (nonatomic, strong) NSString *proPerty3;
@property (nonatomic, strong) NSString *proPerty4;
@property (nonatomic, strong) NSString *proPerty5;

- (instancetype)initWithDict:(NSDictionary *)dict;

@end
