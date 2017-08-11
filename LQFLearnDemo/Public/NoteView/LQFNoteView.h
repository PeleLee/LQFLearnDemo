//
//  LQFNoteView.h
//  LQFLearnDemo
//
//  Created by liqunfei on 2017/8/11.
//  Copyright © 2017年 LQF. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LQFNoteView : UITextView

/**
 增加一个标题

 @param title 标题
 */
- (void)addTitle:(NSString *)title;
/**
 增加普通

 @param content 内容
 */
- (void)addContent:(NSString *)content;
/**
 增加名词
 @param noun 红色文字
 */
- (void)addNounText:(NSString *)noun;

/**
 结束编辑
 */
- (void)endEdit;

@end
