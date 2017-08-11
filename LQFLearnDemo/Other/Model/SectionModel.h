//
//  SectionModel.h
//  LQFLearnDemo
//
//  Created by liqunfei on 2017/7/19.
//  Copyright © 2017年 LQF. All rights reserved.
//

#import "BaseModel.h"

@interface SectionModel : BaseModel

/**
 是否支持折叠
 */
@property (nonatomic, assign) BOOL isSupportExpand;
/**
 折叠状态
 */
@property (nonatomic, assign) BOOL isExpand;

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSArray *cellArray;
/**
 Storyboard中跳转时使用
 */
@property (nonatomic, strong) NSString *segID;
@property (nonatomic, strong) NSString *VCName;

@end
