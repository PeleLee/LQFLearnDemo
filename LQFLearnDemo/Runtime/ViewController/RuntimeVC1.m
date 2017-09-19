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
#import "Runtime_Archiving.h"
#import "Runtime_Archiving2.h"

@interface RuntimeVC1 ()

@property (nonatomic, strong) LQFNoteView *noteView;

@property (nonatomic, strong) Person_Runtime *xiaoli;

@property (nonatomic, strong) NSFileManager *fileManager;

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
    [self dictToModel];
    [self addMethod];
    [self variableControl];
    [self encodeAndAdecoder];
    [self runtimeAboutClass];
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

#pragma mark - 字典转model
- (void)dictToModel {
    NSString *path = [[NSBundle mainBundle] pathForResource:@"Runtime_model.plist" ofType:nil];
    NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:path];
    
    Person_Runtime *model = [Person_Runtime modelWithDict:dict];
    
//    NSLog(@"%@",model.attitudes_count);
//    NSLog(@"%@",model.idstr);
    NSLog(@"user1:%@",model.user);
    NSLog(@"pic_urls1:%@",model.pic_urls);
    NSLog(@"----1----");
    
    Person_Runtime *model2 = [Person_Runtime modelWithDict2:dict];
    NSLog(@"user2%@",model2.user);
    NSLog(@"pic_urls2%@",model2.pic_urls);
    NSLog(@"----2----");
    
    Person_Runtime *model3 = [Person_Runtime modelWithDict3:dict];
    NSLog(@"user3%@",model3.user);
    NSLog(@"pic_urls3%@",model3.pic_urls);
    NSLog(@"----3----");
    
}

#pragma mark - 动态添加方法

- (void)addMethod {
    Person_Runtime *p = [[Person_Runtime alloc] init];
    [p performSelector:@selector(eat) withObject:nil];
    [p performSelector:@selector(run:) withObject:@10];
    NSLog(@"-----addMethod-----");
}

#pragma mark - 动态变量控制

- (void)variableControl {
    NSLog(@"原始值:%@",self.xiaoli.name);
    [self answer];
    NSLog(@"修改后的值:%@",self.xiaoli.name);
}

- (Person_Runtime *)xiaoli {
    if (!_xiaoli) {
        _xiaoli = [[Person_Runtime alloc] init];
        _xiaoli.name = @"李白";
    }
    return _xiaoli;
}

- (void)answer {
    unsigned int count = 0;
    Ivar *ivar = class_copyIvarList([self.xiaoli class], &count);
    for (NSInteger i = 0; i < count; i++) {
        Ivar var = ivar[i];
        const char *varName = ivar_getName(var);
        NSString *name = [NSString stringWithUTF8String:varName];
        if ([name isEqualToString:@"_name"]) {
            object_setIvar(self.xiaoli, var, @"李清照");
            break;
        }
    }
}

#pragma mark - 归档与解归档
- (void)encodeAndAdecoder {
    NSDictionary *dict = @{@"one":@"l",
                           @"two":@"q",
                           @"three":@"f",
                           @"four":@"w",
                           @"five":@"y"};
    //不实现归档方法 会崩掉
//    Runtime_Archiving *model = [[Runtime_Archiving alloc] initWithDict:dict];
    Runtime_Archiving2 *model2 = [[Runtime_Archiving2 alloc] initWithDict:dict];
    
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    NSString *folderPath = [NSString stringWithFormat:@"%@/Runtime",path];
    if (![self.fileManager fileExistsAtPath:folderPath]) {
        [self.fileManager createDirectoryAtPath:folderPath withIntermediateDirectories:YES attributes:nil error:nil];
    }
    
    /*
    //归档
    NSString *model1Path = [NSString stringWithFormat:@"%@/model1",folderPath];
    BOOL isSaveSuccess = [NSKeyedArchiver archiveRootObject:model toFile:model1Path];
    if (isSaveSuccess) {
        //解归档
        NSData *data = [self.fileManager contentsAtPath:model1Path];
        //不实现解归档方法 会崩掉
        Runtime_Archiving *aaa = [NSKeyedUnarchiver unarchiveObjectWithData:data];
        
        NSLog(@"-----model-----");
        NSLog(@"1:%@",aaa.proPerty1);
        NSLog(@"1:%@",aaa.proPerty2);
        NSLog(@"1:%@",aaa.proPerty3);
        NSLog(@"1:%@",aaa.proPerty4);
        NSLog(@"1:%@",aaa.proPerty5);
    }*/
    
    //归档
    NSString *model2Path = [NSString stringWithFormat:@"%@/model1",folderPath];
    BOOL isSaveSuccess2 = [NSKeyedArchiver archiveRootObject:model2 toFile:model2Path];
    if (isSaveSuccess2) {
        //解归档
        NSData *data = [self.fileManager contentsAtPath:model2Path];
        Runtime_Archiving2 *bbb = [NSKeyedUnarchiver unarchiveObjectWithData:data];
        
        NSLog(@"-----model2-----");
        NSLog(@"2:%@",bbb.proPerty1);
        NSLog(@"2:%@",bbb.proPerty2);
        NSLog(@"2:%@",bbb.proPerty3);
        NSLog(@"2:%@",bbb.proPerty4);
        NSLog(@"2:%@",bbb.proPerty5);
    }
}

