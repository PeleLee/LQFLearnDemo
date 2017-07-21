//
//  LQFLineUntil.h
//  SelfStudyDemo
//
//  Created by liqunfei on 2017/7/10.
//  Copyright © 2017年 LQF. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LQFLineUntil : NSObject

@property (assign, nonatomic) CGFloat value;
@property (retain, nonatomic) NSString *date;

- (id)initWithValue:(CGFloat)value date:(NSString *)date;

@end
