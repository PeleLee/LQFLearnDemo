//
//  LoadAnimationVC.m
//  LQFLearnDemo
//
//  Created by liqunfei on 2017/8/10.
//  Copyright © 2017年 LQF. All rights reserved.
//

#import "LoadAnimationVC.h"
#import "LQFProgressView.h"

@interface LoadAnimationVC () <UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UIView *showView;
@property (nonatomic, strong) UITableView *styleTV;
@property (nonatomic, strong) NSArray *styleList;
@property (nonatomic, strong) LQFProgressView *progressView;
@property (nonatomic, strong) NSTimer *timer;

@end

@implementation LoadAnimationVC

- (void)dealloc {
    [self removeTimer];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navTitle = @"载入动画";
    self.view.backgroundColor = [UIColor whiteColor];
    
    _styleList = @[@"圆形进度",
                   @"下载样式",
                   @"波浪式进度"];
    
    [self buildShowView];
    [self buildTableView];
}

- (void)buildShowView {
    _showView = [UIView new];
    [self.view addSubview:_showView];
    
    [_showView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.mas_equalTo(65 + 30 + 75);
        make.width.mas_equalTo(150);
        make.height.mas_equalTo(150);
    }];
}

- (void)buildTableView {
    _styleTV = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    [self.view addSubview:_styleTV];
    
    [_styleTV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_showView.mas_bottom).mas_offset(30);
        make.centerX.mas_equalTo(self.view);
        make.bottom.equalTo(self.view);
        make.width.equalTo(self.view);
    }];
    
    _styleTV.separatorColor = [UIColor clearColor];
    _styleTV.delegate = self;
    _styleTV.dataSource = self;
}

#pragma mark UITableView

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _styleList.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 30;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [_styleTV dequeueReusableCellWithIdentifier:@"cellID"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellID"];
        cell.selectionStyle = UITableViewCellSelectionStyleBlue;
        
        UILabel *styleLabel = [UILabel new];
        [cell addSubview:styleLabel];
        
        UIEdgeInsets padding = UIEdgeInsetsMake(0, 0, 0, 0);
        [styleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(cell).insets(padding);
        }];
        
        styleLabel.textAlignment = NSTextAlignmentCenter;
        styleLabel.font = [UIFont systemFontOfSize:13.0f];
        styleLabel.tag = 1000;
    }
    
    UILabel *label = (UILabel *)[cell viewWithTag:1000];
    label.text = _styleList[indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    _progressView.progress = 0;
    [self removeTimer];
    
    if (!_progressView) {
        _progressView = [LQFProgressView new];
        [_showView addSubview:_progressView];
        
        UIEdgeInsets padding = UIEdgeInsetsMake(0, 0, 0, 0);
        [_progressView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(_showView).insets(padding);
        }];
    }
    
    //调用之后才能获取空间的frame
    [_progressView layoutIfNeeded];
    
    if (indexPath.row == 0) {
        _progressView.style = ProgressStyle_Circle;
        _progressView.progress = 0;
    }
    else if (indexPath.row == 1) {
        _progressView.style = ProgressStyle_Install;
        _progressView.progress = 0;
    }
    else if (indexPath.row == 2) {
        _progressView.style = ProgressStyle_Wave;
    }
    
    _timer = [NSTimer scheduledTimerWithTimeInterval:0.2f target:self selector:@selector(timeAction) userInfo:nil repeats:YES];
}

- (void)timeAction {
    _progressView.progress += 0.02;
    if (_progressView.progress >= 1) {
        [self removeTimer];
        [_progressView removeFromSuperview];
    }
}

- (void)removeTimer {
    [_timer invalidate];
    _timer = nil;
    [_progressView removeFromSuperview];
    _progressView = nil;
}

@end
