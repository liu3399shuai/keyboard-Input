//
//  NumKeyboardView.m
//
//  Created by liu on 16/1/21.
//  Copyright © 2016年 . All rights reserved.
//

#define keyboardHeight 216
#define SCREEN_WIDTH  [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
#define Font(x)                         [UIFont systemFontOfSize : x]
#define ItalicFont(x)                   [UIFont italicSystemFontOfSize:x]
#define BoldFont(x)                     [UIFont boldSystemFontOfSize : x]

#import "NumKeyboardView.h"

static NumKeyboardView *boardHelper = nil;

@interface NumKeyboardView() <UIInputViewAudioFeedback>

@property (nonatomic,strong) NSArray        *fieldArr;

@property (nonatomic,strong) NSArray        *idArr;

@end

@implementation NumKeyboardView

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

+(void)load
{
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        
        [NumKeyboardView share];
    });
}

+(instancetype)share
{
    static dispatch_once_t once;
    
    dispatch_once(&once, ^{
        boardHelper = [[NumKeyboardView alloc] init];
    });
    
    return boardHelper;
}

-(instancetype)init
{
    self = [super init];
    
    if (self) {
        
        self.backgroundColor = [UIColor blackColor]; // 中间白条线晃眼
        
        self.bounds = CGRectMake(0, 0, SCREEN_WIDTH, keyboardHeight);
        
        _fieldArr = @[@"1",@"2",@"3",@"keyboard_down.png",
                      @"4",@"5",@"6",@"keyboard_dele.png",
                      @"7",@"8",@"9",@"确定",
                      @".",@"0",@"00"];
        
        _idArr = @[@"11",@"12",@"13",@"300",
                   @"14",@"15",@"16",@"100",
                   @"17",@"18",@"19",@"200",
                   @"21",@"10",@"20"];
        
        CGFloat xPos = 0;
        CGFloat yPos = 0;
        CGFloat width = SCREEN_WIDTH/4.f;
        CGFloat height = keyboardHeight/4.f;
        
        for (int i = 0; i < _fieldArr.count; i++) {
            
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.tag = ((NSString *)_idArr[i]).intValue;
            [btn setBackgroundImage:[UIImage imageNamed:@"keyboard_back"] forState:UIControlStateNormal];
            [btn setBackgroundImage:[UIImage imageNamed:@"keyboard_back_sel"] forState:UIControlStateHighlighted];
            [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
            
            NSString *field = _fieldArr[i];
            NSRange range = [field rangeOfString:@"png"];
            
            if (range.length != 0 && range.location != NSNotFound) {
                [btn setImage:[UIImage imageNamed:field] forState:UIControlStateNormal];
                [btn setImage:[UIImage imageNamed:field] forState:UIControlStateHighlighted];
            }else{
                [btn setTitle:field forState:UIControlStateNormal];
                [btn setTitle:field forState:UIControlStateHighlighted];
                btn.titleLabel.font = BoldFont(25);
            }
            
            xPos = width*(i%4);
            yPos = height*(i/4);
            
            btn.frame = CGRectMake(xPos, yPos, width, height+5); // 中间白条线晃眼
            
            if (i == 11) {
                CGRect rect = btn.frame;
                rect.size.height = 2*height;
                btn.frame = rect;
            }
            
            [self addSubview:btn];
        }
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(inputTextF:) name:UITextFieldTextDidBeginEditingNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(inputTextF:) name:UITextFieldTextDidEndEditingNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(inputTextF:) name:UITextFieldTextDidChangeNotification object:nil];
    }
    
    return self;
}

-(void)btnClick:(UIButton *)btn
{
    NSInteger tag = btn.tag;
    
    if (10 <= tag && tag <= 19) {
        [_textField insertText:[NSString stringWithFormat:@"%ld",tag - 10]];
    }else if (tag == 20){
        [_textField insertText:@"00"];
    }else if (tag == 21){
        [_textField insertText:@"."];
    }else if (tag == 100){
        [_textField deleteBackward];
    }else if (tag == 200){
        [_textField resignFirstResponder];
    }else if (tag == 300){
        [_textField resignFirstResponder];
    }else{
        [_textField resignFirstResponder];
    }
    
    [[UIDevice currentDevice] playInputClick];
}

-(BOOL)canInsert
{
    NSUInteger length = 5;
    if (_textField.tag == 1001) {
        length = 5;
    }else if (_textField.tag == 1002){
        length = 10;
    }
    
    return _textField.text.length < length;
}

-(void)setTextField:(UITextField *)textField
{
    _textField = textField;
    
    _textField.inputView = self;
}

#pragma mark - UIInputViewAudioFeedback delegate

- (BOOL)enableInputClicksWhenVisible {
    return YES;
}

-(void)inputTextF:(NSNotification *)noti
{
    UITextField *tf = noti.object;
    if ([tf isKindOfClass:[UITextField class]]) {
        self.textField = tf;
    }
}

@end
