//
//  MultiThreadView.m
//  LQFLearnDemo
//
//  Created by liqunfei on 2017/8/1.
//  Copyright © 2017年 LQF. All rights reserved.
//

#import "MultiThreadView.h"
#import "LQFOperation.h"

@interface MultiThreadView()
@property (weak, nonatomic) IBOutlet UIButton *hiddenBtn;
@property (weak, nonatomic) IBOutlet UIImageView *myImage;

@end

@implementation MultiThreadView

- (instancetype)init {
    if (self = [super init]) {
        self.frame = CGRectMake(0, 150, DEVICE_WIDTH, DEVICE_HEIGHT - 150);
    }
    return self;
}

#pragma mark - NSOperation
- (IBAction)actionNSOperation:(UIButton *)sender {
    NSInteger tag = sender.tag;
    switch (tag) {
        case 301:
        {
            [self testNSInvocationOperation];
        }
            break;
        case 302:
        {
            [self testNSBlockOperation];
        }
            break;
        case 303:
        {
            [self testLQFOperation];
        }
            break;
        case 304:
        {
            [self testNSBlockOperationExecution];
        }
            break;
        case 305:
        {
            [self testAddOperation];
        }
            break;
        case 306:
        {
            [self testAddOperationWithBlock];
        }
            break;
        case 307:
        {
            [self communicationBetweenOperationThread];
        }
            break;
        case 308:
        {
            [self testMaxConcurrentOperationCount];
        }
            break;
        case 309:
        {
            [self testAddDependency];
        }
            break;
        case 310:
        {
            self.hiddenBtn.hidden = YES;
            self.myImage.hidden = YES;
        }
            break;
            
        default:
            break;
    }
}

#pragma mark NSInvocationOperation
- (void)testNSInvocationOperation {
    //创建NSInvocationOperation
    NSInvocationOperation *invocationOperation = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(invocationOperation) object:nil];
    //开始执行操作
    [invocationOperation start];
}

- (void)invocationOperation {
    NSLog(@"NSInvocationOperation包含的任务,没有加入队列========%@",[NSThread currentThread]);
}

#pragma mark NSBlockOperation
- (void)testNSBlockOperation {
    NSBlockOperation *blockOperation = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"NSBlockOperation包含的任务,没有加入队列=======%@",[NSThread currentThread]);
    }];
    [blockOperation start];
}

#pragma mark 继承自NSOperation的子类
- (void)testLQFOperation {
    LQFOperation *operation = [[LQFOperation alloc] init];
    [operation start];
}

#pragma mark addExecutionBlock实现多线程
- (void)testNSBlockOperationExecution {
    NSBlockOperation *blockOperation = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"NSBlockOperation运用addExcutionBlock=========%@",[NSThread currentThread]);
    }];
    
    [blockOperation addExecutionBlock:^{
        NSLog(@"addExecutionBlock方法添加任务1=======%@",[NSThread currentThread]);
    }];
    
    [blockOperation addExecutionBlock:^{
        NSLog(@"addExecutionBlock方法添加任务2=======%@",[NSThread currentThread]);
    }];
    
    [blockOperation addExecutionBlock:^{
        NSLog(@"addExecutionBlock方法添加任务3=======%@",[NSThread currentThread]);
    }];
    
    [blockOperation start];
}

#pragma mark addOperation
- (void)testAddOperation {
    //创建队列，默认并发
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    
    //创建操作，NSInvocationOperation
    NSInvocationOperation *invocationOperation = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(invocationOperationAddOperation) object:nil];
    //创建操作，NSBlockOperation
    NSBlockOperation *blockOperation = [NSBlockOperation blockOperationWithBlock:^{
        for (NSInteger i = 0; i < 3; i++) {
            NSLog(@"addOperation把任务添加到队列========%@",[NSThread currentThread]);
        }
    }];
    
    [queue addOperation:invocationOperation];
    [queue addOperation:blockOperation];
}

- (void)invocationOperationAddOperation {
    NSLog(@"invocationOperation===addOperation把任务添加到队列==========%@",[NSThread currentThread]);
}

