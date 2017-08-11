//
//  SectionView.h
//  LQFLearnDemo
//
//  Created by liqunfei on 2017/7/19.
//  Copyright © 2017年 LQF. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SectionModel;

/**
 折叠操作

 @param isFold 折叠状态
 */
typedef void(^CallBackBlock)(BOOL isFold);

/**
 执行非折叠操作
 */
typedef void(^SkipBlock)();

@interface SectionView : UITableViewHeaderFooterView

@property (nonatomic, strong) SectionModel *model;
@property (nonatomic, copy) CallBackBlock callBackBlock;
@property (nonatomic, copy) SkipBlock skipBlock;

@end
