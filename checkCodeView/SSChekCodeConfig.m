//
//  SSChekCodeConfig.m
//  checkCodeView
//
//  Created by wangweiyi on 2018/7/31.
//  Copyright © 2018年 demo. All rights reserved.
//

#import "SSChekCodeConfig.h"

@implementation SSChekCodeConfig

- (instancetype)init
{
    if (self = [super init]) {
        self.borderColor = [UIColor lightGrayColor];
        self.borderSelectedColor = [UIColor redColor];
        self.isSecret = YES;
        self.isShowCursor = NO;
        self.cornerRadius = 0.f;
        self.space = -.5f;
        self.inputCount = 6;
        self.frame = CGRectMake(0, 0, 30, 35);
    }
    return self;
}

@end
