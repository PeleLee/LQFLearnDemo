//
//  LQFLineData.h
//  SelfStudyDemo
//
//  Created by liqunfei on 2017/7/10.
//  Copyright © 2017年 LQF. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LQFLineData : NSObject

@property (nonatomic, copy) NSArray *data;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, strong) UIColor *color;

- (id)initWithData:(NSMutableArray *)data color:(UIColor *)color title:(NSString *)title;

@end
