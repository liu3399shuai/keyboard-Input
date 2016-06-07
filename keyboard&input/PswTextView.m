//
//  PswTextView.m
//
//  Created by liu on 15/9/18.
//  Copyright (c) 2015年 . All rights reserved.
//

#define bigBgImg [UIImage imageNamed:@"pswBgBig"]
#define bigBgImgErr [UIImage imageNamed:@"pswBgBigErr"]
#define circleImg [UIImage imageNamed:@"pswCircle"]

#import "PswTextView.h"
#import "NSString+Extension.h"

@interface PswTextView() <UIKeyInput>
{
    NSMutableString *_textStore;
    
    void(^textBlock)(NSString *);
}
@end

@implementation PswTextView

+(CGRect)bigBounds
{
    return CGRectMake(0, 0, bigBgImg.size.width, bigBgImg.size.height);
}

-(void)awakeFromNib
{
    [super awakeFromNib];
    
    [self initital];
}

-(id)init
{
    self = [super init];
    
    if (self) {
        [self initital];
    }
    
    return self;
}

-(void)initital
{
    self.backgroundColor = [UIColor whiteColor];
    
    _textStore = [[NSMutableString alloc] init];
    self.userInteractionEnabled = YES;
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(becomeFirstResponder)];
    gesture.cancelsTouchesInView = NO;
    [self addGestureRecognizer:gesture];
}

-(void)drawRect:(CGRect)rect
{
    [bigBgImg drawInRect:rect];
    
    for (int i = 0; i < _textStore.length; i++) {
        CGFloat itemWidth = self.bounds.size.width/6.f;
        CGFloat x = itemWidth*i + (itemWidth-circleImg.size.width)/2.f;
        [circleImg drawInRect:CGRectMake(x, (self.bounds.size.height-circleImg.size.height)/2.f, circleImg.size.width, circleImg.size.height)];
    }
    
    if (textBlock) {
        textBlock(_textStore);
    }
}

- (BOOL)canBecomeFirstResponder
{
    return YES;
}

- (BOOL)becomeFirstResponder
{
    [_textStore setString:@""];
    [self setNeedsDisplay];
    
    return [super becomeFirstResponder];
}
#pragma mark UIKeyInput delegate

- (void)deleteBackward
{
    if (_textStore.length == 0) {
        return;
    }
    
    NSRange theRange = NSMakeRange(_textStore.length - 1, 1);
    [_textStore deleteCharactersInRange:theRange];
    
    [self setNeedsDisplay];
}

- (void)insertText:(NSString *)text
{
    if (_textStore.length == 6) {
        return;
    }
    
    if (![text isPureNumber]) {
        return;
    }
    
    [_textStore appendString:text];
    
    [self setNeedsDisplay];
}

- (BOOL)hasText
{
    return (_textStore.length > 0);
}

#pragma mark UITextInputTraits delegate

- (UIKeyboardType)keyboardType
{
    return UIKeyboardTypeNumberPad;
}

#pragma mark action

-(void)pswText:(void (^)(NSString *))text
{
    textBlock = text;
}

-(NSString *)text
{
    return _textStore;
}

@end
