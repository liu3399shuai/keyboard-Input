//
//  KeyboardController.m
//  keyboard&input
//
//  Created by liu on 16/6/7.
//  Copyright © 2016年 liu. All rights reserved.
//

#import "KeyboardController.h"

@interface KeyboardController()

@property (nonatomic,weak) IBOutlet UITextField     *tf;

@end

@implementation KeyboardController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [_tf becomeFirstResponder];
}

@end
