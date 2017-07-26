//
//  Knowledge1ViewController.m
//  LQFLearnDemo
//
//  Created by liqunfei on 2017/7/13.
//  Copyright © 2017年 LQF. All rights reserved.
//

#import "Knowledge1ViewController.h"
#import "AutoreleasePoolVC.h"
#import "FoldTableViewVC.h"
#import "SectionModel.h"
#import "CellModel.h"
#import "SectionView.h"

@interface Knowledge1ViewController () <UITableViewDataSource,UITableViewDelegate> {
    NSArray *_listArr;
}

@property (weak, nonatomic) IBOutlet UITableView *fucTV;
@property (nonatomic, strong) NSMutableArray *sectionData;

@end

@implementation Knowledge1ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"KnowledgeList1.plist" ofType:nil];
    _listArr = [NSArray arrayWithContentsOfFile:plistPath];
//    _listArr = @[
//                 @"KVC",
//                 @"TableView折叠",
//                 @"Autolayout"/*https://www.liaoxuefeng.com/wiki/0013739516305929606dd18361248578c67b8067c8c017b000/00137402760310626208b4f695940a49e5348b689d095fc000*/,
//                 @"git",
//                 @"AutoreleasePool",
//                 @"多线程"/*http://www.cocoachina.com/ios/20170707/19769.html*/,
//                 @"FMDB",
//                 @"CoreData",
//                 @"App上线流程",
//                 @"Masonry",
//                 @"iOS各版本更新内容",
//                 @"协议和扩展",
//                 @"内存泄露检测",
//                 @"React Native",
//                 ];
    [_fucTV registerClass:[SectionView class] forHeaderFooterViewReuseIdentifier:@"section"];
    
}

- (NSMutableArray *)sectionData {
    if (!_sectionData) {
        _sectionData = [[NSMutableArray alloc] initWithCapacity:0];
        for (NSInteger i = 0; i < _listArr.count; i++) {
            
            NSDictionary *dic = _listArr[i];
            
            SectionModel *sectionModel = [[SectionModel alloc] init];
            sectionModel.title = dic[@"title"];
            sectionModel.isExpand = NO;
            
            NSArray *subArr = dic[@"sub"];
            if (subArr && subArr.count > 0) {
                sectionModel.isSupportExpand = YES;
                NSMutableArray *cellArr = [NSMutableArray arrayWithCapacity:0];
                for (NSInteger j = 0; j < subArr.count; j++) {
                    CellModel *model = [[CellModel alloc] init];
                    model.title = subArr[j];
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
    return 0.1f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellID = @"CELLID";
    UITableViewCell *cell = [_fucTV dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    SectionModel *section = _sectionData[indexPath.section];
    CellModel *model = section.cellArray[indexPath.row];
    cell.textLabel.text = model.title;
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    SectionView *view = [_fucTV dequeueReusableHeaderFooterViewWithIdentifier:@"section"];
    SectionModel *model = _sectionData[section];
    view.model = model;
    
    view.skipBlock = ^{
        NSString *title = model.title;
        [self presentWithTitle:title];
    };
    
    view.callBackBlock = ^(BOOL isExpanded) {
        [tableView reloadSections:[NSIndexSet indexSetWithIndex:section] withRowAnimation:UITableViewRowAnimationFade];
    };
    return view;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *dic = _listArr[indexPath.section];
    NSArray *cellArr = dic[@"sub"];
    NSString *content = cellArr[indexPath.row];
    
    [self presentWithTitle:content];
    
    
//    else if ([content isEqualToString:@"AutoreleasePool"]) {
//        
//        
//        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"场景选择" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
//        
//        __weak typeof(self) this = self;
//        UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"场景1" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//            [this pushToAutoreleasePooVCWithType:1];
//        }];
//        UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"场景2" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//            [this pushToAutoreleasePooVCWithType:2];
//        }];
//        UIAlertAction *action3 = [UIAlertAction actionWithTitle:@"场景3" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//            [this pushToAutoreleasePooVCWithType:3];
//        }];
//        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
//        
//        [alert addAction:action1];
//        [alert addAction:action2];
//        [alert addAction:action3];
//        [alert addAction:cancelAction];
//        
//        [self presentViewController:alert animated:YES completion:nil];
//    }
    
//    else if ([content isEqualToString:@"TableView折叠"]) {
//        FoldTableViewVC *foldVC = [[FoldTableViewVC alloc] init];
//        [self.navigationController pushViewController:foldVC animated:YES];
//    }
}

- (void)presentWithTitle:(NSString *)title {
    if ([title isEqualToString:@"KVC"] || [title isEqualToString:@"git"]) {
        [self performSegueWithIdentifier:title sender:self];
    }
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
