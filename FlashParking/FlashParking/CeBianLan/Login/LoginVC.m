//
//  LoginVC.m
//  FlashParking
//
//  Created by 薄号 on 16/6/16.
//  Copyright © 2016年 LettingTechnology. All rights reserved.
//

#import "LoginVC.h"
#import "RegisterVC.h"
#import "LTHTTPManager.h"
#import "SendBackViewController.h"

@interface LoginVC () {
    UITextField *_phoneNumber;
    UITextField *_password;
}

@end

@implementation LoginVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setAttributeLeftItem:@"back.png" withMiddleItem:@"登入" withRightItem:@"注册"];
    
    [self pageLayout];
    
}

#pragma mark -- 导航按钮点击事件
- (void)leftButtonEvent:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
    
    
}
//注册
- (void)rightButtonEvent:(UIButton *)sender {
    RegisterVC *regist = [[RegisterVC alloc] init];
    regist.view.backgroundColor=[UIColor colorWithRed:0.93 green:0.96 blue:0.96 alpha:1.0];
    
    [self.navigationController pushViewController:regist animated:YES];
}

#pragma mark -- 页面布局
- (void)pageLayout {
    //logo背景图也
    UIImageView *logoImageView = [[UIImageView alloc] init];
    logoImageView.frame = CGRectMake(0, 64, ScreenW, 120);
    logoImageView.backgroundColor = [self colorWithHexColorString:@"#3293fa"];
    logoImageView.image = [UIImage imageNamed:@"logo"];
    logoImageView.contentMode = UIViewContentModeCenter;
    [self.view addSubview:logoImageView];
    
    //手机号
    [self mobilePhoneNumber];
    //密码
    [self passwordNumber];
    //密码找回
    [self passwordFound];
    //登入按钮
    [self loginButton];
}