#pragma mark - 类相关操作
- (void)runtimeAboutClass {
    NSLog(@"-----类相关操作-----");
    NSLog(@"-----获取属性列表-----");
    unsigned int count = 0;
    objc_property_t *propertyList = class_copyPropertyList([self class], &count);
    for (unsigned int i = 0; i < count; i++) {
        const char *propertyName = property_getName(propertyList[i]);
        NSLog(@"property--->%@",[NSString stringWithUTF8String:propertyName]);
    }
    
    NSLog(@"-----获取方法列表-----");
    unsigned int methodCount = 0;
    Method *methodList = class_copyMethodList([self class], &methodCount);
    for (unsigned int i = 0; i < methodCount; i++) {
        Method method = methodList[i];
        NSLog(@"method--->%@",NSStringFromSelector(method_getName(method)));
    }
    
    NSLog(@"-----获取成员变量列表-----");
    unsigned int ivarCount = 0;
    Ivar *ivarList = class_copyIvarList([self class], &ivarCount);
    for (unsigned int i = 0; i < count; i++) {
        Ivar myIvar = ivarList[i];
        const char *ivarName = ivar_getName(myIvar);
        NSLog(@"Ivar-->%@",[NSString stringWithUTF8String:ivarName]);
    }
    
    NSLog(@"-----获取协议列表-----");
    unsigned int protocolCount = 0;
    __unsafe_unretained Protocol **protocolList = class_copyProtocolList([self class], &protocolCount);
    for (unsigned int i = 0; i < protocolCount; i++) {
        Protocol *myProtocol = protocolList[i];
        const char *protocolName = protocol_getName(myProtocol);
        NSLog(@"protocol---->%@",[NSString stringWithUTF8String:protocolName]);
    }
    
    /*待考证
    NSLog(@"-----获取类方法-----");
    Class personClass = object_getClass([Person_Runtime class]);
    SEL oriSEL = @selector(modelWithDict:);
    Method oriMethod = class_getClassMethod(personClass, oriSEL);
    const char *oriMethodName = method_getName(oriMethod);
    NSString *methodName = [NSString stringWithUTF8String:oriMethodName];
    NSLog(@"类方法%@",methodName);*/
 
    NSLog(@"-----得到实例变量的ivar指针并修改值-----");
    Ivar oneIvar = class_getInstanceVariable([Person_Runtime class], "_name");
    object_setIvar(self.xiaoli, oneIvar, @"李商隐");
    NSLog(@"%@",self.xiaoli.name);
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
    [self.noteView addNounText:@"class_copyIvarList:"];
    [self.noteView addContent:@"获取类中的所有成员变量"];
    [self.noteView addNounText:@"ivar_getName:"];
    [self.noteView addContent:@"获取变量名字,通过[NSString stringWithUTF8String:ivar_getName(ivar)]转化为字符串"];
    [self.noteView addNounText:@"object_setIvar:"];
    [self.noteView addContent:@"修改对应的字段的值"];
    [self.noteView addNounText:@"class_copyPropertyList:"];
    [self.noteView addContent:@"获取类中所有属性列表"];
    [self.noteView addNounText:@"class_copyMethodList:"];
    [self.noteView addContent:@"获取方法列表"];
    [self.noteView addNounText:@"class_copyProtocolList:"];
    [self.noteView addContent:@"获取类协议列表"];
    [self.noteView addNounText:@"class_getInstanceVariable:"];
    [self.noteView addContent:@"得到某个变量指针"];
    [self.noteView endEdit];
}

#pragma mark - set/get
- (NSFileManager *)fileManager {
    if (!_fileManager) {
        _fileManager = [NSFileManager defaultManager];
    }
    return _fileManager;
}

#pragma mark -
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
