//
//  CoreGraphicsVC.m
//  LQFLearnDemo
//
//  Created by liqunfei on 2017/8/11.
//  Copyright © 2017年 LQF. All rights reserved.
//

#import "CoreGraphicsVC.h"
#import "LQFNoteView.h"

@interface CoreGraphicsVC ()

@property (nonatomic, strong) LQFNoteView *noteView;

@end

@implementation CoreGraphicsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navTitle = @"CoreGraphics";
    self.quoteUrl = @"https://mp.weixin.qq.com/s/gaTNhNnWeDuPOeqwQiJeXg";
    
    [self buildTV];
    [self edit];
}

- (void)edit {
    //---------------
    [_noteView addTitle:@"绘图系统"];
    
    [_noteView addNounText:@"UIKit"];
    [_noteView addContent:@""];
    [_noteView addNounText:@"CoreGraphics:"];
    [_noteView addContent:@"主要绘图系统，常用于绘制自定义视图，纯C的API，使用Quartz2D做引擎"];
    [_noteView addNounText:@"CoreAnimation:"];
    [_noteView addContent:@"强大的2D和3D动画效果"];
    [_noteView addNounText:@"CoreImage:"];
    [_noteView addContent:@"给图片提供各种滤镜处理，比如高斯模糊、锐化等"];
    [_noteView addNounText:@"OpenGL-ES:"];
    [_noteView addContent:@"用于游戏绘制"];
    
    //---------------
    [_noteView addTitle:@"绘图方式"];
    
    [_noteView addNounText:@"视图绘制:"];
    [_noteView addContent:@"drawRect --> setNeedsDisplay --> CPU"];
    
    [_noteView addNounText:@"视图布局:"];
    [_noteView addContent:@"layoutSubviews --> setNeedsLayout --> GPU"];
    
    //---------------
    [_noteView addTitle:@"状态切换"];
    
    [_noteView addNounText:@"pop / push"];
    [_noteView addContent:@""];
    
    [_noteView addNounText:@"save / restore"];
    [_noteView addContent:@""];
    
    [_noteView addNounText:@"context / imageContext"];
    [_noteView addContent:@""];
    [_noteView addContent:@"UIGraphicsGetCurrentContext --> 获取当前视图的上下文"];
    [_noteView addContent:@"UIGraphicsBeginImageContextWithOptions --> 获取一个图片上下文"];
    [_noteView addContent:@"UIGraphicsGetImageFromCurrentImageContext --> 绘制完成后获取绘制的图片"];
    [_noteView addContent:@"UIGraphicsEndImageContext --> 关闭图片上下文"];
    
    [_noteView addNounText:@"CGPathRef / UIBezierPath"];
    [_noteView addContent:@""];
    [_noteView addContent:@"CGPathRef --> CoreGraphics框架中的路径绘制类"];
    [_noteView addContent:@"UIBezierPath --> 封装CGPathRef的面向OC的类"];
    
    //---------------
    [_noteView addTitle:@"具体绘图方法"];
    
//    _noteView ad
    
    [_noteView endEdit];
}

- (void)buildTV {
    _noteView = [LQFNoteView new];
    [self.view addSubview:_noteView];
    
    UIEdgeInsets padding = UIEdgeInsetsMake(CGRectGetMaxY(self.quoteButton.frame), 20, 20, 20);
    [_noteView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).insets(padding);
    }];
}

@end
