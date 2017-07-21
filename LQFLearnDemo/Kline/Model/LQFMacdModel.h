//
//  LQFMacdModel.h
//  SelfStudyDemo
//
//  Created by liqunfei on 2017/7/10.
//  Copyright © 2017年 LQF. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LQFMacdModel : NSObject

@property (assign, nonatomic) CGFloat dea;
@property (assign, nonatomic) CGFloat diff;
@property (assign, nonatomic) CGFloat macd;
@property (copy,   nonatomic) NSString *date;

- (id)initWithDea:(CGFloat)dea diff:(CGFloat)diff macd:(CGFloat)macd date:(NSString *)date;

@end
