//
//  NSString+Extension.m
//
//  Created by liu on 16/6/7.
//  Copyright © 2016年 liu. All rights reserved.
//

#import "NSString+Extension.h"

static NSString *pureNumber = @"0123456789";

@implementation NSString (Extension)

-(BOOL)isPureNumber
{
    for (int i =0; i < self.length; i++) {
        NSString *sub = [self substringWithRange:NSMakeRange(i, 1)];
        NSRange range = [pureNumber rangeOfString:sub];
        if (range.location != NSNotFound && range.length != 0) {
            
        }else{
            return NO;
        }
    }
    
    return YES;
}

@end