#pragma mark addOperationWithBlock
- (void)testAddOperationWithBlock {
    //创建队列，默认并发
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    
    //添加操作到队列
    [queue addOperationWithBlock:^{
        for (NSInteger i = 0; i < 3; i++) {
            NSLog(@"addOperationWithBlock把任务添加到队列======%@",[NSThread currentThread]);
        }
    }];
}

#pragma mark NSOperation 线程间通信
- (void)communicationBetweenOperationThread {
    [SVProgressHUD showWithStatus:@"Waiting..."];
    
    //创建队列，默认并发
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    
    //在子线程进行耗时操作
    [queue addOperationWithBlock:^{
        //耗时操作放在这里,例如下载图片。（使用线程休眠3秒来模拟耗时操作）
        [NSThread sleepForTimeInterval:3];
        UIImage *image = [UIImage imageNamed:@"August"];
        
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            self.myImage.image = image;
            self.hiddenBtn.hidden = NO;
            self.myImage.hidden = NO;
            [SVProgressHUD dismiss];
        }];
    }];
}

#pragma mark 最大并发数
- (void)testMaxConcurrentOperationCount {
    //创建队列，默认并发
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    
    //最大并发数为1，串行
//    queue.maxConcurrentOperationCount = 1;
    
    //最大并发数为2...n，并发
    queue.maxConcurrentOperationCount = 3;
    
    //添加操作到队列
    [queue addOperationWithBlock:^{
        for (NSInteger i = 0; i < 3; i++) {
            NSLog(@"addOperationWithBlock把任务添加到队列1=======%@ i:%ld",[NSThread currentThread],(long)i);
        }
    }];
    
    //添加操作到队列
    [queue addOperationWithBlock:^{
        for (NSInteger i = 0; i < 3; i++) {
            NSLog(@"addOperationWithBlock把任务添加到队列2=======%@ i:%ld",[NSThread currentThread],(long)i);
        }
    }];
    
    //添加操作到队列
    [queue addOperationWithBlock:^{
        for (NSInteger i = 0; i < 3; i++) {
            NSLog(@"addOperationWithBlock把任务添加到队列3=======%@ i:%ld",[NSThread currentThread],(long)i);
        }
    }];
}

#pragma mark 操作依赖
- (void)testAddDependency {
    //并发队列
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    
    //操作1
    NSBlockOperation *operation1 = [NSBlockOperation blockOperationWithBlock:^{
        for (NSInteger i = 0; i < 3; i++) {
            NSLog(@"operation1======%@",[NSThread currentThread]);
        }
    }];
    
    //操作2
    NSBlockOperation *operation2 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"****operation2依赖于operation1,只有当operation1执行完毕,operation2才会执行****");
        for (NSInteger i = 0; i < 3; i++) {
            NSLog(@"operation2=====%@",[NSThread currentThread]);
        }
    }];
    
    //使操作2依赖于操作1
    [operation2 addDependency:operation1];
    
    //把操作加入队列
    [queue addOperation:operation1];
    [queue addOperation:operation2];
}

#pragma mark - GCD
- (IBAction)actionGCD:(UIButton *)sender {
    NSInteger tag = sender.tag;
    switch (tag) {
        case 201:
        {
            [self syncSerial];
        }
            break;
        case 202:
        {
            [self asyncSerial];
        }
            break;
        case 203:
        {
            [self syncConcurrent];
        }
            break;
        case 204:
        {
            [self asyncConcurrent];
        }
            break;
        case 205:
        {
            /** 主队列同步，放到主线程会死锁，所以这里开了一条线程 */
            dispatch_async(dispatch_get_global_queue(0, 0), ^{
                [self syncMain];
            });
        }
            break;
        case 206:
        {
            [self asyncMain];
        }
            break;
        case 207:
        {
            [self communicationBetweenThreads];
        }
            break;
        case 208:
        {
            [self threadGroup];
        }
            break;
        case 209:
        {
            [self applyGCD];
        }
            break;
        case 210:
        {
            [self barrierGCD];
        }
            break;
        case 211:
        {
            self.hiddenBtn.hidden = YES;
            self.myImage.image = nil;
            self.myImage.hidden = YES;
        }
            break;
        default:
            break;
    }
}

