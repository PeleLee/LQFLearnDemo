//
//  NSString+LQF.h
//  LQFLearnDemo
//
//  Created by liqunfei on 2017/8/7.
//  Copyright © 2017年 LQF. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (LQF)

/**
 给字符串加引号

 @param str 待处理的字符串
 @return 加引号后的字符串
 */
+ (NSString *)addQuotationMark:(NSString *)str;

@end
