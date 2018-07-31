//
//  SSCheckCodeView.m
//  SoSoRun
//
//  Created by wangweiyi on 2018/6/6.
//  Copyright © 2018年. All rights reserved.
//

#import "SSCheckCodeView.h"
#import "UIView+border.h"




@interface SSCheckCodeView()

@property(nonatomic,copy)NSMutableString *content;
@property(nonatomic,strong)NSMutableArray<singleLabel *> *inputViewStoreArr;
@property(nonatomic,strong)NSMutableArray<NSString *> *inputStringStoreArr;

@property(nonatomic,strong)SSChekCodeConfig *config;

//@property(nonatomic,strong)UIColor *selectedColor;
//@property(nonatomic,strong)UIColor *unSelectedColor;
//@property(nonatomic,assign)CGRect singleFrame;
//@property(nonatomic,assign)CGFloat space;

@end

@implementation SSCheckCodeView
{
    UIKeyboardType _keyboardType;
    NSUInteger _fillIndex;
    NSUInteger _selectedIndex;
}

- (instancetype)initWithConfig:(SSChekCodeConfig *)config
{
    if (self = [super initWithFrame:CGRectMake(0, 0,
                                               (config.frame.size.width + config.space) * config.inputCount - config.space,
                                               config.frame.size.height)]) {
        self.config = config;
        [self commonInit:config.inputCount];
    }
    return self;
}

- (void)commonInit:(NSUInteger)viewCount
{
    _fillIndex = 0;
    _selectedIndex = 0;
    self.inputViewStoreArr = [NSMutableArray arrayWithCapacity:0];
    self.inputStringStoreArr = [NSMutableArray arrayWithCapacity:0];
    [self setupUI:viewCount];
    [self addGesture];
}

- (void)addGesture
{
    UITapGestureRecognizer *tap = [UITapGestureRecognizer new];
    [tap addTarget:self action:@selector(becomeFirstResponder)];
    [self addGestureRecognizer:tap];
}

- (void)refreshUIStatusIsInput: (BOOL)isInput
{
    NSInteger dataArrCount = self.inputStringStoreArr.count;
    NSInteger viewArrCount = self.inputViewStoreArr.count;
    if (isInput) {//输入
        if (_fillIndex == 0 && _selectedIndex == 0 && dataArrCount == 0) {//空格呼出键盘
            [self rerefreshUI];
            return;
        }

        if (_fillIndex == viewArrCount-1 && _selectedIndex == viewArrCount-1 && dataArrCount == viewArrCount) {//满格呼出键盘
            [self rerefreshUI];
            return;
        }
        //填充数据
        singleLabel *fillDataLabel = self.inputViewStoreArr[_selectedIndex];
        fillDataLabel.text = self.inputStringStoreArr[_selectedIndex];
        _fillIndex = _selectedIndex;
        _selectedIndex = dataArrCount == viewArrCount ? viewArrCount - 1 : dataArrCount;
        if (dataArrCount == viewArrCount) {
            [fillDataLabel resignResponder];
            [self resignFirstResponder];
            if ([self.delegate respondsToSelector:@selector(checkCodeView:textFinished:)]) {
                [self.delegate checkCodeView:self
                                textFinished:[self.inputStringStoreArr componentsJoinedByString:@""]];
            }
            return;
        }
        [self rerefreshUI];

    }else {//删除
        singleLabel *fillDataLabel = self.inputViewStoreArr[dataArrCount];
        fillDataLabel.text = @"";
        _selectedIndex = dataArrCount;
        _fillIndex = (dataArrCount - 1) < 0 ? 0 : dataArrCount - 1;
        [self rerefreshUI];
    }

    if ([self.delegate respondsToSelector:@selector(checkCodeView:textChanged:)]) {
        [self.delegate checkCodeView:self
                         textChanged:[self.inputStringStoreArr componentsJoinedByString:@""]];
    }

}

- (void)rerefreshUI
{
    for (singleLabel * label in self.inputViewStoreArr) {
        [label resignResponder];
    }
    singleLabel *labelNow = self.inputViewStoreArr[_selectedIndex];
    [labelNow registResponder];
}


- (void)clear
{
    [self.inputStringStoreArr removeAllObjects];
    for (singleLabel * label in self.inputViewStoreArr) {
        label.text = @"";
    }
    _selectedIndex = 0;
    _fillIndex = 0;
    [self becomeFirstResponder];
}

#pragma mark - keyInputDelegate
- (BOOL)canBecomeFirstResponder
{
    return YES;
}

- (BOOL)hasText
{
    return YES;
}

- (BOOL)becomeFirstResponder
{
    [self rerefreshUI];
    return [super becomeFirstResponder];
}

- (BOOL)resignFirstResponder
{
    for (singleLabel * label in self.inputViewStoreArr) {
        [label resignResponder];
    }
    return [super resignFirstResponder];
}

- (UIKeyboardType)keyboardType
{
    return _keyboardType;
}

