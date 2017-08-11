//
//  RegexVC.m
//  LQFLearnDemo
//
//  Created by liqunfei on 2017/8/3.
//  Copyright © 2017年 LQF. All rights reserved.
//

#import "RegexVC.h"
#import "NSString+LQF.h"

@interface RegexVC ()

@property (nonatomic, strong) NSMutableAttributedString *noteAttStr;
@property (nonatomic, strong) UITextView *noteTV;

@end

@implementation RegexVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navTitle = @"正则表达式";
    self.quoteUrl = @"https://deerchao.net/tutorials/regex/regex.htm";
    
    [self buildNoteTextView];
    [self makeNote];
}

#pragma mark - UI
- (void)buildNoteTextView {
    _noteTV = [[UITextView alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(self.quoteButton.frame), DEVICE_WIDTH - 40, DEVICE_HEIGHT - CGRectGetMaxY(self.quoteButton.frame))];
    _noteTV.editable = NO;
    _noteTV.showsVerticalScrollIndicator = NO;
    [self.view addSubview:_noteTV];
}

- (void)makeNote {
    NSArray *notes = @[
                       [self QStrWithElement:@"hi" explain:@"匹配字符串hi"],
                       [self QStrWithElement:@"\\bhi\\b" explain:@"精确地查找hi这个单词,排除him,history,high等"],
                       [self QStrWithElement:@"\\b" explain:@"单词的开头或结尾，也就是单词的分界处"],
                       [self QStrWithElement:@" . " explain:@"匹配除了换行符以外的任意字符"],
                       [self QStrWithElement:@" * " explain:@"重复零次或更多次"],
                       [self QStrWithElement:@" + " explain:@"重复一次或更多次"],
                       [self QStrWithElement:@" .* " explain:@"任意数量的不包含换行的字符"],
                       [self QStrWithElement:@" ? " explain:@"重复零次或一次"],
                       [self QStrWithElement:@"\\d" explain:@"匹配一位数字(0，或1，或2，或……)"],
                       [self QStrWithElement:@"\\d{2}" explain:@"数字必须连续重复匹配2(或n)次"],
                       [self QStrWithElement:@"\\d{5,12}" explain:@"数字重复的次数不能少于5次，不能多于12次"],
                       [self QStrWithElement:@"{n}" explain:@"重复n次"],
                       [self QStrWithElement:@"{n,}" explain:@"重复n次或更多次"],
                       [self QStrWithElement:@"{n,m}" explain:@"重复n到m次"],
                       [self QStrWithElement:@"\\s" explain:@"匹配任意的空白符，包括空格，制表符(Tab)，换行符，中文全角空格等"],
                       [self QStrWithElement:@"\\w" explain:@"匹配字母或数字或下划线或汉字等"],
                       [self QStrWithElement:@"^" explain:@"匹配字符串的开始"],
                       [self QStrWithElement:@"$" explain:@"匹配字符串的结束"],
                       [self QStrWithElement:@"[ ]" explain:@"字符类,如下面3条"],
                       [self QStrWithElement:@"[aeiou]" explain:@"匹配任何一个英文元音字母"],
                       [self QStrWithElement:@"[.?!]" explain:@"匹配标点符号(.或?或!)"],
                       [self QStrWithElement:@"[0-9]" explain:@"与\\d完全一致"],
                       [self QStrWithElement:@"|" explain:@"分支条件,相当于或,如下面1条"],
                       [self QStrWithElement:@"0\\d{2}-\\d{8}|0\\d{3}-\\d{7}" explain:@"匹配两种以连字号分隔的电话号码：一种是三位区号，8位本地号(如010-12345678)，一种是4位区号，7位本地号(0376-2233445)"],
                       [self QStrWithElement:@"( )" explain:@"指定一个子表达式,也叫作分组,如下面1条"],
                       [self QStrWithElement:@"((2[0-4]\\d|25[0-5]|[01]?\\d\\d?)\\.){3}(2[0-4]\\d|25[0-5]|[01]?\\d\\d?)" explain:@"IP地址匹配(每个数字都不能大于255)"],
                       [self QStrWithElement:@"\\W" explain:@"匹配任意不是字母，数字，下划线，汉字的字符,该条及以下5条均为反义用法"],
                       [self QStrWithElement:@"\\S" explain:@"匹配任意不是空白符的字符"],
                       [self QStrWithElement:@"\\D" explain:@"匹配任意非数字的字符"],
                       [self QStrWithElement:@"\\B" explain:@"匹配不是单词开头或结束的位置"],
                       [self QStrWithElement:@"[^x]" explain:@"匹配除了x以外的任意字符"],
                       [self QStrWithElement:@"[^aeiou]" explain:@"匹配除了aeiou这几个字母以外的任意字符"],
                       [self QStrWithElement:@"后向引用" explain:@"默认情况下，每个分组会自动拥有一个组号，规则是：从左向右，以分组的左括号为标志，第一个出现的分组的组号为1，第二个为2，以此类推。                       后向引用用于重复搜索前面某个分组匹配的文本。"],
                       [self QStrWithElement:@"(?<组名>子表达式)" explain:@"指定子表达式的组名"],
                       [self QStrWithElement:@"(?'组名'子表达式)" explain:@"与上一条相等,指定子表达式的组名"],
                       [self QStrWithElement:@"\\k<组名>" explain:@"通过组名引用某分组"],
                       [self QStrWithElement:@"(exp)" explain:@"匹配exp,并捕获文本到自动命名的组里"],
                       [self QStrWithElement:@"(?<name>exp)或(?'name'exp)" explain:@"匹配exp,并捕获文本到名称为name的组里"],
                       [self QStrWithElement:@"(?:exp)" explain:@"匹配exp,不捕获匹配的文本，也不给此分组分配组号"],
                       [self QStrWithElement:@"(?=exp)" explain:@"匹配exp前面的位置,如下面1条"],
                       [self QStrWithElement:@"\\b\\w+(?=ing\\b)" explain:@"匹配以ing结尾的单词的前面部分(除了ing以外的部分)"],
                       [self QStrWithElement:@"(?<=exp)" explain:@"匹配exp后面的位置,如下面1条"],
                       [self QStrWithElement:@"(?<=\\bre)\\w+\\b" explain:@"匹配以re开头的单词的后半部分(除了re以外的部分)"],
                       [self QStrWithElement:@"(?!exp)" explain:@"断言此位置的后面不能匹配表达式exp,如下面1条"],
                       [self QStrWithElement:@"\\b((?!abc)\\w)+\\b" explain:@"匹配不包含连续字符串abc的单词"],
                       [self QStrWithElement:@"(?<!exp)" explain:@"断言此位置的前面不能匹配表达式exp,如下面1条"],
                       [self QStrWithElement:@"(?<![a-z])\\d{7}" explain:@"匹配前面不是小写字母的七位数字"],
                       [self QStrWithElement:@"(?#comment)" explain:@"包含注释,如下面1条"],
                       [self QStrWithElement:@"2[0-4]\\d(?#200-249)|25[0-5](?#250-255)|[01]?\\d\\d?(?#0-199)" explain:@"注释了匹配的范围"],
                       [self QStrWithElement:@"表达式?" explain:@"懒惰匹配,能使整个匹配成功的前提下使用最少的重复,如下面2个例子"],
                       [self QStrWithElement:@"a.*b" explain:@"匹配最长的以a开始，以b结束的字符串"],
                       [self QStrWithElement:@"a.*?b" explain:@"匹配最短的，以a开始，以b结束的字符串"]
                       ];
    [self addStrToNoteStr:notes];
}

- (NSMutableAttributedString *)QStrWithElement:(NSString *)element explain:(NSString *)explain {
    NSString *QStr = [NSString stringWithFormat:@"%@ : %@\n\n",[NSString addQuotationMark:element],explain];
    NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithString:QStr];
    [attStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:13.0f] range:NSMakeRange(0, QStr.length)];
    [attStr addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:NSMakeRange(0, QStr.length)];
    [attStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:15.0f] range:NSMakeRange(1, element.length)];
    [attStr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(1, element.length)];
    
    return attStr;
}

- (void)addStrToNoteStr:(NSArray *)subAttStrs {
    for (NSInteger i = 0; i < subAttStrs.count; i++) {
        NSMutableAttributedString *attStr = subAttStrs[i];
        NSAttributedString *indexAttStr = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"%ld.",i + 1]];
        [self.noteAttStr appendAttributedString:indexAttStr];
        [self.noteAttStr appendAttributedString:attStr];
    }
    
    _noteTV.attributedText = _noteAttStr;
}

- (NSMutableAttributedString *)noteAttStr {
    if (!_noteAttStr) {
        _noteAttStr = [[NSMutableAttributedString alloc] init];
    }
    return _noteAttStr;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
