//
//  ViewController.m
//  LQFLearnDemo
//
//  Created by liqunfei on 2017/7/13.
//  Copyright © 2017年 LQF. All rights reserved.
//

#import "ViewController.h"
#import "ThirdPartVC.h"
#import "AnimationVC.h"
#import "RuntimeListVC.h"

static NSString *cellID = @"CELLID";

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource> {
    NSArray *_funcList;
    NSArray *_sectionList;
}

@property (strong, nonatomic) UITableView *funcTV;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.hiddenBackBtn = YES;
    self.view.backgroundColor = MainColor;
    
    _funcList = @[@[@"Other",
                    @"第三方库",
                    @"动画",
                    @"Runtime"],
                  @[@"K线图"]];
    
    _sectionList = @[@"Knowledge",
                     @"Projects"];
    
    _funcTV = [[UITableView alloc] initWithFrame:CGRectMake(0, 65, DEVICE_WIDTH, DEVICE_HEIGHT - 65) style:UITableViewStyleGrouped];
    _funcTV.delegate = self;
    _funcTV.dataSource = self;
    [self.view addSubview:_funcTV];
    
    //KVO监听 偏移量
    [_funcTV addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];
}

#pragma mark - KVO
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    CGFloat offset = -_funcTV.contentOffset.y;
    CGFloat delta = offset/100.0+1;
    delta = MAX(0, delta);
    delta = MIN(1, delta);
    self.navAlpha = delta;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _sectionList.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSArray *array = _funcList[section];
    return array.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 40.0f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UITableViewHeaderFooterView *headerView = [_funcTV dequeueReusableHeaderFooterViewWithIdentifier:@"headerID"];
    if (!headerView) {
        headerView = [[UITableViewHeaderFooterView alloc] initWithReuseIdentifier:@"headerID"];
        headerView.contentView.backgroundColor = MainColor;
    }
    
    UILabel *label = [UILabel new];
    [headerView.contentView addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.leading.mas_equalTo(0);
        make.trailing.equalTo(headerView);
        make.bottom.equalTo(headerView);
    }];
    
    label.font = [UIFont systemFontOfSize:13.0f];
    label.textColor = [UIColor darkGrayColor];
    label.text = _sectionList[section];
    label.textAlignment = NSTextAlignmentCenter;
    
    return headerView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [_funcTV dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.textLabel.font = [UIFont systemFontOfSize:14.0];
        cell.backgroundColor = [UIColor whiteColor];
    }
    NSArray *array = _funcList[indexPath.section];
    cell.textLabel.text = array[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            [self performSegueWithIdentifier:@"knowledge1" sender:self];
        }
        else if (indexPath.row == 1) {
            ThirdPartVC *thirdVC = [[ThirdPartVC alloc] init];
            [self.navigationController pushViewController:thirdVC animated:YES];
        }
        else if (indexPath.row == 2) {
            AnimationVC *animationVC = [[AnimationVC alloc] init];
            [self.navigationController pushViewController:animationVC animated:YES];
        }
        else if (indexPath.row == 3) {
            RuntimeListVC *runtimeVC = [[RuntimeListVC alloc] init];
            [self.navigationController pushViewController:runtimeVC animated:YES];
        }
    }
    else if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            [self performSegueWithIdentifier:@"KLine" sender:self];
        }
    }
}

- (BOOL)shouldAutorotate {
    return NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
