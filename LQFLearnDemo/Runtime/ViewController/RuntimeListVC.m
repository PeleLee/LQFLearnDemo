//
//  RuntimeListVC.m
//  LQFLearnDemo
//
//  Created by liqunfei on 2017/9/14.
//  Copyright © 2017年 LQF. All rights reserved.
//

#import "RuntimeListVC.h"
#import "RuntimeVC1.h"
#import "RuntimeNavBarSetVC.h"

@interface RuntimeListVC () <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) NSArray *cellContents;
@property (nonatomic, strong) NSArray *selectContents;

@end

@implementation RuntimeListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self buildUI];
}

#pragma mark - set/get
- (NSArray *)cellContents {
    if (!_cellContents) {
        _cellContents = @[@"基础及常用",
                          @"导航栏样式"];
    }
    return _cellContents;
}

- (NSArray *)selectContents {
    if (!_selectContents) {
        _selectContents = @[@"RuntimeVC1",
                            @"RuntimeNavBarSetVC"];
    }
    return _selectContents;
}

#pragma mark - UI
- (void)buildUI {
    self.navTitle = @"runtime list";
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    [self.view addSubview:tableView];
    
    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(65);
        make.leading.bottom.trailing.equalTo(self.view);
    }];
    
    tableView.delegate = self;
    tableView.dataSource = self;
}

#pragma mark - UITableView About
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.cellContents.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        cell.textLabel.font = [UIFont systemFontOfSize:13.0f];
    }
    
    cell.textLabel.text = _cellContents[indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *className = self.selectContents[indexPath.row];
    
    if ([className isEqualToString:@"RuntimeVC1"]) {
        RuntimeVC1 *vc = [[RuntimeVC1 alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    else if ([className isEqualToString:@"RuntimeNavBarSetVC"]) {
        RuntimeNavBarSetVC *vc = [[RuntimeNavBarSetVC alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

#pragma mark -
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
