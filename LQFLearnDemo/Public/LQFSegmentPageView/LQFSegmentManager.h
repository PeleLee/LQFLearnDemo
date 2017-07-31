//
//  LQFSegmentManager.h
//  LQFLearnDemo
//
//  Created by liqunfei on 2017/7/27.
//  Copyright © 2017年 LQF. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LQFSegmentHead.h"
#import "LQFSegmentScroll.h"

@interface LQFSegmentManager : NSObject

//绑定head和scroll
+ (void)associateHead:(LQFSegmentHead *)head
           withScroll:(LQFSegmentScroll *)scroll
           completion:(void(^)())completion;

@end
