//
//  LQFCandleModel.h
//  SelfStudyDemo
//
//  Created by liqunfei on 2017/6/29.
//  Copyright © 2017年 LQF. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface LQFCandleModel : NSObject

@property (assign, nonatomic) CGFloat high;
@property (assign, nonatomic) CGFloat low;
@property (assign, nonatomic) CGFloat open;
@property (assign, nonatomic) CGFloat close;
@property (copy,   nonatomic) NSString *date;
@property (assign, nonatomic) BOOL isDrawDate;

@end
