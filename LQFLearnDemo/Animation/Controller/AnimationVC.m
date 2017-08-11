//
//  AnimationVC.m
//  LQFLearnDemo
//
//  Created by liqunfei on 2017/8/10.
//  Copyright © 2017年 LQF. All rights reserved.
//

#import "AnimationVC.h"
#import "SectionView.h"
#import "SectionModel.h"
#import "CellModel.h"

@interface AnimationVC () <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) NSMutableArray *sectionArr;

@property (nonatomic, strong) UITableView *listTV;

@end

@implementation AnimationVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.navTitle = @"动画";
    
    [self initData];
    [self buildTableView];
}

- (void)initData {
    _sectionArr = [NSMutableArray arrayWithCapacity:0];
    
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"AnimationList.plist" ofType:nil];
    NSArray *arr = [NSArray arrayWithContentsOfFile:plistPath];
    
    for (NSInteger i = 0; i < arr.count; i++) {
        SectionModel *sectionModel = [[SectionModel alloc] init];
        
        NSDictionary *dic = arr[i];
        sectionModel.title = dic[@"Title"];
        sectionModel.VCName = dic[@"VCName"];
        sectionModel.isSupportExpand = NO;
        sectionModel.isExpand = NO;
        
        NSArray *cellArr = dic[@"Cell"];
        if (cellArr && cellArr.count > 0) {
            sectionModel.isSupportExpand = YES;
            
            NSMutableArray *needCells = [NSMutableArray arrayWithCapacity:0];
            for (NSInteger i = 0; i < cellArr.count; i++) {
                CellModel *cellModel = [[CellModel alloc] init];
                
                NSDictionary *cellDic = cellArr[i];
                cellModel.Title = cellDic[@"Title"];
                cellModel.VCName = cellDic[@"VCName"];
                
                [needCells addObject:cellModel];
            }
            
            sectionModel.cellArray = needCells;
        }
        
        [_sectionArr addObject:sectionModel];
    }
}

- (void)buildTableView {
    _listTV = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    [self.view addSubview:_listTV];
    
    [_listTV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(65);
        make.leading.equalTo(self.view);
        make.trailing.equalTo(self.view);
        make.bottom.equalTo(self.view);
    }];
    
    _listTV.delegate = self;
    _listTV.dataSource = self;
    [_listTV registerClass:[SectionView class] forHeaderFooterViewReuseIdentifier:@"sectionID"];
}

#pragma mark - UITableView

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _sectionArr ? _sectionArr.count : 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    SectionModel *model = _sectionArr[section];
    return model.isSupportExpand ? (model.isExpand ? model.cellArray.count : 0) : 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 44.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.1f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    SectionView *view = [_listTV dequeueReusableHeaderFooterViewWithIdentifier:@"sectionID"];
    if (!view) {
        view = [[SectionView alloc] initWithReuseIdentifier:@"sectionID"];
    }
    
    SectionModel *model = _sectionArr[section];
    view.model = model;
    
    view.skipBlock = ^{
        NSString *vcName = model.VCName;
        if (vcName && vcName.length > 0) {
            BaseViewController *vc = [[NSClassFromString(vcName) alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }
        else {
            //其他方式跳转
        }
    };
    
    view.callBackBlock = ^(BOOL isExpanded) {
        [tableView reloadSections:[NSIndexSet indexSetWithIndex:section] withRowAnimation:UITableViewRowAnimationFade];
    };
    return view;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [_listTV dequeueReusableCellWithIdentifier:@"cellID"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellID"];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.textLabel.font = [UIFont systemFontOfSize:12];
    }
    
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
