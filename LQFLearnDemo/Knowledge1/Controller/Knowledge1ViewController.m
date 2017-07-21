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

@interface Knowledge1ViewController () <UITableViewDataSource,UITableViewDelegate> {
    NSArray *_listArr;
}

@property (weak, nonatomic) IBOutlet UITableView *fucTV;

@end

@implementation Knowledge1ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _listArr = @[
                 @"KVC",
                 @"Autolayout",
                 @"FMDB",
                 @"CoreData",
                 @"App上线流程",
                 @"Masonry",
                 @"iOS各版本更新内容",
                 @"协议和扩展",
                 @"AutoreleasePool",
                 @"TableView折叠",
                 @"内存泄露检测",
                 @"React Native",
                 //http://www.cocoachina.com/ios/20170707/19769.html
                 @"多线程",
                 //https://www.liaoxuefeng.com/wiki/0013739516305929606dd18361248578c67b8067c8c017b000/00137402760310626208b4f695940a49e5348b689d095fc000
                 @"git"
                 ];
}

#pragma mark - UITableView
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _listArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellID = @"CELLID";
    UITableViewCell *cell = [_fucTV dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    cell.textLabel.text = [NSString stringWithFormat:@"%ld、%@",indexPath.row+1,_listArr[indexPath.row]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *content = _listArr[indexPath.row];
    
    if ([content isEqualToString:@"KVC"]) {
        [self performSegueWithIdentifier:@"KVC" sender:self];
    }
    
    else if ([content isEqualToString:@"Autolayout"]) {
        [self performSegueWithIdentifier:@"Autolayout" sender:self];
    }
    
    else if ([content isEqualToString:@"AutoreleasePool"]) {
        
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"场景选择" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
        
        __weak typeof(self) this = self;
        UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"场景1" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [this pushToAutoreleasePooVCWithType:1];
        }];
        UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"场景2" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [this pushToAutoreleasePooVCWithType:2];
        }];
        UIAlertAction *action3 = [UIAlertAction actionWithTitle:@"场景3" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [this pushToAutoreleasePooVCWithType:3];
        }];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        
        [alert addAction:action1];
        [alert addAction:action2];
        [alert addAction:action3];
        [alert addAction:cancelAction];
        
        [self presentViewController:alert animated:YES completion:nil];
    }
    
    else if ([content isEqualToString:@"TableView折叠"]) {
        FoldTableViewVC *foldVC = [[FoldTableViewVC alloc] init];
        [self.navigationController pushViewController:foldVC animated:YES];
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
