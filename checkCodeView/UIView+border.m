//
//  UIView+border.m
//  checkCodeView
//
//  Created by wangweiyi on 2018/6/11.
//  Copyright © 2018年 demo. All rights reserved.
//

#import "UIView+border.h"

@implementation UIView (border)

- (void)BorderColor:(UIColor *)color width:(CGFloat)width{
    self.layer.borderColor = color.CGColor;
    self.layer.borderWidth = width;

}

@end
