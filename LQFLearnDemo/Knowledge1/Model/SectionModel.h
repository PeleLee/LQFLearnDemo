//
//  SectionModel.h
//  LQFLearnDemo
//
//  Created by liqunfei on 2017/7/19.
//  Copyright © 2017年 LQF. All rights reserved.
//

#import "BaseModel.h"

@interface SectionModel : BaseModel

@property (nonatomic, assign) BOOL isExpand;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSArray *cellArray;

@end
