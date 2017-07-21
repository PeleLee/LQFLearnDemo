//
//  LQFTecnnicalView.h
//  LQFLearnDemo
//
//  Created by liqunfei on 2017/7/14.
//  Copyright © 2017年 LQF. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LQFTecnnicalViewDelegate <NSObject>

- (void)didSelectButton:(UIButton *)button index:(NSInteger)index;

@end

@interface LQFTecnnicalView : UIView

@property (nonatomic, strong) UIButton *macdButton;
@property (nonatomic, strong) UIButton *wrButton;
@property (nonatomic, strong) UIButton *kdjButton;
@property (nonatomic, weak)   id <LQFTecnnicalViewDelegate> delegate;

@end
