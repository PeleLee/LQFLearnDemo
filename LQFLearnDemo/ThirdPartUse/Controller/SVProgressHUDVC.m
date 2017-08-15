//
//  SVProgressHUDVC.m
//  LQFLearnDemo
//
//  Created by liqunfei on 2017/8/14.
//  Copyright © 2017年 LQF. All rights reserved.
//

#import "SVProgressHUDVC.h"
#import "NSString+LQF.h"

@interface SVProgressHUDVC ()

@property (nonatomic, strong) NSTimer *timer;

@property (nonatomic, assign) CGFloat height;

@property (nonatomic, strong) UIScrollView *scrollView;

@end

@implementation SVProgressHUDVC

- (void)dealloc {
    [_timer invalidate];
    _timer = nil;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navTitle = @"SVProgressHUD";
    
    [self buildUI];
}

- (void)buildUI {
    //scrollView
    _scrollView = [UIScrollView new];
    _scrollView.userInteractionEnabled = YES;
    _scrollView.indicatorStyle = UIScrollViewIndicatorStyleWhite;
    [self.view addSubview:_scrollView];
    
    UIEdgeInsets padding = UIEdgeInsetsMake(65, 0, 0, 0);
    [_scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).insets(padding);
    }];
    
    //buttons
    
    NSArray *arr = @[@"Show",
                     @"Status",
                     @"Progress",
                     @"Progress+Status",
                     @"InfoStatus",
                     @"SuccessStatus",
                     @"ErrorStatus",
                     @"ImageStatus",
                     @"PopActivity",
                     @"DismissWithCompletion",
                     @"SetOffsetFromCenter",
                     @"ResetOffsetFromCenter",
                     @"SetDefaultStyle",
                     @"SetDarkStyle",
                     @"SetCustomStyle",
                     @"SetDefaultMaskType",
                     @"SetClearMaskType",
                     @"SetBlackMaskType",
                     @"SetGradientMaskType",
                     @"SetCustomMaskType",
                     @"SetDefalutAnimationType",
                     @"SetNativeAnimationType",
                     @"SetMinimumSize",
                     @"SetNormalSize",
                     @"SetRingThickness",
                     @"SetNormalRingThickness",
                     @"SetRingRadius",
                     @"SetNormalRadius",
                     @"SetRingNoTextRadius",
                     @"SetNomalRingNoTextRadius",
                     @"SetCornerRadius",
                     @"SetNomalCornerRadius",
                     @"SetFont",
                     @"SetNormalFont",
                     @"SetForegroundColor",
                     @"SetNormalForegroundColor",
                     @"SetBackgroundColor",
                     @"SetNormalBackgroundColor",
                     @"SetBackgroundLayerColor",
                     @"SetNormalBackgroundLayerColor",
                     @"SetInfoImage",
                     @"SetSuccessImage",
                     @"SetErrorImage",
                     @"SetMinimumDismissTimeInterval",
                     @"SetMaximumDismissTimeInterval",
                     @"SetFadeInAnimationDuration",
                     @"SetFadeOutAnimationDuration",
                     /*@"SetViewForExtension",
                     @"SetContainerView"*/];
    
    for (NSInteger i = 0; i < arr.count; i++) {
        
        if ([arr[i] isEqualToString:@"Show"]) {
            [self buildLabel:@"代码控制 2秒后消失"];
        }
        
        if ([arr[i] isEqualToString:@"InfoStatus"]) {
            [self buildLabel:@"非代码控制 自动消失"];
        }
        
        if ([arr[i] isEqualToString:@"PopActivity"]) {
            [self buildLabel:@"消失方法"];
        }
        
        if ([arr[i] isEqualToString:@"SetOffsetFromCenter"]) {
            [self buildLabel:@"偏移"];
        }
        
        if ([arr[i] isEqualToString:@"SetDefaultStyle"]) {
            [self buildLabel:@"风格"];
        }
        
        if ([arr[i] isEqualToString:@"SetDefaultMaskType"]) {
            [self buildLabel:@"蒙版风格"];
        }
        
        if ([arr[i] isEqualToString:@"SetDefalutAnimationType"]) {
            [self buildLabel:@"动画风格"];
        }
        
        if ([arr[i] isEqualToString:@"SetContainerView"]) {
            [self buildLabel:@"替换视图"];
        }
        
        if ([arr[i] isEqualToString:@"SetMinimumSize"]) {
            [self buildLabel:@"视图最小size"];
        }
        
        if ([arr[i] isEqualToString:@"SetRingThickness"]) {
            [self buildLabel:@"Ring(环)的厚度"];
        }
        
        if ([arr[i] isEqualToString:@"SetRingRadius"]) {
            [self buildLabel:@"Ring半径"];
        }
        
        if ([arr[i] isEqualToString:@"SetRingNoTextRadius"]) {
            [self buildLabel:@"无文字时Ring的半径"];
        }
        
        if ([arr[i] isEqualToString:@"SetCornerRadius"]) {
            [self buildLabel:@"CornerRadius"];
        }
        
        if ([arr[i] isEqualToString:@"SetFont"]) {
            [self buildLabel:@"Font"];
        }
        
        if ([arr[i] isEqualToString:@"SetForegroundColor"]) {
            [self buildLabel:@"ForegroundColor"];
        }
        
        if ([arr[i] isEqualToString:@"SetBackgroundColor"]) {
            [self buildLabel:@"BackgroundColor"];
        }
        
        if ([arr[i] isEqualToString:@"SetBackgroundLayerColor"]) {
            [self buildLabel:@"BackgroundLayerColor"];
        }
        
        if ([arr[i] isEqualToString:@"SetInfoImage"]) {
            [self buildLabel:@"设置图片"];
        }
        
        if ([arr[i] isEqualToString:@"SetMinimumDismissTimeInterval"]) {
            [self buildLabel:@"消失时间"];
        }
        
        if ([arr[i] isEqualToString:@"SetFadeInAnimationDuration"]) {
            [self buildLabel:@"设置动画时间"];
        }
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [_scrollView addSubview:button];
        
        //计算button宽度
        CGSize size = [NSString calculateSizeWithText:arr[i] width:DEVICE_WIDTH font:13];
        
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_scrollView).mas_offset(_height);
            make.centerX.equalTo(_scrollView);
            make.width.mas_equalTo(size.width + 5);
            make.height.equalTo(@40);
        }];
        
        [button setTitleColor:RGBA(21, 135, 248, 1) forState:UIControlStateNormal];
        [button.titleLabel setTextAlignment:NSTextAlignmentCenter];
        [button.titleLabel setFont:[UIFont systemFontOfSize:13]];
        [button setTitle:arr[i] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
        
        _height += 40;
        [_scrollView setContentSize:CGSizeMake(DEVICE_WIDTH, _height)];
    }
}

