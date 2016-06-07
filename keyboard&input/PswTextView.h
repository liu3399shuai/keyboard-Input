//
//  PswTextView.h
//
//  Created by liu on 15/9/18.
//  Copyright (c) 2015年 . All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PswTextView : UIView

@property (nonatomic,strong) NSString *text;

+(CGRect)bigBounds;

-(void)pswText:(void(^)(NSString *))text;

@end
