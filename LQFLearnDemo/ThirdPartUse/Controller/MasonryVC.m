//
//  MasonryVC.m
//  LQFLearnDemo
//
//  Created by liqunfei on 2017/8/8.
//  Copyright © 2017年 LQF. All rights reserved.
//

#import "MasonryVC.h"
#import "NSString+LQF.h"

#define CurrentHeight _showScrollView.contentSize.height
#define SubViewColor  RGBA(255, 255, 240, 1)

@interface MasonryVC ()

@property (nonatomic, strong) UIScrollView *showScrollView;
@property (nonatomic, assign) NSInteger subIndex;
@property (nonatomic, strong) UIView *changeView;
@property (nonatomic, strong) NSString *updateOrRemake;

@end

@implementation MasonryVC

- (void)updateViewConstraints {
    if ([_updateOrRemake isEqualToString:@"update"]) {
        [_changeView mas_updateConstraints:^(MASConstraintMaker *make) {
            //中心偏移一点
            make.center.equalTo(_changeView.superview).centerOffset(CGPointMake(5, -10));
        }];
    }
    else if ([_updateOrRemake isEqualToString:@"remake"]) {
        //会先清除之前的约束
        [_changeView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(_changeView.superview);
            make.width.mas_equalTo(70);
            make.height.mas_equalTo(50);
        }];
    }
    
    [super updateViewConstraints];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navTitle = @"Masonry";
    self.quoteUrl = @"https://github.com/SnapKit/Masonry/blob/master/README.md";
    self.view.backgroundColor = [UIColor whiteColor];
    
    _showScrollView = [UIScrollView new];
    [self.view addSubview:_showScrollView];
    [_showScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left);
        make.top.equalTo(self.quoteButton.mas_bottom);
        make.right.equalTo(self.view.mas_right);
        make.bottom.equalTo(self.view.mas_bottom);
    }];
    _showScrollView.showsVerticalScrollIndicator = NO;
    _showScrollView.contentSize = CGSizeMake(DEVICE_WIDTH, 0);

    [self addSubViews];
}

#pragma mark - Subviews

- (void)addSubViews {
    _subIndex = 1;
    
    [self subView1];
    [self subView2];
    [self subView3];
    [self subView4];
}

#pragma mark mas_updateConstraints
- (void)subView4 {
    NSString *text = @"update & remake";
    [self buildLabelWithText:text];
    
    UILabel *label = (UILabel *)[_showScrollView viewWithTag:1000 + _subIndex - 1];
    
    //update
    UIButton *updateButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [updateButton setTitle:@"☞update" forState:UIControlStateNormal];
    [updateButton.titleLabel setFont:[UIFont systemFontOfSize:13]];
    [updateButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [updateButton addTarget:self action:@selector(update:) forControlEvents:UIControlEventTouchUpInside];
    [_showScrollView addSubview:updateButton];
    
    [updateButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(label.mas_right).mas_offset(@20);
        make.top.equalTo(label);
        make.height.equalTo(label);
        make.width.equalTo(@60);
    }];
    
    //remake
    UIButton *remakeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [remakeButton setTitle:@"☞remake" forState:UIControlStateNormal];
    [remakeButton.titleLabel setFont:[UIFont systemFontOfSize:13]];
    [remakeButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [remakeButton addTarget:self action:@selector(remake:) forControlEvents:UIControlEventTouchUpInside];
    [_showScrollView addSubview:remakeButton];
    
    [remakeButton mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(updateButton.mas_right).mas_offset(20);
        make.top.equalTo(updateButton);
        make.height.equalTo(updateButton);
        make.width.equalTo(@60);
    }];
    
    UIView *superView = [self createSuperView];
    
    _changeView = [UIView new];
    _changeView.backgroundColor = SubViewColor;
    _changeView.tag = 2000;
    [superView addSubview:_changeView];
    
    [_changeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@60);
        make.height.equalTo(@60);
        make.center.equalTo(superView);
    }];
    
    [self setContensizeWithHeight:CurrentHeight + DEVICE_WIDTH * 0.6 * 0.5 + 10];
}

- (void)update:(UIButton *)button {
    _updateOrRemake = @"update";
    [self updateViewConstraints];
}

