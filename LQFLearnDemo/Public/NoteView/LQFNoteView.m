//
//  LQFNoteView.m
//  LQFLearnDemo
//
//  Created by liqunfei on 2017/8/11.
//  Copyright © 2017年 LQF. All rights reserved.
//

#import "LQFNoteView.h"

@interface LQFNoteView()

@property (nonatomic, strong) NSMutableAttributedString *note;

@end

@implementation LQFNoteView

- (instancetype)init {
    if (self == [super init]) {
        _note = [[NSMutableAttributedString alloc] init];
        self.editable = NO;
        self.showsVerticalScrollIndicator = NO;
    }
    return self;
}

- (void)addTitle:(NSString *)title {
    NSString *needStr = [NSString stringWithFormat:@"%@\n\n",title];
    NSMutableAttributedString *aStr = [[NSMutableAttributedString alloc] initWithString:needStr];
    
    [aStr addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:15] range:NSMakeRange(0, title.length)];
    [aStr addAttribute:NSForegroundColorAttributeName value:MyBlue range:NSMakeRange(0, title.length)];
    
    [_note appendAttributedString:aStr];
}

- (void)addContent:(NSString *)content {
    NSString *needStr = [NSString stringWithFormat:@"%@\n\n",content];
    NSMutableAttributedString *aStr = [[NSMutableAttributedString alloc] initWithString:needStr];
    [aStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:13] range:NSMakeRange(0, content.length)];
    
    [_note appendAttributedString:aStr];
}

- (void)addNounText:(NSString *)noun {
    NSMutableAttributedString *aStr = [[NSMutableAttributedString alloc] initWithString:noun];
    [aStr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0, noun.length)];
    [aStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:13] range:NSMakeRange(0, noun.length)];
    
    [_note appendAttributedString:aStr];
}

- (void)endEdit {
    self.attributedText = _note;
}

@end
