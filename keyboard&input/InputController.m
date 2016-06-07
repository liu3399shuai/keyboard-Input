//
//  InputController.m
//  keyboard&input
//
//  Created by liu on 16/6/7.
//  Copyright © 2016年 liu. All rights reserved.
//

#import "InputController.h"
#import "PswTextView.h"

@interface InputController()

@property (nonatomic, weak) IBOutlet PswTextView        *numPwdView;

@end

@implementation InputController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [_numPwdView pswText:^(NSString *psw) {
        
        NSLog(@"psw %@",psw);
    }];
    
    [_numPwdView becomeFirstResponder];
}

@end