#pragma mark -- 手机号
- (void)mobilePhoneNumber {
    UIImageView *mobileBackgroundView = [[UIImageView alloc] init];
    mobileBackgroundView.frame = CGRectMake(20, 30 * HEIGHTSCALE + 184, 40, 40);
    //mobileBackgroundView.backgroundColor=[self colorWithHexColorString:@"#3293fa"];
    
    mobileBackgroundView.image = [UIImage imageNamed:@"drbg"];
    [self.view addSubview:mobileBackgroundView];
    UIImageView *iconImage = [[UIImageView alloc] init];
    iconImage.center = mobileBackgroundView.center;
    iconImage.bounds = CGRectMake(0, 0, 20, 20);
    iconImage.image = [UIImage imageNamed:@"mobile"];
    [self.view addSubview:iconImage];
    UITextField *mobileNumberText = [[UITextField alloc] init];
    mobileNumberText.frame = CGRectMake(60, 30 * HEIGHTSCALE + 184, ScreenW - 80, 40);
    mobileNumberText.backgroundColor = [UIColor whiteColor];
    mobileNumberText.font = [UIFont systemFontOfSize:14];
    mobileNumberText.keyboardType = UIKeyboardTypeNumberPad;
    mobileNumberText.clearButtonMode = UITextFieldViewModeWhileEditing;
    [self.view addSubview:mobileNumberText];
    _phoneNumber = mobileNumberText;
}
#pragma mark -- 密码
- (void)passwordNumber {
    UIImageView *passwordBackgroundView = [[UIImageView alloc] init];
    passwordBackgroundView.frame = CGRectMake(20, 30 * HEIGHTSCALE + 234, 40, 40);
    //passwordBackgroundView.backgroundColor=[self colorWithHexColorString:@"#3293fa"];
    
    passwordBackgroundView.image = [UIImage imageNamed:@"drbg"];
    [self.view addSubview:passwordBackgroundView];
    UIImageView *iconImage = [[UIImageView alloc] init];
    iconImage.center = passwordBackgroundView.center;
    iconImage.bounds = CGRectMake(0, 0, 20, 20);
    iconImage.image = [UIImage imageNamed:@"mima"];
    [self.view addSubview:iconImage];
    UITextField *passwordText = [[UITextField alloc] init];
    passwordText.frame = CGRectMake(60, 30 * HEIGHTSCALE + 234, ScreenW - 80, 40);
    passwordText.backgroundColor = [UIColor whiteColor];
    passwordText.font = [UIFont systemFontOfSize:14];
    passwordText.clearsOnBeginEditing = YES;
    passwordText.secureTextEntry = YES;
    [self.view addSubview:passwordText];
    _password = passwordText;
    UIButton *eyeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    eyeBtn.frame = CGRectMake(ScreenW - 70, 30 * HEIGHTSCALE + 247, 24,14);
    
    [eyeBtn setBackgroundImage:[UIImage imageNamed:@"yanjing"] forState:UIControlStateNormal];
    [eyeBtn addTarget:self action:@selector(showAndHiddePassword) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:eyeBtn];
}
#pragma mark -- 找回密码
- (void)passwordFound {
    UIButton *passwordFondBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    passwordFondBtn.frame = CGRectMake(ScreenW - 160, 30 * HEIGHTSCALE + 284, 140, 20);
    [passwordFondBtn setTitle:@"忘记密码？点此找回" forState:UIControlStateNormal];
    [passwordFondBtn setTitleColor:[UIColor colorWithRed:0.73 green:0.75 blue:0.75 alpha:1.00] forState:UIControlStateNormal];
    [passwordFondBtn addTarget:self action:@selector(passwordFindBtnEvent:) forControlEvents:UIControlEventTouchUpInside];
    passwordFondBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [self.view addSubview:passwordFondBtn];
}
#pragma mark -- 登入
- (void)loginButton {
    UIButton *loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    loginBtn.frame = CGRectMake(20, 30 * HEIGHTSCALE + 334, ScreenW - 40, 40);
    
    [loginBtn setBackgroundColor:[self colorWithHexColorString:@"#3293fa"]];
    [loginBtn setTitle:@"登入" forState:UIControlStateNormal];
    
    [loginBtn addTarget:self action:@selector(loginButtonEvent:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loginBtn];
}

#pragma mark -- 显示/隐藏密码按钮点击事件
- (void)showAndHiddePassword {
    _password.secureTextEntry = !_password.secureTextEntry;
}

#pragma mark -- 登入按钮点击事件
- (void)loginButtonEvent:(UIButton *)sender {
    
    if (_phoneNumber.text.length && _password.text.length) {
        [LTHTTPManager postRequestWithURL:[NSString stringWithFormat:@"%@%@",kHttpDemo,kHttpLogin] withParameter:@{@"mobile":_phoneNumber.text,@"password":_password.text,@"client":@"ios"} getData:^(NSMutableDictionary *dictionary, NSError *error) {
            NSLog(@"%@",dictionary);
            if ([[dictionary valueForKeyPath:@"code"] isEqualToString:@"0"]) {
                UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"恭喜登入成功" preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *sure = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    [self.navigationController popViewControllerAnimated:YES];
                    [self dismissViewControllerAnimated:YES completion:nil];
                    
                }];
                [alertController addAction:sure];
                [self presentViewController:alertController animated:YES completion:nil];
                //将uid、手机号、昵称存入plist文件，作为是否登入的判断条件
                [[NSUserDefaults standardUserDefaults] setObject:[dictionary valueForKeyPath:@"data.uid"] forKey:@"userUid"];
                [[NSUserDefaults standardUserDefaults] setObject:_phoneNumber.text forKey:@"phoneNumber"];
                [[NSUserDefaults standardUserDefaults] setObject:_password.text forKey:@"passwrod"];
                [[NSUserDefaults standardUserDefaults] setObject:[dictionary valueForKeyPath:@"data.nick"] forKey:@"nickName"];
                [[NSUserDefaults standardUserDefaults] synchronize];
            }
        }];
    }else {
        LTWXTS(@"输入不能为空");
    }
    
}

#pragma mark -- 密码找回按钮点击事件
- (void)passwordFindBtnEvent:(UIButton *)sender {
    //密码找回
    NSLog(@"密码找回");
    
    SendBackViewController *sendBack=[[SendBackViewController alloc]init];
    sendBack.view.backgroundColor=[UIColor colorWithRed:0.93 green:0.96 blue:0.96 alpha:1.0];
    [self.navigationController pushViewController:sendBack animated:YES];
    
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
