//
//  RGBPreviewVC.m
//  LQFLearnDemo
//
//  Created by liqunfei on 2017/9/21.
//  Copyright © 2017年 LQF. All rights reserved.
//

#import "RGBPreviewVC.h"

@interface RGBPreviewVC ()
@property (weak, nonatomic) IBOutlet UITextField *redTF;
@property (weak, nonatomic) IBOutlet UITextField *greenTF;
@property (weak, nonatomic) IBOutlet UITextField *blueTF;
@property (weak, nonatomic) IBOutlet UIButton *queryButton;
@property (weak, nonatomic) IBOutlet UIView *preView;

@end

@implementation RGBPreviewVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navTitle = @"试色器";
    self.automaticallyAdjustsScrollViewInsets = NO;
}

- (IBAction)queryAction:(UIButton *)sender {
    self.preView.backgroundColor = RGBA(self.redTF.text.doubleValue, self.greenTF.text.doubleValue, self.blueTF.text.doubleValue, 1);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
