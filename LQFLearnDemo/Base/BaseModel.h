//
//  BaseModel.h
//  LQFLearnDemo
//
//  Created by liqunfei on 2017/7/13.
//  Copyright © 2017年 LQF. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BaseModel : NSObject

//防止 kvc 的时候 崩溃
- (void)setValue:(id)value forUndefinedKey:(NSString *)key ;
- (id)valueForUndefinedKey:(NSString *)key;

@end
