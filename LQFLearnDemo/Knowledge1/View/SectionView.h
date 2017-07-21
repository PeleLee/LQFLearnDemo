//
//  SectionView.h
//  LQFLearnDemo
//
//  Created by liqunfei on 2017/7/19.
//  Copyright © 2017年 LQF. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SectionModel;

typedef void(^CallBackBlock)(BOOL);

@interface SectionView : UITableViewHeaderFooterView

@property (nonatomic, strong) SectionModel *model;
@property (nonatomic, copy) CallBackBlock block;

@end
