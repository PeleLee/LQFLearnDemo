//
//  MultiThreadView.m
//  LQFLearnDemo
//
//  Created by liqunfei on 2017/8/1.
//  Copyright © 2017年 LQF. All rights reserved.
//

#import "MultiThreadView.h"

@implementation MultiThreadView

- (instancetype)init {
    if (self = [super init]) {
        self.frame = CGRectMake(0, 150, DEVICE_WIDTH, DEVICE_HEIGHT - 150);
    }
    return self;
}

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
- (IBAction)test:(UIButton *)sender {
    NSLog(@"test");
}

@end
