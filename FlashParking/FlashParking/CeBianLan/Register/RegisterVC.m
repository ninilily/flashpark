//
//  RegisterVC.m
//  FlashParking
//
//  Created by 薄号 on 16/6/16.
//  Copyright © 2016年 LettingTechnology. All rights reserved.
//

#import "RegisterVC.h"

@interface RegisterVC () {
    UITextField *_phoneNumber;
    UITextField *_password;
    UITextField *_nickName;
    UITextField *_captcha;
    
    UIButton *_captchaBtn;
    
    NSTimer *_countdownTimer;
    UILabel *_countdownLabel;
}

@end

static CGFloat kInputFontSize = 17;
static NSInteger countdownNumber = 60;

@implementation RegisterVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setAttributeLeftItem:@"back.png" withMiddleItem:@"注册" withRightItem:nil];
    
    [self pageLayout];
    
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
}

#pragma mark -- 导航按钮点击事件
- (void)leftButtonEvent:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)rightButtonEvent:(UIButton *)sender {
    
}

#pragma mark -- 页面布局
- (void)pageLayout {
    //手机号
    UIImageView *phoneBackgroundView = [[UIImageView alloc] init];
    phoneBackgroundView.frame = CGRectMake(20, 100 * HEIGHTSCALE, 40, 40);
    phoneBackgroundView.image = [UIImage imageNamed:@"drbg"];
    [self.view addSubview:phoneBackgroundView];
    UIImageView *phoneImage = [[UIImageView alloc] init];
    phoneImage.center = phoneBackgroundView.center;
    phoneImage.bounds = CGRectMake(0, 0, 20, 20);
    phoneImage.image = [UIImage imageNamed:@"mobile"];
    [self.view addSubview:phoneImage];
    UITextField *phoneNumberText = [[UITextField alloc] init];
    phoneNumberText.frame = CGRectMake(60, 100 * HEIGHTSCALE, ScreenW - 80, 40);
    phoneNumberText.backgroundColor = [UIColor whiteColor];
    phoneNumberText.font = [UIFont systemFontOfSize:kInputFontSize];
    phoneNumberText.textAlignment = NSTextAlignmentCenter;
    phoneNumberText.keyboardType = UIKeyboardTypeNumberPad;
    phoneNumberText.placeholder = @"请输入手机号码";
    phoneNumberText.font=[UIFont systemFontOfSize:14];
    
    phoneNumberText.clearButtonMode = UITextFieldViewModeWhileEditing;
    [self.view addSubview:phoneNumberText];
    _phoneNumber = phoneNumberText;
    //密码
    UIImageView *passwordBackgroundView = [[UIImageView alloc] init];
    passwordBackgroundView.frame = CGRectMake(20, 100 * HEIGHTSCALE + 50, 40, 40);
    passwordBackgroundView.image = [UIImage imageNamed:@"drbg"];
    [self.view addSubview:passwordBackgroundView];
    UIImageView *passwordImage = [[UIImageView alloc] init];
    passwordImage.center = passwordBackgroundView.center;
    passwordImage.bounds = CGRectMake(0, 0, 20, 20);
    passwordImage.image = [UIImage imageNamed:@"mima"];
    [self.view addSubview:passwordImage];
    UITextField *passwordText = [[UITextField alloc] init];
    passwordText.frame = CGRectMake(60, 100 * HEIGHTSCALE + 50, ScreenW - 80, 40);
    passwordText.backgroundColor = [UIColor whiteColor];
    passwordText.font = [UIFont systemFontOfSize:kInputFontSize];
    passwordText.textAlignment = NSTextAlignmentCenter;
    passwordText.placeholder = @"请设置登入密码";
    passwordText.font=[UIFont systemFontOfSize:14];
    
    passwordText.secureTextEntry = YES;
    passwordText.clearButtonMode = UITextFieldViewModeWhileEditing;
    [self.view addSubview:passwordText];
    _password = passwordText;
    //昵称
    UIImageView *nickBackgroundView = [[UIImageView alloc] init];
    nickBackgroundView.frame = CGRectMake(20, 100 * HEIGHTSCALE + 100, 40, 40);
    nickBackgroundView.image = [UIImage imageNamed:@"drbg"];
    [self.view addSubview:nickBackgroundView];
    UIImageView *nickImage = [[UIImageView alloc] init];
    nickImage.center = nickBackgroundView.center;
    nickImage.bounds = CGRectMake(0, 0, 20, 20);
    nickImage.image = [UIImage imageNamed:@"mobile"];
    [self.view addSubview:nickImage];
    UITextField *nickNameText = [[UITextField alloc] init];
    nickNameText.frame = CGRectMake(60, 100 * HEIGHTSCALE + 100, ScreenW - 80, 40);
    nickNameText.backgroundColor = [UIColor whiteColor];
    nickNameText.font = [UIFont systemFontOfSize:kInputFontSize];
    nickNameText.textAlignment = NSTextAlignmentCenter;
    nickNameText.placeholder = @"请设置个人昵称";
    nickNameText.font=[UIFont systemFontOfSize:14];
    nickNameText.clearButtonMode = UITextFieldViewModeWhileEditing;
    [self.view addSubview:nickNameText];
    _nickName = nickNameText;
    //验证码
    UITextField *captchaText = [[UITextField alloc] init];
    captchaText.frame = CGRectMake(20, 100 * HEIGHTSCALE + 155, ScreenW / 2 - 40, 30);
    captchaText.backgroundColor = [UIColor whiteColor];
    captchaText.textAlignment = NSTextAlignmentCenter;
    captchaText.placeholder = @"请输入验证码";
    captchaText.font=[UIFont systemFontOfSize:14];
    
    captchaText.keyboardType = UIKeyboardTypeNumberPad;
    captchaText.clearButtonMode = UITextFieldViewModeWhileEditing;
    [self.view addSubview:captchaText];
    _captcha = captchaText;
    UIButton *getCode = [UIButton buttonWithType:UIButtonTypeCustom];
    getCode.frame = CGRectMake(ScreenW - 140, 100 * HEIGHTSCALE + 155, 120, 30);
    [getCode setBackgroundImage:[UIImage imageNamed:@"yanbg"] forState:UIControlStateNormal];
    
    [getCode setTitle:@"获取验证码" forState:UIControlStateNormal];
    getCode.titleLabel.font=[UIFont systemFontOfSize:14];
    

//    [getCode setBackgroundImage:[UIImage imageNamed:@"YanCode_y"] forState:UIControlStateNormal];
//    [getCode setBackgroundImage:[UIImage imageNamed:@"YanCode_w"] forState:UIControlStateHighlighted];
    [getCode addTarget:self action:@selector(getYanZhengMa:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:getCode];
    _captchaBtn = getCode;
    
    //注册按钮
    UIButton *registBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    registBtn.frame = CGRectMake(20, 100 * HEIGHTSCALE + 215, ScreenW - 40, 40);
    [registBtn setTitle:@"注册" forState:UIControlStateNormal];
    [registBtn setBackgroundColor:[self colorWithHexColorString:@"#3293fa"]];
    
    
//    [registBtn setImage:[UIImage imageNamed:@"register-w"] forState:UIControlStateNormal];
//    [registBtn setImage:[UIImage imageNamed:@"register-y"] forState:UIControlStateHighlighted];
    registBtn.contentMode = UIViewContentModeScaleAspectFit;
    [registBtn addTarget:self action:@selector(registAccount:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:registBtn];
}

#pragma mark -- 获取验证码
- (void)getYanZhengMa:(UIButton *)sender {
    if (_phoneNumber.text.length && _password.text.length && _nickName.text.length) {
        [LTHTTPManager postRequestWithURL:[NSString stringWithFormat:@"%@%@",kHttpDemo,kHttpactivateCode] withParameter:@{@"mobile":_phoneNumber.text} getData:^(NSMutableDictionary *dictionary, NSError *error) {
            if ([[dictionary valueForKeyPath:@"code"] isEqualToString:@"0"]) {
                LTWXTS(@"验证码已发送成功");
                _countdownLabel = [[UILabel alloc] init];
                _countdownLabel.frame = _captchaBtn.frame;
                _countdownLabel.text = @"59秒后重新获取";
                _countdownLabel.textAlignment = NSTextAlignmentCenter;
                _countdownLabel.backgroundColor = [self colorWithHexColorString:@"#3293fa"];
                _countdownLabel.textColor = [UIColor colorWithRed:0.89 green:0.95 blue:0.96 alpha:1.00];
                _countdownLabel.font = [UIFont systemFontOfSize:12];
                _countdownLabel.layer.cornerRadius = 5;
                _countdownLabel.layer.masksToBounds = YES;
                [self.view addSubview:_countdownLabel];
                //启动倒计时
                _countdownTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(countdownTimerMethod) userInfo:nil repeats:YES];
            }else {
                LTWXTS([dictionary valueForKeyPath:@"message"]);
            }
        }];
    }else {
        LTWXTS(@"信息请填写完整");
    }
}
#pragma mark -- 倒计时方法 
- (void)countdownTimerMethod {
    countdownNumber--;
    if (0 == countdownNumber) {
        [_countdownTimer invalidate];
        _countdownTimer = nil;
        [_countdownLabel removeFromSuperview];
        return;
    }
    _countdownLabel.text = [NSString stringWithFormat:@"%ld秒后重新获取",countdownNumber];
}

#pragma mark -- 注册
- (void)registAccount:(UIButton *)sender {
    
    if (_phoneNumber.text.length && _password.text.length && _nickName.text.length && _captcha.text.length) {
        [LTHTTPManager postRequestWithURL:[NSString stringWithFormat:@"%@%@",kHttpDemo,kHttpRegister] withParameter:@{@"password":_password.text,@"mobile":_phoneNumber.text,@"code":_captcha.text,@"nick":_nickName.text,@"client":@"ios"} getData:^(NSMutableDictionary *dictionary, NSError *error) {
            if ([[dictionary valueForKeyPath:@"code"] isEqualToString:@"0"]) {
                LTWXTS(@"恭喜注册成功");
            }else {
                LTWXTS([dictionary valueForKeyPath:@"message"]);
            }
        }];
    }else {
        LTWXTS(@"信息请填写完整");
    }
    
}

#pragma mark -- 结束编辑
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
