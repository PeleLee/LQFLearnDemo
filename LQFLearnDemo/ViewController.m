//
//  ViewController.m
//  LQFLearnDemo
//
//  Created by liqunfei on 2017/7/13.
//  Copyright © 2017年 LQF. All rights reserved.
//

#import "ViewController.h"

static NSString *cellID = @"CELLID";

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource> {
    NSArray *_funcList;
}

@property (strong, nonatomic) UITableView *funcTV;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.hiddenBackBtn = YES;
    
    _funcList = @[@"Knowledge1",
                  @"K线图"];
    
    _funcTV = [[UITableView alloc] initWithFrame:CGRectMake(0, 65, DEVICE_WIDTH, DEVICE_HEIGHT - 65) style:UITableViewStylePlain];
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
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _funcList.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.1f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [_funcTV dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.textLabel.font = [UIFont systemFontOfSize:14.0];
        cell.backgroundColor = RGBA(247, 247, 247, 1);
    }
    cell.textLabel.text = _funcList[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        [self performSegueWithIdentifier:@"knowledge1" sender:self];
    }
    else if (indexPath.row == 1) {
        [self performSegueWithIdentifier:@"KLine" sender:self];
    }
}

- (BOOL)shouldAutorotate {
    return NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