#pragma mark 串行同步
/**
 串行队列中执行同步操作 结果为同步执行
 */
- (void)syncSerial {
    NSLog(@"\n\n**************串行同步***************\n\n");
    //串行队列
    dispatch_queue_t queue = dispatch_queue_create("test", DISPATCH_QUEUE_SERIAL);
    
    //同步执行
    dispatch_sync(queue, ^{
        for (NSInteger i = 0; i < 3; i++) {
            NSLog(@"串行同步1 i:%ld %@",(long)i,[NSThread currentThread]);
        }
    });
    dispatch_sync(queue, ^{
        for (NSInteger i = 0; i < 3; i++) {
            NSLog(@"串行同步2 i:%ld %@",(long)i,[NSThread currentThread]);
        }
    });
    dispatch_sync(queue, ^{
        for (NSInteger i = 0; i < 3; i++) {
            NSLog(@"串行同步3 i:%ld %@",(long)i,[NSThread currentThread]);
        }
    });
}

#pragma mark 串行异步
/**
 串行队列中执行异步操作 无效，结果仍然是同步执行
 */
- (void)asyncSerial {
    NSLog(@"\n\n**************串行异步***************\n\n");
    
    //串行队列
    dispatch_queue_t queue = dispatch_queue_create("test", DISPATCH_QUEUE_SERIAL);
    
    //异步执行 (无效)
    dispatch_async(queue, ^{
        for (NSInteger i = 0; i < 100; i++) {
            NSLog(@"串行异步1 i:%ld thread:%@",(long)i,[NSThread currentThread]);
        }
    });
    dispatch_async(queue, ^{
        for (NSInteger i = 0; i < 3; i++) {
            NSLog(@"串行异步2 i:%ld thread:%@",(long)i,[NSThread currentThread]);
        }
    });
    dispatch_async(queue, ^{
        for (NSInteger i = 0; i < 3; i++) {
            NSLog(@"串行异步3 i:%ld thread:%@",(long)i,[NSThread currentThread]);
        }
    });
}

#pragma mark 并发同步
/**
 并发队列中执行同步操作 最终结果为同步执行
 */
- (void)syncConcurrent {
    NSLog(@"\n\n**************并发同步***************\n\n");
    
    //创建并发队列
    dispatch_queue_t queue = dispatch_queue_create("test", DISPATCH_QUEUE_CONCURRENT);
    
    //同步执行
    dispatch_sync(queue, ^{
        for (NSInteger i = 0; i < 10; i++) {
            NSLog(@"并发同步1 i:%ld thread:%@",(long)i,[NSThread currentThread]);
        }
    });
    dispatch_sync(queue, ^{
        for (NSInteger i = 0; i < 3; i++) {
            NSLog(@"并发同步2 i:%ld thread:%@",(long)i,[NSThread currentThread]);
        }
    });
    dispatch_sync(queue, ^{
        for (NSInteger i = 0; i < 3; i++) {
            NSLog(@"并发同步3 i:%ld thread:%@",(long)i,[NSThread currentThread]);
        }
    });
}

#pragma mark 并发异步
/**
 并发队列执行异步操作 最终为异步执行
 */
- (void)asyncConcurrent {
    NSLog(@"\n\n**************并发异步***************\n\n");
    
    //并发队列
    dispatch_queue_t queue = dispatch_queue_create("test", DISPATCH_QUEUE_CONCURRENT);
    
    //异步执行
    dispatch_async(queue, ^{
        for (NSInteger i = 0; i < 10; i++) {
            NSLog(@"并发异步1 i:%ld thread:%@",(long)i,[NSThread currentThread]);
        }
    });
    dispatch_async(queue, ^{
        for (NSInteger i = 0; i < 3; i++) {
            NSLog(@"并发异步2 i:%ld thread:%@",(long)i,[NSThread currentThread]);
        }
    });
    dispatch_async(queue, ^{
        for (NSInteger i = 0; i < 3; i++) {
            NSLog(@"并发异步3 i:%ld thread:%@",(long)i,[NSThread currentThread]);
        }
    });
}

