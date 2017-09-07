//
//  ThreadTestView.m
//  LQFLearnDemo
//
//  Created by liqunfei on 2017/9/1.
//  Copyright © 2017年 LQF. All rights reserved.
//

#import "ThreadTestView.h"

@interface ThreadTestView()

@property (nonatomic, assign) CGFloat hight;
@property (nonatomic, strong) UIView *view1;
@property (nonatomic, strong) UIView *view2;

@end

@implementation ThreadTestView

- (instancetype)init {
    self = [super init];
    if (self) {
        
        _hight = 0;
        
    }
    return self;
}

- (void)begin {
    [self createView1];
    [self createView2];
}

- (void)createView1 {
    
    _view1 = [UIView new];
    [self addSubview:_view1];
    
    [_view1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self);
        make.centerX.equalTo(self);
        make.width.mas_equalTo(70);
        make.height.mas_equalTo(70);
    }];
    
    _view1.backgroundColor = [UIColor yellowColor];
    
    dispatch_queue_t queue = dispatch_queue_create("test", DISPATCH_QUEUE_CONCURRENT);
    
    dispatch_async(queue, ^{
        [NSThread sleepForTimeInterval:1.5];
        
        _hight = 70;
    });
    
}

- (void)createView2 {
    _view2 = [UIView new];
    [self addSubview:_view2];
    
    [_view2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_hight);
        make.left.equalTo(_view2.mas_right);
        make.width.mas_equalTo(70);
        make.height.mas_equalTo(70);
    }];

    _view2.backgroundColor = [UIColor lightGrayColor];
}

@end
