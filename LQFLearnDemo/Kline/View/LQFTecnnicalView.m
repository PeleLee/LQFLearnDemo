//
//  LQFTecnnicalView.m
//  LQFLearnDemo
//
//  Created by liqunfei on 2017/7/14.
//  Copyright © 2017年 LQF. All rights reserved.
//

#import "LQFTecnnicalView.h"

@interface LQFTecnnicalView()

@property (nonatomic, assign) NSInteger currentButtonTag;

@end

@implementation LQFTecnnicalView

- (UIButton *)macdButton {
    if (!_macdButton) {
        _macdButton = [self createButtonWithTag:1];
        [self addSubview:_macdButton];
        _macdButton.backgroundColor = [UIColor colorWithHexString:@"EE3B3B"];
        _macdButton.selected = YES;
        _currentButtonTag = _macdButton.tag;
        [_macdButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.left.top.equalTo(self);
            make.width.equalTo(@(60));
        }];
    }
    return _macdButton;
}

- (UIButton *)wrButton {
    if (!_wrButton) {
        _wrButton = [self createButtonWithTag:2];
        [self addSubview:_wrButton];
        [_wrButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.top.equalTo(self.macdButton);
            make.left.equalTo(self.macdButton.mas_right);
        }];
    }
    return _wrButton;
}

- (UIButton *)kdjButton {
    if (!_kdjButton) {
        _kdjButton = [self createButtonWithTag:3];
        [self addSubview:_kdjButton];
        [_kdjButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.top.equalTo(self.wrButton);
            make.left.equalTo(self.wrButton.mas_right);
        }];
    }
    return _kdjButton;
}

#pragma mark private
- (UIButton *)createButtonWithTag:(NSInteger)tag {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.tag = tag;
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button.titleLabel setFont:[UIFont systemFontOfSize:13.f]];
    button.backgroundColor = [UIColor colorWithHexString:@"EE6363"];
    [button addTarget:self action:@selector(didClick:) forControlEvents:UIControlEventTouchUpInside];
    return button;
}

- (void)didClick:(UIButton *)button {
    if (_currentButtonTag == button.tag) {
        return;
    }
    button.selected = !button.selected;
    UIButton *prevButton = [self viewWithTag:_currentButtonTag];
    prevButton.backgroundColor = [UIColor colorWithHexString:@"EE6363"];
    prevButton.selected = NO;
    button.backgroundColor = [UIColor colorWithHexString:@"EE3B3B"];
    _currentButtonTag = button.tag;
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(didSelectButton:index:)]) {
        [self.delegate didSelectButton:button index:button.tag];
    }
}

@end