#pragma mark 主队列同步
- (void)syncMain {
    NSLog(@"\n\n**************主队列同步，放到主线程会死锁，现在是在新开的一条线程上执行***************\n\n");
    
    //主队列
    dispatch_queue_t queue = dispatch_get_main_queue();
    
    dispatch_sync(queue, ^{
        for (NSInteger i = 0; i < 10; i++) {
            NSLog(@"主队列同步1 i:%ld thread:%@",(long)i,[NSThread currentThread]);
        }
    });
    dispatch_sync(queue, ^{
        for (NSInteger i = 0; i < 3; i++) {
            NSLog(@"主队列同步2 i:%ld thread:%@",(long)i,[NSThread currentThread]);
        }
    });
    dispatch_sync(queue, ^{
        for (NSInteger i = 0; i < 3; i++) {
            NSLog(@"主队列同步3 i:%ld thread:%@",(long)i,[NSThread currentThread]);
        }
    });
}

#pragma mark 主线程异步
/**
 在主线程执行异步操作 无效，仍然是同步执行
 */
- (void)asyncMain {
    NSLog(@"\n\n**************主队列异步***************\n\n");
    
    //主队列
    dispatch_queue_t queue = dispatch_get_main_queue();
    
    dispatch_async(queue, ^{
        for (NSInteger i = 0; i < 10; i++) {
            NSLog(@"主队列异步1 i:%ld thread:%@",(long)i,[NSThread currentThread]);
        }
    });
    dispatch_async(queue, ^{
        for (NSInteger i = 0; i < 3; i++) {
            NSLog(@"主队列异步2 i:%ld thread:%@",(long)i,[NSThread currentThread]);
        }
    });
    dispatch_async(queue, ^{
        for (NSInteger i = 0; i < 3; i++) {
            NSLog(@"主队列异步3 i:%ld thread:%@",(long)i,[NSThread currentThread]);
        }
    });
}

#pragma mark 线程间通信
- (void)communicationBetweenThreads {
    [SVProgressHUD showWithStatus:@"Waiting..."];
    
    //异步
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        //耗时操作放在这里,例如下载图片。（使用线程休眠3秒来模拟耗时操作）
        [NSThread sleepForTimeInterval:3];
        UIImage *image = [UIImage imageNamed:@"August"];
        
        //回到主线程处理UI
        dispatch_async(dispatch_get_main_queue(), ^{
            self.hiddenBtn.hidden = NO;
            self.myImage.hidden = NO;
            self.myImage.image = image;
            [SVProgressHUD dismiss];
        });
    });
}

#pragma mark GCD队列组
- (void)threadGroup {
    NSLog(@"\n\n************** GCD队列组 ***************\n\n");
    
    dispatch_group_t group = dispatch_group_create();
    
    dispatch_group_async(group, dispatch_get_global_queue(0, 0), ^{
        [NSThread sleepForTimeInterval:2];
        NSLog(@"队列组 step1: 有一个耗时操作完成!");
    });
    
    dispatch_group_async(group, dispatch_get_global_queue(0, 0), ^{
        [NSThread sleepForTimeInterval:1];
        NSLog(@"队列组 step2: 有一个耗时操作完成！");
    });
    
    dispatch_group_async(group, dispatch_get_global_queue(0, 0), ^{
        NSLog(@"队列组 step3: 正在进行耗时操作,请稍等...");
    });
    
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        NSLog(@"队列组 step4: 前面的耗时操作完成了,回到主线程");
    });
}

#pragma mark 快速迭代
- (void)applyGCD {
    NSLog(@"\n\n************** GCD快速迭代 ***************\n\n");
    
    //并发队列
    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
    
    //dispatch_apply 几乎同时便利多个数字
    dispatch_apply(10, queue, ^(size_t index) {
        NSLog(@"dispatch_apply: %zd======%@",index,[NSThread currentThread]);
    });
}

