//
//  LQFQuotaView.m
//  SelfStudyDemo
//
//  Created by liqunfei on 2017/6/29.
//  Copyright © 2017年 LQF. All rights reserved.
//

#import "LQFQuotaView.h"

@interface LQFQuotaView()

@property (nonatomic, strong) UILabel *highLabel;
@property (nonatomic, strong) UILabel *lowLabel;
@property (nonatomic, strong) UILabel *openLabel;
@property (nonatomic, strong) UILabel *closeLabel;

@end

@implementation LQFQuotaView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubViews];
        [self addConstraints];
    }
    return self;
}

- (void)setModel:(LQFCandleModel *)model {
    _model = model;
    _highLabel.text = [NSString stringWithFormat:@"%@%.2f",@"最高价:",_model.high];
    _lowLabel.text = [NSString stringWithFormat:@"%@%.2f",@"最低价:",_model.low];
    _openLabel.text = [NSString stringWithFormat:@"%@%.2f",@"开盘价:",_model.open];
    _closeLabel.text = [NSString stringWithFormat:@"%@%.2f",@"收盘价:",_model.close];
}

- (void)addSubViews {
    _highLabel = [self createLabel];
    [self addSubview:_highLabel];
    
    _lowLabel = [self createLabel];
    [self addSubview:_lowLabel];
    
    _openLabel = [self createLabel];
    [self addSubview:_openLabel];
    
    _closeLabel = [self createLabel];
    [self addSubview:_closeLabel];
}

- (UILabel *)createLabel {
    UILabel *label = [UILabel new];
    label.textColor = [UIColor whiteColor];
    label.font = [UIFont systemFontOfSize:14];
    return label;
}

- (void)addConstraints {
    [_highLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX).multipliedBy(0.5);
        make.top.equalTo(@(40));
    }];
    
    [_lowLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX).multipliedBy(1.5);
        make.top.equalTo(_highLabel);
    }];
    
    [_openLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_highLabel);
        make.top.equalTo(_highLabel.mas_bottom).offset(10);
    }];
    
    [_closeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_lowLabel);
        make.top.equalTo(_lowLabel.mas_bottom).offset(10);
    }];
}

@end
