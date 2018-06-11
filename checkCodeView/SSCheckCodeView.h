//
//  SSCheckCodeView.h
//  SoSoRun
//
//  Created by wangweiyi on 2018/6/6.
//  Copyright © 2018年  All rights reserved.
//

/*
 self.checkView = [[SSCheckCodeView alloc] init];
 self.checkView.delegate = self;
 self.checkView.keyboardType = UIKeyboardTypeNumberPad;
 [self.view addSubview:self.checkView];
 [self.checkView mas_makeConstraints:^(MASConstraintMaker *make) {
    make.left.equalTo(self.view);
    make.right.equalTo(self.view);
    make.top.mas_equalTo(300);
    make.height.mas_equalTo(100);
 }];
 */

#import <UIKit/UIKit.h>
#import "Masonry.h"

#define SNWeakSelf(type)  __weak typeof(type) weak##type = type;


@class SSCheckCodeView;
@protocol SSCheckCodeViewDelegate<NSObject>

/**
 输入结束触发代理

 @param view self
 @param contentText 结束以后的4位字符串
 */
- (void)checkCodeView:(SSCheckCodeView *)view textFinished:(NSString *)contentText;

@optional
- (void)checkCodeView:(SSCheckCodeView *)view textChanged:(NSString *)contentText;


@end

@interface SSCheckCodeView : UIView<UIKeyInput>

@property(nonatomic,weak)id<SSCheckCodeViewDelegate> delegate;

- (instancetype)initWithSingleLabelFrame:(CGRect)frame
                                   space:(CGFloat)space
                               numOfCode:(NSUInteger)number
                           selectedColor:(UIColor *)selectedColor
                         unSelectedColor:(UIColor *)unSelectedColor;
- (void)clear;

@end




@interface singleLabel: UILabel

- (instancetype)initWithselectedColor:(UIColor *)selectedColor
                      unSelectedColor:(UIColor *)unSelectedColor;
- (void)resignResponder;
- (void)registResponder;

@end
