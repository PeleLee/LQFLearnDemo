//
//  WriteDateVC.m
//  LQFLearnDemo
//
//  Created by liqunfei on 2017/8/16.
//  Copyright © 2017年 LQF. All rights reserved.
//

#import "WriteDateVC.h"
#import "NSString+LQF.h"

@interface WriteDateVC ()

@property (nonatomic, strong) UITextField *inputTF1;
@property (nonatomic, strong) UITextField *inputTF2;
@property (nonatomic, strong) UILabel *showLabel;
@property (nonatomic, strong) NSFileManager *fileManager;
/**
 文件夹路径
 */
@property (nonatomic, strong) NSString *dirPath;

@end

@implementation WriteDateVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navTitle = @"写入数据";
    
    [self buildUI];
    
    [self getDirPath];
}

#pragma mark - Dirpath

- (void)getDirPath {
    _fileManager = [[NSFileManager alloc] init];
    NSString *pathDocuments = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    _dirPath = [NSString stringWithFormat:@"%@/File",pathDocuments];
}

#pragma mark - WriteData

- (void)findDirpath:(NSString *)data {
    
    if (![_fileManager fileExistsAtPath:_dirPath]) {
        //创建文件夹
        BOOL dirIsSuccess = [_fileManager createDirectoryAtPath:_dirPath withIntermediateDirectories:YES attributes:nil error:nil];
        if (!dirIsSuccess) {
            [SVProgressHUD showErrorWithStatus:@"文件夹创建失败"];
            [SVProgressHUD dismissWithDelay:2];
        }
        else {
            [self writeContent:data];
        }
    }
    else {
        [self writeContent:data];
    }
}

- (void)writeContent:(NSString *)data {
    //文件路径
    NSString *filePath = [NSString stringWithFormat:@"%@/file",_dirPath];
    
    BOOL isWrite = [NSKeyedArchiver archiveRootObject:data toFile:filePath];
    if (isWrite) {
        [SVProgressHUD showSuccessWithStatus:@"写入成功"];
    }
    else {
        [SVProgressHUD showErrorWithStatus:@"写入失败"];
    }
    [SVProgressHUD dismissWithDelay:2];
}

#pragma mark - Action

- (void)write:(UIButton *)button {
    if (button.tag == 1001) {
        [self findDirpath:_inputTF1.text];
    }
    else if (button.tag == 1002) {
        [self findDirpath:_inputTF2.text];
    }
}

- (void)show {
    NSString *filePath = [NSString stringWithFormat:@"%@/%@",_dirPath,@"/file"];
    
    if (![_fileManager fileExistsAtPath:filePath]) {
        [SVProgressHUD showErrorWithStatus:@"文件不存在"];
        [SVProgressHUD dismissWithDelay:2];
    }
    else {
        NSData *data = [_fileManager contentsAtPath:filePath];
        NSString *str = [NSKeyedUnarchiver unarchiveObjectWithData:data];
        
        CGSize newSize = [NSString calculateSizeWithText:str width:(DEVICE_WIDTH - 100) font:13];
        [_showLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(newSize.width + 5);
            make.height.mas_equalTo(newSize.height);
        }];
        
        _showLabel.text = str;
    }
}

