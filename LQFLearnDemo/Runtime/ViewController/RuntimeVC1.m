//
//  RuntimeVC1.m
//  LQFLearnDemo
//
//  Created by liqunfei on 2017/9/14.
//  Copyright © 2017年 LQF. All rights reserved.
//

#import "RuntimeVC1.h"
#import <objc/runtime.h>
#import <objc/message.h>
#import <objc/objc.h>
#import "Person_Runtime.h"
#import "UIImage+PrintResult.h"
#import "NSObject+name.h"
#import "LQFNoteView.h"

@interface RuntimeVC1 ()

@property (nonatomic, strong) LQFNoteView *noteView;

@end

@implementation RuntimeVC1

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.quoteUrl = @"http://www.jianshu.com/p/19f280afcb24";
    [self buildNoteView];
    
    //runtime
    [self msgSend];
    [self exchangeMethod];
    [self addProperty];
}

#pragma mark - 消息机制
- (void)msgSend {
//    Person_Runtime *p = [Person_Runtime alloc];
    Person_Runtime *p = objc_msgSend(objc_getClass("Person_Runtime"), sel_registerName("alloc"));
    
//    p = [p init];
    p = objc_msgSend(p, sel_registerName("init"));
    
    //调用方法
//    [p eat];
    //本质: 让类对象发送消息
    objc_msgSend(p, @selector(eat));
    objc_msgSend([p class], @selector(runM:),10);
//--------------------------- <#我是分割线#> ------------------------------//
    Person_Runtime *p2 = objc_msgSend([Person_Runtime class], @selector(alloc));
    p2 = objc_msgSend(p2, @selector(init));
    
    objc_msgSend(p2, sel_registerName("eat"));
    objc_msgSend([Person_Runtime class], @selector(runM:),20);
}

#pragma mark - 动态交换
- (void)exchangeMethod {
    UIImage *image = ImageNamed(@"");
    UIImage *image2 = ImageNamed(@"August");
    image = nil;
    image2 = nil;
}

#pragma mark - 给系统类动态添加属性
- (void)addProperty {
    NSObject *propertyObj = [[NSObject alloc] init];
    propertyObj.name = @"111";
    NSLog(@"runtime动态添加属性name=%@",propertyObj.name);
}

#pragma mark -

- (LQFNoteView *)noteView {
    if (!_noteView) {
        _noteView = [LQFNoteView new];
        [self.view addSubview:_noteView];
        
        [_noteView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.quoteButton.mas_bottom);
            make.leading.equalTo(self.view).mas_offset(20);
            make.trailing.equalTo(self.view).mas_offset(-20);
            make.bottom.equalTo(self.view);
        }];
        
        UILabel *label = [UILabel new];
        [self.view addSubview:label];
        
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(self.quoteButton);
            make.left.equalTo(self.quoteButton.mas_right);
            make.right.equalTo(self.view);
        }];
        
        label.text = @"具体代码在.m中";
        label.font = [UIFont systemFontOfSize:13.0f];
    }
    return _noteView;
}

- (void)buildNoteView {
    [self.noteView addNounText:@"objc_msgSend"];
    [self.noteView addContent:@""];
    [self.noteView addNounText:@"method_exchangeImplementations:"];
    [self.noteView addContent:@"交换方法地址"];
    [self.noteView addNounText:[NSString stringWithFormat:@"%@\n%@:",@"objc_setAssociatedObject",@"objc_getAssociatedObject"]];
    [self.noteView addContent:@"将某个值跟某个对象关联起来，将某个值存储到某个对象中"];
    [self.noteView endEdit];
}

#pragma mark -
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
