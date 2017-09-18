//
//  Person_Runtime.h
//  LQFLearnDemo
//
//  Created by liqunfei on 2017/9/14.
//  Copyright © 2017年 LQF. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Runtime_User;

@interface Person_Runtime : NSObject

@property (nonatomic, strong) NSNumber *attitudes_count;
@property (nonatomic, strong) NSNumber *comments_count;
@property (nonatomic, strong) NSString *created_at;
@property (nonatomic, strong) NSString *idstr;

@property (nonatomic, strong) Runtime_User *user;

- (void)eat;

+ (void)runM:(NSInteger)param;

+ (instancetype)modelWithDict:(NSDictionary *)dict;
+ (instancetype)modelWithDict2:(NSDictionary *)dict;

@end
