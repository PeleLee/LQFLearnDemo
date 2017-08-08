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

/**
 根据内容计算label的size

 @param text 内容文字
 @param width 最大宽度
 @param font 字体
 @return 计算好的size
 */
+ (CGSize)calculateSizeWithText:(NSString *)text
                          width:(CGFloat)width
                           font:(CGFloat)font;

@end
