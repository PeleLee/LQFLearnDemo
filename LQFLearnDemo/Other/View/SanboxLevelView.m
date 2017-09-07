//
//  SanboxLevelView.m
//  LQFLearnDemo
//
//  Created by liqunfei on 2017/8/30.
//  Copyright © 2017年 LQF. All rights reserved.
//

#import "SanboxLevelView.h"
#import "NSString+LQF.h"
#import "UIControl+SandBoxPath.h"

@interface SanboxLevelView()

@property (nonatomic, assign) CGFloat currentWidth;

@end

@implementation SanboxLevelView

- (instancetype)init {
    self = [super init];
    if (self) {
        _currentWidth = 0;
    }
    return self;
}

- (void)addLevel:(NSString *)name path:(NSString *)path {
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:button];
    
    CGFloat titleFont = 15;
    
    NSString *title = [NSString stringWithFormat:@"%@ >",name];
    CGSize size = [NSString calculateSizeWithText:title width:DEVICE_WIDTH font:titleFont];
    
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top);
        make.left.equalTo(self.mas_left).mas_offset(_currentWidth);
        make.bottom.equalTo(self.mas_bottom);
        make.width.mas_equalTo(size.width + 5);
    }];
    _currentWidth += size.width + 5;
    
    [button layoutIfNeeded];
    
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:MyBlue forState:UIControlStateNormal];

    [button.titleLabel setFont:[UIFont systemFontOfSize:titleFont]];
    
    [button setSandBoxPath:path];
    
    [button addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)click:(UIButton *)button {

}

@end