- (void)buildLabel:(NSString *)text {
    UILabel *label = [UILabel new];
    [_scrollView addSubview:label];
    
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_scrollView).mas_offset(_height);
        make.centerX.equalTo(_scrollView);
        make.width.mas_equalTo(DEVICE_WIDTH);
        make.height.mas_equalTo(40);
    }];
    
    label.text = [NSString stringWithFormat:@"-----------%@-----------",text];
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:14.0f];
    label.textColor = [UIColor darkGrayColor];
    
    _height += 40;
}

#pragma mark - Click

- (void)click:(UIButton *)btn {
    NSLog(@"%@",btn.titleLabel.text);
    if (_timer) {
        [self removeTimer];
    }
    
    NSString *title = btn.titleLabel.text;
    
    if ([title isEqualToString:@"Show"]) {
        [SVProgressHUD show];
        [SVProgressHUD dismissWithDelay:2];
    }
    else if ([title isEqualToString:@"Status"]) {
        [SVProgressHUD showWithStatus:@"Status Status Status Status"];
        [SVProgressHUD dismissWithDelay:2];
    }
    else if ([title isEqualToString:@"Progress"]) {
        //0~1浮点数 进度展示
        [SVProgressHUD showProgress:0.55];
        [SVProgressHUD dismissWithDelay:2];
    }
    else if ([title isEqualToString:@"Progress+Status"]) {
        [SVProgressHUD showProgress:0.33 status:@"Status"];
        [SVProgressHUD dismissWithDelay:2];
    }
    else if ([title isEqualToString:@"InfoStatus"]) {
        [SVProgressHUD showInfoWithStatus:@"Status"];
//        [SVProgressHUD dismissWithDelay:2];
    }
    else if ([title isEqualToString:@"SuccessStatus"]){
        [SVProgressHUD showSuccessWithStatus:@"成功showSuccessWithStatus"];
    }
    else if ([title isEqualToString:@"ErrorStatus"]) {
        [SVProgressHUD showErrorWithStatus:@"错误信息"];
    }
    else if ([title isEqualToString:@"ImageStatus"]) {
        //将图片 渲染成黑色的
        [SVProgressHUD showImage:ImageNamed(@"Sun") status:@"显示图片"];
    }
    else if ([title isEqualToString:@"PopActivity"]) {
        [SVProgressHUD showWithStatus:@"popActivity"];
        _timer = [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(popActivity:) userInfo:nil repeats:NO];
    }
    else if ([title isEqualToString:@"DismissWithCompletion"]) {
        [SVProgressHUD showWithStatus:@"消失后打印"];
        [SVProgressHUD dismissWithDelay:2 completion:^{
            NSLog(@"SVProgressHUD消失");
        }];
    }
    else if ([title isEqualToString:@"SetOffsetFromCenter"]) {
        [SVProgressHUD showWithStatus:@"offset"];
        //设置之后 之后再调用hud位置不会复原
        [SVProgressHUD setOffsetFromCenter:UIOffsetMake(100, -100)];
        [SVProgressHUD dismissWithDelay:2];
    }
    else if ([title isEqualToString:@"ResetOffsetFromCenter"]) {
        [SVProgressHUD showWithStatus:@"resetOffset"];
        //hud位置复原到 中心位置
        [SVProgressHUD resetOffsetFromCenter];
        [SVProgressHUD dismissWithDelay:2];
    }
    else if ([title isEqualToString:@"SetDefaultStyle"]) {
        [SVProgressHUD setDefaultStyle:SVProgressHUDStyleLight];
        [SVProgressHUD showWithStatus:@"defaultStyle"];
        [SVProgressHUD dismissWithDelay:2];
    }
    else if ([title isEqualToString:@"SetDarkStyle"]) {
        [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
        [SVProgressHUD showWithStatus:@"darkStyle"];
        [SVProgressHUD dismissWithDelay:2];
    }
    else if ([title isEqualToString:@"SetCustomStyle"]) {
        [SVProgressHUD setDefaultStyle:SVProgressHUDStyleCustom];
        [SVProgressHUD showWithStatus:@"customStyle"];
        [SVProgressHUD dismissWithDelay:2];
    }
    else if ([title isEqualToString:@"SetDefaultMaskType"]) {
        //允许用户点击
        [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeNone];
        [SVProgressHUD showWithStatus:@"MaskTypeNone"];
        [SVProgressHUD dismissWithDelay:2];
    }
    else if ([title isEqualToString:@"SetClearMaskType"]) {
        //不允许用户点击
        [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];
        [SVProgressHUD showWithStatus:@"MaskTypeClear"];
        [SVProgressHUD dismissWithDelay:2];
    }
    else if ([title isEqualToString:@"SetBlackMaskType"]) {
        //不允许用户点击
        [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
        [SVProgressHUD showWithStatus:@"MaskTypeBlack"];
        [SVProgressHUD dismissWithDelay:2];
    }
    else if ([title isEqualToString:@"SetGradientMaskType"]) {
        //不允许用户点击
        [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeGradient];
        [SVProgressHUD showWithStatus:@"MaskTypeGradient"];
        [SVProgressHUD dismissWithDelay:2];
    }
    else if ([title isEqualToString:@"SetCustomMaskType"]) {
        //不允许用户点击
        [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeCustom];
        [SVProgressHUD showWithStatus:@"MaskTypeCustom"];
        [SVProgressHUD dismissWithDelay:2];
    }
    else if ([title isEqualToString:@"SetDefalutAnimationType"]) {
        [SVProgressHUD setDefaultAnimationType:SVProgressHUDAnimationTypeFlat];
        [SVProgressHUD showWithStatus:@"AnimationTypeFlat"];
        [SVProgressHUD dismissWithDelay:2];
    }
    else if ([title isEqualToString:@"SetNativeAnimationType"]) {
        [SVProgressHUD setDefaultAnimationType:SVProgressHUDAnimationTypeNative];
        [SVProgressHUD showWithStatus:@"AnimationTypeNative"];
        [SVProgressHUD dismissWithDelay:2];
    }
    else if ([title isEqualToString:@"SetContainerView"]) {
        UIImageView *newContainerView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
        newContainerView.backgroundColor = MainColor;
        newContainerView.image = ImageNamed(@"rocket");
        [SVProgressHUD setContainerView:newContainerView];
        [SVProgressHUD showWithStatus:@"newContainer"];
        [SVProgressHUD dismissWithDelay:2];
    }
    else if ([title isEqualToString:@"SetMinimumSize"]) {
        [SVProgressHUD setMinimumSize:CGSizeMake(200, 200)];
        [SVProgressHUD showWithStatus:@"MinimumSize:200x200"];
        [SVProgressHUD dismissWithDelay:2];
    }
    else if ([title isEqualToString:@"SetNormalSize"]) {
        //恢复正常
        [SVProgressHUD setMinimumSize:CGSizeZero];
        [SVProgressHUD showWithStatus:@"Normal"];
        [SVProgressHUD dismissWithDelay:2];
    }
    
    else if ([title isEqualToString:@"SetRingThickness"]) {
        [SVProgressHUD setRingThickness:10];
        [SVProgressHUD showWithStatus:@"RingThickness:10"];
        [SVProgressHUD dismissWithDelay:2];
    }
    else if ([title isEqualToString:@"SetNormalRingThickness"]) {
        [SVProgressHUD setRingThickness:2];
        [SVProgressHUD showWithStatus:@"Normal:2"];
        [SVProgressHUD dismissWithDelay:2];
    }
    
    else if ([title isEqualToString:@"SetRingRadius"]) {
        [SVProgressHUD setRingRadius:30];
        [SVProgressHUD showWithStatus:@"Radius:30"];
        [SVProgressHUD dismissWithDelay:2];
    }
    else if ([title isEqualToString:@"SetNormalRadius"]) {
        [SVProgressHUD setRingRadius:18];
        [SVProgressHUD showWithStatus:@"Normal:18"];
        [SVProgressHUD dismissWithDelay:2];
    }
    
    else if ([title isEqualToString:@"SetRingNoTextRadius"]) {
        //没有文字时 Ring的半径
        [SVProgressHUD setRingNoTextRadius:50];
        [SVProgressHUD show];
        [SVProgressHUD dismissWithDelay:2];
    }
    else if ([title isEqualToString:@"SetNomalRingNoTextRadius"]) {
        [SVProgressHUD setRingNoTextRadius:24];
        [SVProgressHUD showWithStatus:@"Normal:24"];
        [SVProgressHUD dismissWithDelay:2];
    }
    
    else if ([title isEqualToString:@"SetCornerRadius"]) {
        [SVProgressHUD setCornerRadius:20];
        [SVProgressHUD showWithStatus:@"CornerRadius:20"];
        [SVProgressHUD dismissWithDelay:2];
    }
    else if ([title isEqualToString:@"SetNomalCornerRadius"]) {
        [SVProgressHUD setCornerRadius:14];
        [SVProgressHUD showWithStatus:@"Normal:14"];
        [SVProgressHUD dismissWithDelay:2];
    }
    
    else if ([title isEqualToString:@"SetFont"]) {
        [SVProgressHUD setFont:[UIFont systemFontOfSize:20]];
        [SVProgressHUD showWithStatus:@"Font:20"];
        [SVProgressHUD dismissWithDelay:2];
    }
    else if ([title isEqualToString:@"SetNormalFont"]) {
        [SVProgressHUD setFont:[UIFont preferredFontForTextStyle:UIFontTextStyleSubheadline]];
        [SVProgressHUD showWithStatus:@"Normal"];
        [SVProgressHUD dismissWithDelay:2];
    }
    
    else if ([title isEqualToString:@"SetForegroundColor"]) {
        //背景色 为透明 调用后默认调用 setDefaultStyle:SVProgressHUDStyleCustom
        [SVProgressHUD setForegroundColor:[UIColor yellowColor]];
        [SVProgressHUD showSuccessWithStatus:@"Yellow"];
        [SVProgressHUD dismissWithDelay:2];
    }
    else if ([title isEqualToString:@"SetNormalForegroundColor"]) {
        [SVProgressHUD setForegroundColor:[UIColor blackColor]];
        [SVProgressHUD showSuccessWithStatus:@"Normal"];
        [SVProgressHUD dismissWithDelay:2];
    }
    
    else if ([title isEqualToString:@"SetBackgroundColor"]) {
        [SVProgressHUD setBackgroundColor:[UIColor yellowColor]];
        [SVProgressHUD showSuccessWithStatus:@"YellowColor"];
        [SVProgressHUD dismissWithDelay:2];
    }
    else if ([title isEqualToString:@"SetNormalBackgroundColor"]) {
        [SVProgressHUD setDefaultStyle:SVProgressHUDStyleLight];
        [SVProgressHUD showSuccessWithStatus:@"Normal"];
        [SVProgressHUD dismissWithDelay:2];
    }
    
    else if ([title isEqualToString:@"SetBackgroundLayerColor"]) {
        //无效 用法还不确定
        [SVProgressHUD setBackgroundLayerColor:[UIColor blueColor]];
//        [SVProgressHUD setDefaultStyle:SVProgressHUDStyleCustom];
        [SVProgressHUD showSuccessWithStatus:@"YellowLayer"];
        [SVProgressHUD dismissWithDelay:2];
    }    
    else if ([title isEqualToString:@"SetNormalBackgroundLayerColor"]) {
        [SVProgressHUD setDefaultStyle:SVProgressHUDStyleLight];
        [SVProgressHUD showSuccessWithStatus:@"Normal"];
        [SVProgressHUD dismissWithDelay:2];
    }
    
    else if ([title isEqualToString:@"SetInfoImage"]) {
        [SVProgressHUD setInfoImage:ImageNamed(@"rocket")];
        [SVProgressHUD showInfoWithStatus:@"Change"];
        [SVProgressHUD dismissWithDelay:2];
    }
    else if ([title isEqualToString:@"SetSuccessImage"]) {
        [SVProgressHUD setSuccessImage:ImageNamed(@"Sun")];
        [SVProgressHUD showSuccessWithStatus:@"Change"];
        [SVProgressHUD dismissWithDelay:2];
    }
    else if ([title isEqualToString:@"SetErrorImage"]) {
        [SVProgressHUD setErrorImage:ImageNamed(@"rocket")];
        [SVProgressHUD showErrorWithStatus:@"Change!"];
        [SVProgressHUD dismissWithDelay:2];
    }
    
    else if ([title isEqualToString:@"SetViewForExtension"]) {
        //不确定用法
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
        view.backgroundColor = [UIColor orangeColor];
        [SVProgressHUD setViewForExtension:view];
        [SVProgressHUD show];
        [SVProgressHUD dismissWithDelay:2];
    }
    
    else if ([title isEqualToString:@"SetMinimumDismissTimeInterval"]) {
        //设置最短为2 然后设置1s后消失会失效，实际是2s后消失
        [SVProgressHUD setMinimumDismissTimeInterval:2];
        [SVProgressHUD show];
        [SVProgressHUD dismissWithDelay:1];
    }
    else if ([title isEqualToString:@"SetMaximumDismissTimeInterval"]) {
        [SVProgressHUD setMaximumDismissTimeInterval:2];
        [SVProgressHUD showSuccessWithStatus:@"最多显示2s"];
        [SVProgressHUD dismissWithDelay:4];
    }
    
    else if ([title isEqualToString:@"SetFadeInAnimationDuration"]) {
        [SVProgressHUD setFadeInAnimationDuration:0.5];
        [SVProgressHUD show];
        [SVProgressHUD dismissWithDelay:2];
    }
    else if ([title isEqualToString:@"SetFadeOutAnimationDuration"]) {
        [SVProgressHUD setFadeOutAnimationDuration:0.5];
        [SVProgressHUD show];
        [SVProgressHUD dismissWithDelay:2];
    }
}

#pragma mark popActivity

- (void)popActivity:(NSTimer *)timer {
    [SVProgressHUD popActivity];
}

- (void)removeTimer {
    [SVProgressHUD dismiss];
    [_timer invalidate];
    _timer = nil;
}

@end