#pragma mark GCD栅栏
- (void)barrierGCD {
    //并发队列
    dispatch_queue_t queue = dispatch_queue_create("test", DISPATCH_QUEUE_CONCURRENT);
    
    //异步执行
    dispatch_async(queue, ^{
        for (NSInteger i = 0; i < 3; i++) {
            NSLog(@"栅栏 : 并发异步1 i:%ld, %@",(long)i,[NSThread currentThread]);
        }
    });
    dispatch_async(queue, ^{
        for (NSInteger i = 0; i < 10; i++) {
            NSLog(@"栅栏 : 并发异步2 i:%ld, %@",(long)i,[NSThread currentThread]);
        }
    });
    
    dispatch_barrier_async(queue, ^{
        NSLog(@"------------barrier------------%@",[NSThread currentThread]);
        NSLog(@"******** 并发异步执行，但是34一定在12后面 **********");
    });
    
    dispatch_async(queue, ^{
        for (NSInteger i = 0; i < 3; i++) {
            NSLog(@"栅栏 : 并发异步3 i:%ld, %@",(long)i,[NSThread currentThread]);
        }
    });
    
    dispatch_async(queue, ^{
        for (NSInteger i = 0; i < 10; i++) {
            NSLog(@"栅栏 : 并发异步4 i:%ld, %@",(long)i,[NSThread currentThread]);
        }
    });
}

#pragma mark - NSThread

- (IBAction)createNSThread:(UIButton *)sender {
    NSInteger tag = sender.tag;
    switch (tag) {
        case 101:
        {
            NSThread *thread1 = [[NSThread alloc] initWithTarget:self selector:@selector(doSomething1:) object:@"NSThread1"];
            thread1.name = @"thread1";
            // 线程加入线程池等待CPU调度，时间很快，几乎是立刻执行
            [thread1 start];
        }
            break;
        case 102:
        {
            //创建之后自动启动
            [NSThread detachNewThreadSelector:@selector(doSomething2:) toTarget:self withObject:@"NSThread2"];
//            [NSThread detachNewThreadWithBlock:^{
//                NSLog(@"doSomething4 线程:%@",[NSThread currentThread]);
//            }];
        }
            break;
        case 103:
        {
            //隐式创建，直接启动
            [self performSelectorInBackground:@selector(doSomething3:) withObject:@"NSThread3"];
        }
            break;
        default:
            break;
    }
}

- (void)doSomething1:(NSObject *)object {
    NSLog(@"doSomething1 参数:%@, 线程:%@",object,[NSThread currentThread]);
}

- (void)doSomething2:(NSObject *)object {
    NSLog(@"doSomething2 参数:%@, 线程:%@",object,[NSThread currentThread]);
}

- (void)doSomething3:(NSObject *)object {
    NSLog(@"doSomething3 参数:%@, 线程:%@",object,[NSThread currentThread]);
}

#pragma mark - setIndex

- (void)setIndex:(NSInteger)index {
    _index = index;
    switch (index) {
        case 0:
        {
            NSArray *nibArr = [[NSBundle mainBundle] loadNibNamed:@"NSThreadView" owner:self options:nil];
            UIView *view = (UIView *)[nibArr lastObject];
            [view setFrame:self.bounds];
            [self addSubview:view];
        }
            break;
        case 1:
        {
            NSArray *nibArr = [[NSBundle mainBundle] loadNibNamed:@"GCDView" owner:self options:nil];
            UIView *view = (UIView *)[nibArr lastObject];
            [view setFrame:self.bounds];
            [self addSubview:view];
        }
            break;
        case 2:
        {
            NSArray *nibArr = [[NSBundle mainBundle] loadNibNamed:@"NSOperationView" owner:self options:nil];
            UIView *view = (UIView *)[nibArr lastObject];
            [view setFrame:self.bounds];
            [self addSubview:view];
        }
            break;
            
        default:
            break;
    }
}


@end
