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
        self.frame = CGRectMake(0, 0, DEVICE_WIDTH, 44);
        
        for (UIView *subView in self.contentView.subviews) {
            [subView removeFromSuperview];
        }
        
        self.arrowImage = [[UIImageView alloc] initWithFrame:CGRectMake(self.contentView.width - 20, (self.contentView.height - 10) / 2, 10, 10)];
        self.arrowImage.image = ImageNamed(@"arrow");
        [self.contentView addSubview:self.arrowImage];
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setFrame:self.bounds];
        [button addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:button];
        
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(30, 12, DEVICE_WIDTH - 74, 20)];
        self.titleLabel.font = [UIFont systemFontOfSize:14.0f];
        self.titleLabel.textColor = [UIColor blackColor];
        [self.contentView addSubview:self.titleLabel];
        
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(20, self.contentView.height - 1, self.contentView.width - 20, 1)];
        line.backgroundColor = [UIColor lightGrayColor];
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
        self.arrowImage.transform = CGAffineTransformIdentity;
    }
    else {
        self.arrowImage.transform = CGAffineTransformMakeRotation(-M_PI_2);
    }
}

- (void)btnClick:(UIButton *)sender {
    //非折叠操作
    if (!_model.isSupportExpand) {
        if (self.skipBlock) {
            self.skipBlock();
            return;
        }
    }
    
    //折叠操作
    self.model.isExpand = !self.model.isExpand;
    if (self.model.isExpand) {
        self.arrowImage.transform = CGAffineTransformIdentity;
    }
    else {
        self.arrowImage.transform = CGAffineTransformMakeRotation(-M_PI_2);
    }
    if (self.callBackBlock) {
        self.callBackBlock(self.model.isExpand);
    }
}

@end
