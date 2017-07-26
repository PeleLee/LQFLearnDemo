//
//  FoldTableViewVC.m
//  LQFLearnDemo
//
//  Created by liqunfei on 2017/7/19.
//  Copyright © 2017年 LQF. All rights reserved.
//

#import "FoldTableViewVC.h"
#import "SectionView.h"
#import "SectionModel.h"
#import "CellModel.h"

@interface FoldTableViewVC () <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *sectionData;

@end

@implementation FoldTableViewVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];

    [self.tableView registerClass:[SectionView class] forHeaderFooterViewReuseIdentifier:@"section"];
}

- (NSMutableArray *)sectionData {
    if (!_sectionData) {
        _sectionData = [[NSMutableArray alloc] initWithCapacity:0];
        for (NSInteger i = 0; i < 20; i++) {
            SectionModel *model = [[SectionModel alloc] init];
            model.title = [NSString stringWithFormat:@"%ld",(long)i];
            model.isExpand = NO;
            model.isSupportExpand = YES;
            NSMutableArray *array = [[NSMutableArray alloc] init];
            for (NSInteger j = 0; j < 3; j++) {
                CellModel *cell = [[CellModel alloc] init];
                cell.title = [NSString stringWithFormat:@"%ld",(long)j];
                [array addObject:cell];
            }
            model.cellArray = array;
            [_sectionData addObject:model];
        }
    }
    return _sectionData;
}

#pragma mark UITableView
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.sectionData.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    SectionModel *model = _sectionData[section];
    return model.isExpand ? model.cellArray.count : 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 44.0f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"cellID"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellID"];
    }
    SectionModel *section = _sectionData[indexPath.section];
    CellModel *model = section.cellArray[indexPath.row];
    cell.textLabel.text = model.title;
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    SectionView *view = [self.tableView dequeueReusableHeaderFooterViewWithIdentifier:@"section"];
    SectionModel *model = _sectionData[section];
    view.model = model;
    view.callBackBlock = ^(BOOL isExpanded) {
        [tableView reloadSections:[NSIndexSet indexSetWithIndex:section] withRowAnimation:UITableViewRowAnimationFade];
    };
    return view;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
