//
//  SandboxVC.m
//  LQFLearnDemo
//
//  Created by liqunfei on 2017/8/30.
//  Copyright © 2017年 LQF. All rights reserved.
//

#import "SandboxVC.h"
#import "SanboxLevelView.h"

@interface SandboxVC () <UITableViewDelegate,UITableViewDataSource>

/**
 层级view
 */
@property (nonatomic, strong) SanboxLevelView *levelView;
/**
 当前目录下的文件数
 */
@property (nonatomic, strong) NSArray *showPathArray;
/**
 当前路径
 */
@property (nonatomic, strong) NSString *currentPath;

@end

@implementation SandboxVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self searchPath];
    
    [self buildUI];
}

- (void)searchPath {
    NSString *homePath = NSHomeDirectory();
    NSFileManager *fm = [NSFileManager defaultManager];
    NSArray *arr = [fm contentsOfDirectoryAtPath:homePath error:nil];
    _showPathArray = arr;
    _currentPath = homePath;
}

#pragma mark - UI
- (void)buildUI {
    self.navTitle = @"沙盒目录";
    [self createLevelView];
    [self createTableView];
}

- (void)createLevelView {
    _levelView = [SanboxLevelView new];
    [self.view addSubview:_levelView];

    [_levelView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(64);
        make.leading.mas_equalTo(0);
        make.trailing.mas_equalTo(0);
        make.height.mas_equalTo(40);
    }];
    
    [_levelView layoutIfNeeded];
    
    [_levelView addLevel:@"Home" path:_currentPath];
}

- (void)createTableView {
    UITableView *tv = [UITableView new];
    [self.view addSubview:tv];
    
    [tv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_levelView.mas_bottom).mas_offset(1);
        make.left.equalTo(self.view.mas_left).mas_offset(1);
        make.right.equalTo(self.view.mas_right).mas_offset(1);
        make.bottom.equalTo(self.view.mas_bottom).mas_offset(1);
    }];
    
    [tv setDelegate:self];
    [tv setDataSource:self];
}

#pragma mark - about TableView
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _showPathArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (section == 0) {
        return 0.1;
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellID"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellID"];
        cell.textLabel.adjustsFontSizeToFitWidth = YES;
    }
    
    cell.textLabel.text = _showPathArray[indexPath.row];
    
    NSArray *array = [self getPathDataWithIndex:indexPath.row isSavePath:NO];
    
    if (array && array.count > 0) {
        cell.imageView.image = ImageNamed(@"folder");
    }
    else {
        cell.imageView.image = ImageNamed(@"file");
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSArray *array = [self getPathDataWithIndex:indexPath.row isSavePath:YES];
    
    if (array && array.count > 0) {
        _showPathArray = array;
        [tableView reloadData];
        
        UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        NSString *title = cell.textLabel.text;
        [_levelView addLevel:title path:_currentPath];
    }
}

- (NSArray *)getPathDataWithIndex:(NSInteger)index isSavePath:(BOOL)isSave {
    NSFileManager *fm = [NSFileManager defaultManager];
    NSString *path = [NSString stringWithFormat:@"%@/%@",_currentPath,_showPathArray[index]];
    
    if (isSave) {
        _currentPath = path;
    }
    
    NSArray *array = [fm contentsOfDirectoryAtPath:path error:nil];
    return array;
}

@end