- (void)setKeyboardType:(UIKeyboardType)keyboardType
{
    _keyboardType = keyboardType;
}

- (void)deleteBackward
{
    if ([self.inputStringStoreArr count]) {
        [self.inputStringStoreArr removeLastObject];
        [self refreshUIStatusIsInput:NO];
    }
}

- (void)insertText:(nonnull NSString *)text
{
    if (self.inputStringStoreArr.count < self.inputViewStoreArr.count) {
        [self.inputStringStoreArr addObject:text];
        [self refreshUIStatusIsInput:YES];
    }
}

- (void)setupUI:(NSUInteger)count
{
    for (int i = 0 ; i < count ; i ++) {
        singleLabel *label = [[singleLabel alloc] initWithselectedColor:self.config.borderSelectedColor
                                                        unSelectedColor:self.config.borderColor
                                                           cornerRadius:self.config.cornerRadius
                                                               isSecret:self.config.isSecret
                                                           isShowCursor:self.config.isShowCursor];
        [self.inputViewStoreArr addObject:label];
        [self addSubview:label];
    }

    [self updateConstraints];
}

- (void)updateConstraints
{
    [super updateConstraints];

    for (int i = 0 ; i < self.inputViewStoreArr.count; i ++) {
        singleLabel *label = self.inputViewStoreArr[i];
        SNWeakSelf(self);
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(weakself.config.frame.size.width);
            make.height.mas_equalTo(weakself.config.frame.size.height);
            make.left.equalTo(weakself).offset(i * (weakself.config.frame.size.width + weakself.config.space));
            make.top.equalTo(weakself);
        }];
    }
}






@end

//UIColorFromRGB(0xcccccc)
//UIColorFromRGB(0xff8903)

@interface singleLabel()

@property(nonatomic,strong)UIView *cursorView;
@property(nonatomic,copy)dispatch_source_t timer;

@property(nonatomic,strong)UIColor *selectedColor;
@property(nonatomic,strong)UIColor *unSelectedColor;
@property(nonatomic,assign)CGFloat cornerRadius;
@property(nonatomic,assign)BOOL isSecret;
@property(nonatomic,assign)BOOL isShowCursor;

@end

@implementation singleLabel {
    BOOL isOnFire;
}

- (instancetype)initWithselectedColor:(UIColor *)selectedColor
                      unSelectedColor:(UIColor *)unSelectedColor
                         cornerRadius:(CGFloat)cornerRadius
                             isSecret:(BOOL)isSecret
                         isShowCursor:(BOOL)isShowCursor
{
    if (self = [super initWithFrame:CGRectZero]) {
        self.userInteractionEnabled = NO;
        self.font = [UIFont systemFontOfSize:18];
        self.textAlignment = NSTextAlignmentCenter;
        self.backgroundColor = [UIColor whiteColor];
        self.textColor = self.selectedColor;
        self.secureTextEntry = isSecret;
        self.selectedColor = selectedColor;
        self.unSelectedColor = unSelectedColor;
        self.cornerRadius = cornerRadius;
        self.isSecret = isSecret;
        self.isShowCursor = isShowCursor;
        [self setupUI];
        [self.cursorView setHidden:YES];
    }
    return self;
}


- (void)resignResponder
{
    if (isOnFire) {
        dispatch_suspend(_timer);
        isOnFire = NO;
    }
    [self.cursorView setHidden:YES];
    [self BorderColor:self.unSelectedColor width:0.5f];
}


- (void)registResponder
{
    [self BorderColor:self.selectedColor width:0.5f];
    if (self.text && [self.text length]) {
        [self.cursorView setHidden:YES];
    }else {
        [self startFlashing];
    }
}


- (void)startFlashing
{
    if(!self.isShowCursor) return;
    if (_timer == nil) {
        _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, dispatch_get_global_queue(0, 0));
        dispatch_source_set_timer(_timer, DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC, 0 * NSEC_PER_SEC);
        SNWeakSelf(self);
        dispatch_source_set_event_handler(_timer, ^{

            dispatch_async(dispatch_get_main_queue(), ^{
                [weakself.cursorView setHidden:!self.cursorView.isHidden];
            });
        });
    }
    if (!isOnFire) {
        dispatch_resume(_timer);
        isOnFire = YES;
    }
}



- (void)setupUI
{
    [self BorderColor:self.unSelectedColor width:0.5f];
    self.layer.cornerRadius = self.cornerRadius;
    self.layer.masksToBounds = YES;
    self.cursorView = [[UIView alloc] init];
    self.cursorView.backgroundColor = self.selectedColor;
    [self addSubview:self.cursorView];
    [self updateConstraints];
}

- (void)updateConstraints
{
    [super updateConstraints];
    [self.cursorView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.centerY.equalTo(self);
        make.width.mas_equalTo(1);
        make.height.mas_equalTo(20);
    }];

}

- (void)dealloc
{
    if (_timer) {
        dispatch_cancel(_timer);
        _timer = nil;
    }
}

@end
