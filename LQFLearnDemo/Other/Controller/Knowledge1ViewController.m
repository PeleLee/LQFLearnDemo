//
//  Knowledge1ViewController.m
//  LQFLearnDemo
//
//  Created by liqunfei on 2017/7/13.
//  Copyright © 2017年 LQF. All rights reserved.
//

#import "Knowledge1ViewController.h"
#import "AutoreleasePoolVC.h"
#import "SectionModel.h"
#import "CellModel.h"
#import "SectionView.h"
#import "ThreadTestVC.h"

@interface Knowledge1ViewController () <UITableViewDataSource,UITableViewDelegate> {
    NSArray *_listArr;
}

@property (strong, nonatomic) UITableView *fucTV;
@property (nonatomic, strong) NSMutableArray *sectionData;

@end

@implementation Knowledge1ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navTitle = @"Knowledge";
    
    _fucTV = [[UITableView alloc] initWithFrame:CGRectMake(0, 65, DEVICE_WIDTH, DEVICE_HEIGHT - 65) style:UITableViewStylePlain];
    _fucTV.delegate = self;
    _fucTV.dataSource = self;
    [self.view addSubview:_fucTV];
    
    //plist文件加载列表
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"KnowledgeList1.plist" ofType:nil];
    _listArr = [NSArray arrayWithContentsOfFile:plistPath];
    
    [_fucTV registerClass:[SectionView class] forHeaderFooterViewReuseIdentifier:@"section"];
}

- (NSMutableArray *)sectionData {
    if (!_sectionData) {
        _sectionData = [[NSMutableArray alloc] initWithCapacity:0];
        for (NSInteger i = 0; i < _listArr.count; i++) {
            
            NSDictionary *dic = _listArr[i];
            
            SectionModel *sectionModel = [[SectionModel alloc] init];
            sectionModel.title = dic[@"Title"];
            sectionModel.isExpand = NO;
            sectionModel.segID = dic[@"SegID"];
            sectionModel.VCName = dic[@"VCName"];
            
            //判断是否可折叠
            //可折叠:   点击弹出折叠选项
            //不可折叠:  点击即跳转
            NSArray *subArr = dic[@"Sub"];
            if (subArr && subArr.count > 0) {
                sectionModel.isSupportExpand = YES;
                NSMutableArray *cellArr = [NSMutableArray arrayWithCapacity:0];
                for (NSInteger j = 0; j < subArr.count; j++) {
                    CellModel *model = [[CellModel alloc] init];
                    NSDictionary *cellDic = subArr[j];
                    model.Title = cellDic[@"Title"];
                    model.SegID = cellDic[@"SegID"];
                    model.VCName = cellDic[@"VCName"];
                    
                    [cellArr addObject:model];
                }
                sectionModel.cellArray = cellArr;
            }
            else {
                sectionModel.isSupportExpand = NO;
            }
            
            [_sectionData addObject:sectionModel];
        }
    }
    return _sectionData;
}

#pragma mark - UITableView
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.sectionData.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    SectionModel *model = _sectionData[section];
    return model.isSupportExpand ? (model.isExpand ? model.cellArray.count : 0) : 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 44.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (section == _sectionData.count - 1) {
        return 0.1f;
    }
    else {
        return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellID = @"CELLID";
    UITableViewCell *cell = [_fucTV dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.textLabel.font = [UIFont systemFontOfSize:12.0f];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    SectionModel *section = _sectionData[indexPath.section];
    CellModel *model = section.cellArray[indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat:@"      %@",model.Title];
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    SectionView *view = [_fucTV dequeueReusableHeaderFooterViewWithIdentifier:@"section"];
    if (!view) {
        view = [[SectionView alloc] initWithReuseIdentifier:@"section"];
    }
    SectionModel *model = _sectionData[section];
    view.model = model;
    
    view.skipBlock = ^{
        NSString *segID = model.segID;
        NSString *vcName = model.VCName;
        if (segID && segID.length > 0) {
            //storyboard中跳转
            [self presentWithTitle:segID];
        }
        else if (vcName && vcName.length > 0) {
            //代码push跳转
            BaseViewController *vc = [[NSClassFromString(vcName) alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }
        else {
            //不跳转
        }
    };
    
    view.callBackBlock = ^(BOOL isExpanded) {
        [tableView reloadSections:[NSIndexSet indexSetWithIndex:section] withRowAnimation:UITableViewRowAnimationFade];
    };
    return view;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    SectionModel *sectionModel = _sectionData[indexPath.section];
    NSArray *cellArr = sectionModel.cellArray;
    CellModel *cellModel = cellArr[indexPath.row];
    NSString *segID = cellModel.SegID;
    NSString *vcName = cellModel.VCName;
    
    if (segID && segID.length > 0) {
        [self presentWithTitle:segID];
    }
    else if (vcName && vcName.length > 0) {
        //代码push跳转
        BaseViewController *vc = [[NSClassFromString(vcName) alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    else {
    }
}

- (void)presentWithTitle:(NSString *)title {
    [self performSegueWithIdentifier:title sender:self];
}

#pragma mark AutoreleasePool
- (void)pushToAutoreleasePooVCWithType:(NSInteger)type {
    AutoreleasePoolVC *autoreleaseVC = [[AutoreleasePoolVC alloc] init];
    autoreleaseVC.type = type;
    [self.navigationController pushViewController:autoreleaseVC animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
