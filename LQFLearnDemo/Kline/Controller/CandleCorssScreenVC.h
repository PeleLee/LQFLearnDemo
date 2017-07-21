//
//  CandleCorssScreenVC.h
//  LQFLearnDemo
//
//  Created by liqunfei on 2017/7/20.
//  Copyright © 2017年 LQF. All rights reserved.
//

#import "BaseViewController.h"

@class CandleCorssScreenVC;

@protocol CandleCrossScreenVCDelegate <NSObject>

- (void)willChangeScreenModel:(CandleCorssScreenVC *)vc;

@end

@interface CandleCorssScreenVC : BaseViewController

@property (assign, nonatomic) UIInterfaceOrientation orientation;
@property (nonatomic, weak) id <CandleCrossScreenVCDelegate>delegate;

@end
