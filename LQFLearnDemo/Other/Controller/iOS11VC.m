//
//  iOS11VC.m
//  LQFLearnDemo
//
//  Created by liqunfei on 2017/9/26.
//  Copyright © 2017年 LQF. All rights reserved.
//

#import "iOS11VC.h"
#import "LQFNoteView.h"

@interface iOS11VC ()

@property (nonatomic, strong) UIScrollView *myScrollView;

@end

@implementation iOS11VC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self general];
    
}

#pragma mark - get/set

- (UIScrollView *)myScrollView {
    if (!_myScrollView) {
        _myScrollView = [UIScrollView new];
        [self.view addSubview:_myScrollView];
        [_myScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.right.bottom.left.equalTo(self.view);
        }];
    }
    return _myScrollView;
}

#pragma mark - UI
//总览
- (void)general {
    UIButton *button1 = [UIButton buttonWithType:UIButtonTypeCustom];
    [button1 setTitle:@"☞总览:" forState:UIControlStateNormal];
    [button1 setTitleColor:MyBlue forState:UIControlStateNormal];
    [button1.titleLabel setFont:[UIFont systemFontOfSize:13]];
    [button1 addTarget:self action:@selector(general:) forControlEvents:UIControlEventTouchUpInside];
    [self.myScrollView addSubview:button1];
    
    [button1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.myScrollView).mas_offset(70);
        make.left.equalTo(self.myScrollView).mas_offset(20);
        make.width.equalTo(@70);
        make.height.equalTo(@30);
    }];
    
    LQFNoteView *note = [LQFNoteView new];
    [self.myScrollView addSubview:note];
    
    [note mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(button1.mas_top);
        make.left.equalTo(button1.mas_right);
        make.right.equalTo(self.view).offset(-20);
        make.height.equalTo(self.view).offset(-64);
    }];
    
    [note addNounText:@"ARKit:"];
    [note addContent:@"目前 ARKit 框架本身只包含相机追踪，不能直接加载物体模型，所以只能依赖于游戏引擎（3D引擎 SceneKit，2D引擎 SpriteKit）加载 ARKit。"];
    [note addContent:@"处理器 A9 及以上才能够使用。"];
    [note addContent:@"还有其他的AR方案。"];
    
    [note addNounText:@"PDFKit"];
    
    [note addNounText:@"Core ML & Vision:"];
    [note addContent:@"Core ML:机器学习模型集成\nvision：高性能的图像分析和图像识别。这部分应用于人脸追踪,人脸识别,文本识别,区域识别，二维码识别,物体追踪,图像识别等。"];

    [note addNounText:@"IdentityLookup:"];
    [note addContent:@"通过App Extension 来拦截系统 SMS 和 MMS 的信息。"];
    
    [note addNounText:@"DeviceCheck:"];
    [note addContent:@"DeviceCheck 允许你通过你的服务器与 Apple 服务器通讯，并为单个设备设置两个 bit 的数据（没错，就是 2bit，00 01 10 11 四种可能）。这样即使 App 被卸载重装，被刷机，App后台照样可以拿到之前设置的状态。"];
    
    [note addNounText:@"FileProvider & FileProviderUI:"];
    [note addContent:@"FileProvider 实现了一个云文件的扩展，让你可以获取用户设备上或者云端的文件。\nFileProviderUI 为 FileProvider 提供一套类似 Files App 的界面。"];
    
    [note addNounText:@"Core NFC:"];
    [note addContent:@"近距离无线通讯技术。Core NFC 主要用于检测 NFC 标签， 并且读取其中包含的 NDEF 数据。"];
    [note addContent:@"仅支持 iPhone 7 和 7P 以上包含 NFC 模块的机型"];
    
    [note addNounText:@"Drag & Drop:"];
    [note addContent:@"拖拽功能。只有 iPad 上能支持不同 App 之间的内容拖拽共享，iPhone 上只能在 App 内部拖拽内容。"];
    
    [note addNounText:@"iPhone X 适配:"];
    [note addNounText:@"Safe Area"];
    [note addContent:@" iOS 11 弃用了 automaticallyAdjustsScrollViewInsets 属性，取而代之的是 UIScrollView 新增了 contentInsetAdjustmentBehavior 属性"];
    [note addContent:@"Safe Area 帮助我们将 view 放置在整个屏幕的可视的部分。可以使用 additionalSafeAreaInsets 去扩展安全区域。每个 view 都可以改变安全区域嵌入的大小，controller 也可以。"];
    [note addContent:@"新增一张 1125 x 2436 的 LaunchImage。"];
    
    [note addNounText:@"FaceID"];
    
    [note addNounText:@"Xcode 9更新:"];
    [note addContent:@"可以同时开启多个不同的模拟器"];
    [note addContent:@"Named Color - 可以在 xcassets 里添加颜色，然后在代码或者 IB 中引用这个颜色。"];

    [note addNounText:@"App自荐"];
    [note addNounText:@"截图和视频预览更改"];
    [note endEdit];
}

#pragma mark - Action
- (void)general:(UIButton *)button {
    self.popOutView.urlStr = @"http://www.cocoachina.com/ios/20170925/20643.html";
    [[LQFPopTool sharedInstance] popView:self.popOutView animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
