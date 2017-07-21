//
//  SectionView.m
//  LQFLearnDemo
//
//  Created by liqunfei on 2017/7/19.
//  Copyright © 2017年 LQF. All rights reserved.
//

#import "SectionView.h"
#import "SectionModel.h"

@interface SectionView()

@property (nonatomic, strong) UIImageView *arrowImage;
@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation SectionView

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        self.arrowImage = [[UIImageView alloc] initWithFrame:CGRectMake(DEVICE_WIDTH - 44, 12, 11, 20)];
        self.arrowImage.image = ImageNamed(@"arrow");
        [self.contentView addSubview:self.arrowImage];
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setFrame:CGRectMake(0, 0, DEVICE_WIDTH, 44)];
        [button addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:button];
        
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(30, 12, DEVICE_WIDTH - 74, 20)];
        self.titleLabel.font = [UIFont systemFontOfSize:14.0f];
        self.titleLabel.textColor = [UIColor blackColor];
        [self.contentView addSubview:self.titleLabel];
        
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 43, DEVICE_WIDTH, 1)];
        line.backgroundColor = [UIColor darkGrayColor];
        [self.contentView addSubview:line];
    }
    return self;
}

- (void)setModel:(SectionModel *)model {
    if (_model != model) {
        _model = model;
    }
    self.titleLabel.text = model.title;
    if (model.isExpand) {
        self.arrowImage.transform = CGAffineTransformMakeRotation(M_PI_2);
    }
    else {
        self.arrowImage.transform = CGAffineTransformIdentity;
    }
}

- (void)btnClick:(UIButton *)sender {
    self.model.isExpand = !self.model.isExpand;
    if (self.model.isExpand) {
        self.arrowImage.transform = CGAffineTransformMakeRotation(M_PI_2);
    }
    else {
        self.arrowImage.transform = CGAffineTransformIdentity;
    }
    if (self.block) {
        self.block(self.model.isExpand);
    }
}

@end