#pragma mark - UI
- (void)buildUI {
    
    //Tips
    UILabel *tipsLabel = [UILabel new];
    [self.view addSubview:tipsLabel];
    
    [tipsLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(70);
        make.leading.mas_equalTo(20);
        make.centerX.equalTo(self.view);
        make.height.mas_equalTo(30);
    }];
    
    tipsLabel.textColor = [UIColor redColor];
    tipsLabel.text = @"验证写入不同的数据到同一个文件中-->覆盖";
    tipsLabel.font = SystemFont(13);
    
    //Label
    UILabel *label1 = [UILabel new];
    [self.view addSubview:label1];
    
    NSString *text1 = @"字符串1";
    
    [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(120);
        make.leading.mas_equalTo(50);
        make.width.mas_equalTo([NSString calculateSizeWithText:text1 width:DEVICE_WIDTH font:13].width + 5);
        make.height.mas_equalTo(40);
    }];
    
    label1.text = text1;
    label1.textColor = [UIColor darkGrayColor];
    label1.font = SystemFont(13);
    
    UILabel *label2 = [UILabel new];
    [self.view addSubview:label2];
    
    NSString *text2 = @"字符串2";
    
    [label2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(label1.mas_bottom);
        make.leading.equalTo(label1);
        make.width.equalTo(label1);
        make.height.equalTo(label1);
    }];
    
    label2.text = text2;
    label2.textColor = [UIColor darkGrayColor];
    label2.font = SystemFont(13);
    
    //TextField
    _inputTF1 = [UITextField new];
    [self.view addSubview:_inputTF1];
    
    [_inputTF1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(label1.mas_trailing).mas_offset(20);
        make.centerY.equalTo(label1);
        make.height.equalTo(@30);
        make.width.mas_equalTo(150);
    }];
    
    _inputTF1.borderStyle = UITextBorderStyleRoundedRect;
    _inputTF1.placeholder = @"输入字符串";
    _inputTF1.textColor = [UIColor blackColor];
    _inputTF1.font = SystemFont(13);
    
    _inputTF2 = [UITextField new];
    [self.view addSubview:_inputTF2];
    
    [_inputTF2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(label2.mas_trailing).mas_offset(20);
        make.centerY.equalTo(label2);
        make.height.equalTo(@30);
        make.width.equalTo(_inputTF1);
    }];
    
    _inputTF2.borderStyle = UITextBorderStyleRoundedRect;
    _inputTF2.placeholder = @"输入字符串";
    _inputTF2.textColor = [UIColor blackColor];
    _inputTF2.font = SystemFont(13);
    
    //Button
    UIButton *writeBtn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:writeBtn1];
    
    NSString *writeTitle = @"写入";
    
    [writeBtn1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_inputTF1);
        make.leading.equalTo(_inputTF1.mas_trailing).mas_offset(20);
        make.width.mas_equalTo([NSString calculateSizeWithText:writeTitle width:DEVICE_WIDTH font:13].width + 5);
        make.height.mas_equalTo(40);
    }];
    
    [writeBtn1 setTitle:writeTitle forState:UIControlStateNormal];
    [writeBtn1 setTitleColor:RGBA(21, 135, 248, 1) forState:UIControlStateNormal];
    [writeBtn1 addTarget:self action:@selector(write:) forControlEvents:UIControlEventTouchUpInside];
    [writeBtn1.titleLabel setFont:SystemFont(13)];
    writeBtn1.tag = 1001;
    
    UIButton *writeBtn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:writeBtn2];
    
    [writeBtn2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(writeBtn1);
        make.centerY.equalTo(_inputTF2);
        make.width.equalTo(writeBtn1);
        make.height.equalTo(writeBtn1);
    }];
    
    [writeBtn2 setTitle:writeTitle forState:UIControlStateNormal];
    [writeBtn2 setTitleColor:RGBA(21, 135, 248, 1) forState:UIControlStateNormal];
    [writeBtn2 addTarget:self action:@selector(write:) forControlEvents:UIControlEventTouchUpInside];
    [writeBtn2.titleLabel setFont:SystemFont(13)];
    writeBtn2.tag = 1002;
    
    UIButton *showBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:showBtn];
    
    NSString *showTitle = @"显示存储内容";
    
    [showBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(_inputTF2.mas_bottom).mas_offset(30);
        make.width.mas_equalTo([NSString calculateSizeWithText:showTitle width:DEVICE_WIDTH font:13].width + 5);
        make.height.mas_equalTo(40);
    }];
    
    [showBtn setTitle:showTitle forState:UIControlStateNormal];
    [showBtn setTitleColor:RGBA(21, 135, 248, 1) forState:UIControlStateNormal];
    [showBtn addTarget:self action:@selector(show) forControlEvents:UIControlEventTouchUpInside];
    [showBtn.titleLabel setFont:SystemFont(13)];
    
    //Showlabel
    _showLabel = [UILabel new];
    [self.view addSubview:_showLabel];
    
    [_showLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(showBtn.mas_bottom).mas_offset(50);
        make.centerX.equalTo(self.view);
        make.width.mas_equalTo(0);
        make.height.mas_equalTo(0);
    }];
    
    _showLabel.numberOfLines = 0;
    _showLabel.font = SystemFont(13);
    _showLabel.textColor = [UIColor blackColor];
    _showLabel.textAlignment = NSTextAlignmentCenter;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

@end
