//
//  XibAndSBVC.m
//  LQFLearnDemo
//
//  Created by liqunfei on 2017/8/4.
//  Copyright © 2017年 LQF. All rights reserved.
//

#import "XibAndSBVC.h"

@interface XibAndSBVC ()

@property (nonatomic, strong) UITextView *questionTV;

@end

@implementation XibAndSBVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navTitle = @"Xib&SB";
    
    _questionTV = [[UITextView alloc] initWithFrame:CGRectMake(20, 70, DEVICE_WIDTH - 40, DEVICE_HEIGHT - 70)];
    _questionTV.font = [UIFont systemFontOfSize:13.0f];
    _questionTV.editable = NO;
    [self.view addSubview:_questionTV];
    
    NSString *question = [NSString stringWithFormat:@"1.%@\n",@"storyboard中布局的控件,在代码中隐藏导航栏之后坐标变化'诡异'O_o???"];
    
    _questionTV.text = question;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
