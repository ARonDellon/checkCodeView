##独立输入验证码
####项目依赖Masonry。或者源码中修改布局方法

·用法

        SSCheckCodeView * codeView = [[SSCheckCodeView alloc] initWithSingleLabelFrame:CGRectMake(0, 0,30, 35)
                    space:5
                    numOfCode:8
                    selectedColor:UIColorFromRGB(0xff8903)
                                  unSelectedColor:UIColorFromRGB(0xcccccc)];
    codeView.delegate = self;
    codeView.keyboardType = UIKeyboardTypeNumberPad;
    codeView.center = self.view.center;
    [self.view addSubview:codeView];
    
![cmd-markdown-logo](https://github.com/ARonDellon/checkCodeView/blob/master/3.gif)
