//
//  iOS10VC.m
//  LQFLearnDemo
//
//  Created by liqunfei on 2017/8/22.
//  Copyright © 2017年 LQF. All rights reserved.
//

#import "iOS10VC.h"
#import "NSString+LQF.h"

@interface iOS10VC () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *contentTV;

@property (nonatomic, strong) NSArray *contentArray;

@end

@implementation iOS10VC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navTitle = @"iOS 10";
    
    _contentArray = @[@"新增UserNotifications Framework."];
    
    [self buildUI];
}

- (void)buildUI {
    _contentTV = [UITableView new];
    [self.view addSubview:_contentTV];
    
    UIEdgeInsets padding = UIEdgeInsetsMake(65, 0, 0, 0);
    [_contentTV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).insets(padding);
    }];
    
    _contentTV.delegate = self;
    _contentTV.dataSource = self;
}

#pragma mark - UITableView

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _contentArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *content = _contentArray[indexPath.row];
    CGSize size = [NSString calculateSizeWithText:content width:(DEVICE_WIDTH - 40) font:13];
    return (size.height + 20) > 40 ? (size.height + 20) : 40;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (section == 0) {
        return 0.1;
    }
    else {
        return 0;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 0.1;
    }
    else {
        return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [_contentTV dequeueReusableCellWithIdentifier:@"cellID"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellID"];
        cell.textLabel.font = SystemFont(13);
        cell.textLabel.numberOfLines = 0;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    NSString *content = _contentArray[indexPath.row];
    
    cell.textLabel.text = content;
    
    return cell;
}

@end
