//
//  ViewController.m
//  checkCodeView
//
//  Created by wangweiyi on 2018/6/11.
//  Copyright © 2018年 demo. All rights reserved.
//

#import "ViewController.h"
#import "SSCheckCodeView.h"

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 \
alpha:1.0]

@interface ViewController ()<SSCheckCodeViewDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //UIColorFromRGB(0xcccccc)
    //UIColorFromRGB(0xff8903)
    UITapGestureRecognizer *tap = [UITapGestureRecognizer new];
    [tap addTarget:self action:@selector(hide)];
    [self.view addGestureRecognizer:tap];

    SSChekCodeConfig *config = [SSChekCodeConfig new];
    SSCheckCodeView * codeView = [[SSCheckCodeView alloc] initWithConfig:config];
    codeView.delegate = self;
    codeView.keyboardType = UIKeyboardTypeNumberPad;
    codeView.center = self.view.center;
    [self.view addSubview:codeView];
}

- (void)hide
{
    [self.view endEditing:YES];
}

- (void)checkCodeView:(SSCheckCodeView *)view textFinished:(NSString *)contentText {

    NSLog(@"%@",contentText);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