- (void)remake:(UIButton *)button {
    _updateOrRemake = @"remake";
    [self updateViewConstraints];
}

#pragma mark center
- (void)subView3 {
    NSString *text = @"center";
    [self buildLabelWithText:text];
    
    UIView *superView = [self createSuperView];
    
    UIView *subView = [UIView new];
    [_showScrollView addSubview:subView];
    
    subView.backgroundColor = SubViewColor;
    
    [subView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@60);
        make.height.equalTo(@60);
        make.center.equalTo(superView).centerOffset(CGPointMake(-5, 10));
    }];
    
    [self setContensizeWithHeight:CurrentHeight + DEVICE_WIDTH * 0.6 * 0.5 + 10];
}

#pragma mark size
- (void)subView2 {
    NSString *text = @"size";
    [self buildLabelWithText:text];
    
    UIView *superView = [self createSuperView];
    
    UIView *subView = [UIView new];
    [superView addSubview:subView];
    
    subView.backgroundColor = SubViewColor;
    
    [subView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(superView.mas_left).mas_offset(10);
        make.top.equalTo(superView.mas_top).mas_offset(10);
        make.width.equalTo(@60);
        make.height.equalTo(@60);
    }];
    
    UIView *subView2 = [UIView new];
    [superView addSubview:subView2];
    
    subView2.backgroundColor = SubViewColor;
    
    [subView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(subView);
        make.left.equalTo(subView.mas_right).mas_offset(@10);
        make.size.equalTo(subView).sizeOffset(CGSizeMake(-10, -10));
    }];
    
    [self setContensizeWithHeight:CurrentHeight + DEVICE_WIDTH * 0.6 * 0.5 + 10];
}

#pragma mark edges
- (void)subView1 {
    NSString *text = @"edges";
    [self buildLabelWithText:text];
    
    UIView *superView = [self createSuperView];
    
    UIView *subView = [UIView new];
    subView.backgroundColor = SubViewColor;
    [superView addSubview:subView];
    
    UIEdgeInsets padding = UIEdgeInsetsMake(10, 10, 10, 10);
    //方法1
    /*
    [subView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(superView.mas_top).with.offset(padding.top);
        make.left.equalTo(superView.mas_left).with.offset(padding.left);
        make.bottom.equalTo(superView.mas_bottom).with.offset(-padding.left);
        make.right.equalTo(superView.mas_right).with.offset(-padding.right);
    }];
     */
    //方法2
    [subView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(superView).insets(padding);
    }];
    
    [self setContensizeWithHeight:CurrentHeight + DEVICE_WIDTH * 0.6 * 0.5 + 10];
}

#pragma mark - CreateSuperView

- (UIView *)createSuperView {
    UIView *superView = [UIView new];
    [_showScrollView addSubview:superView];
    [superView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@(DEVICE_WIDTH * 0.5));
        make.height.equalTo(@(DEVICE_WIDTH * 0.6 * 0.5));
        make.centerX.equalTo(_showScrollView.mas_centerX);
        make.top.equalTo(@(CurrentHeight));
    }];
    superView.backgroundColor = RGBA(135, 206, 250, 1);
    
    return superView;
}

#pragma mark - CreateLabel

- (void)buildLabelWithText:(NSString *)text {
    UILabel *indexLabel = [UILabel new];
    indexLabel.tag = 1000 + _subIndex;
    [_showScrollView addSubview:indexLabel];
    
    //根据内容计算size
    NSString *indexText = [NSString stringWithFormat:@"%ld、%@",(long)_subIndex,text];
    CGSize labelSize = [NSString calculateSizeWithText:indexText width:DEVICE_WIDTH - 40 font:13];
    
    indexLabel.text = indexText;
    indexLabel.font = [UIFont systemFontOfSize:13];
    
    [indexLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20);
        make.top.equalTo(@(CurrentHeight));
        make.width.equalTo(@(labelSize.width + 5));
        make.height.equalTo(@(labelSize.height));
    }];
    
    [self setContensizeWithHeight:CurrentHeight + labelSize.height + 10];
    _subIndex++;
}

#pragma mark - 设置scrollview的contentsize

- (void)setContensizeWithHeight:(float)height {
    _showScrollView.contentSize = CGSizeMake(DEVICE_WIDTH, height);
}

@end
