//
//  SSChekCodeConfig.h
//  checkCodeView
//
//  Created by wangweiyi on 2018/7/31.
//  Copyright © 2018年 demo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface SSChekCodeConfig : NSObject


@property(nonatomic,strong)UIColor *borderColor;            //边框颜色
@property(nonatomic,strong)UIColor *borderSelectedColor;    //选中颜色
@property(nonatomic,assign)BOOL isSecret;                   //是否密文输入
@property(nonatomic,assign)BOOL isShowCursor;               //是否显示光标
@property(nonatomic,assign)CGFloat cornerRadius;            //单个输入圆角
@property(nonatomic,assign)CGFloat space;                   //输入框间隔
@property(nonatomic,assign)NSUInteger inputCount;           //输入框个数
@property(nonatomic,assign)CGRect frame;                    //输入框大小

@end
