//
//  SendBackViewController.m
//  FlashParking
//
//  Created by 张弛 on 16/7/18.
//  Copyright © 2016年 LettingTechnology. All rights reserved.
//

#import "SendBackViewController.h"
#import "RePasswordViewController.h"
#import "LTHTTPManager.h"
@interface SendBackViewController ()
{
    UITextField *_phoneNumber;
    UITextField *_captcha;
    
    NSTimer *_countdownTimer;
    UILabel *_countdownLabel;
    UIButton *_getCode;
    
    
}
@end

static NSInteger countdownNumber = 60;

@implementation SendBackViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setAttributeLeftItem:@"back.png" withMiddleItem:@"找回密码" withRightItem:@"登入"];
    //手机号
    [self mobilePhoneNumber];
    //获取手机验证码
    [self captcha];
    
    
    
}
#pragma mark -- 导航按钮点击事件
- (void)leftButtonEvent:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark --手机号
- (void)mobilePhoneNumber
{
    UIImageView *mobileBackgroundView = [[UIImageView alloc] init];
    mobileBackgroundView.frame = CGRectMake(20, 30 * HEIGHTSCALE + 70, 40, 40);
    
    mobileBackgroundView.image = [UIImage imageNamed:@"drbg"];
    [self.view addSubview:mobileBackgroundView];
    
    UIImageView *iconImage = [[UIImageView alloc] init];
    iconImage.center = mobileBackgroundView.center;
    iconImage.bounds = CGRectMake(0, 0, 20, 20);
    iconImage.image = [UIImage imageNamed:@"mobile"];
    [self.view addSubview:iconImage];
    UITextField *mobileNumberText = [[UITextField alloc] init];
    mobileNumberText.frame = CGRectMake(60, 30 * HEIGHTSCALE + 70, ScreenW - 80, 40);
    mobileNumberText.backgroundColor = [UIColor whiteColor];
    mobileNumberText.font = [UIFont systemFontOfSize:14];
    mobileNumberText.keyboardType = UIKeyboardTypeNumberPad;
    mobileNumberText.clearButtonMode = UITextFieldViewModeWhileEditing;
    [self.view addSubview:mobileNumberText];
    _phoneNumber = mobileNumberText;

    
}

#pragma mark --获取验证码
- (void)captcha
{
    //验证码
    UITextField *captchaText = [[UITextField alloc] init];
    captchaText.frame = CGRectMake(20, 100 * HEIGHTSCALE +70, ScreenW / 2 -20, 40);
    captchaText.backgroundColor = [UIColor whiteColor];
    captchaText.textAlignment = NSTextAlignmentCenter;
    //captchaText.placeholder = @"请输入验证码";
    captchaText.font=[UIFont systemFontOfSize:14];
    
    captchaText.keyboardType = UIKeyboardTypeNumberPad;
    captchaText.clearButtonMode = UITextFieldViewModeWhileEditing;
    [self.view addSubview:captchaText];
    _captcha = captchaText;
    UIButton *getCode = [UIButton buttonWithType:UIButtonTypeCustom];
    getCode.frame = CGRectMake(ScreenW - 140, 100 * HEIGHTSCALE +70, 120, 40);
    [getCode setBackgroundImage:[UIImage imageNamed:@"yanbg"] forState:UIControlStateNormal];
    
    [getCode setTitle:@"获取验证码" forState:UIControlStateNormal];
    getCode.titleLabel.font=[UIFont systemFontOfSize:14];
    [self.view addSubview:getCode];
    
    [getCode addTarget:self action:@selector(getYanZhengMa:) forControlEvents:UIControlEventTouchUpInside];
    _getCode=getCode;
    
    UIButton *Next = [UIButton buttonWithType:UIButtonTypeCustom];
    Next.frame = CGRectMake(10, 100 * HEIGHTSCALE +400, ScreenW-20, 40);
    [Next setTitle:@"下一步" forState:UIControlStateNormal];
    [Next setBackgroundColor:[self colorWithHexColorString:@"#3293fa"]];
    [Next addTarget:self action:@selector(nextRePassword:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:Next];
    
    
}
#pragma mark --获取验证码
- (void)getYanZhengMa:(UIButton *)sender
{
    NSLog(@"获取验证码");
    if(_phoneNumber.text.length)
    {
        [LTHTTPManager postRequestWithURL:[NSString stringWithFormat:@"%@%@",kHttpDemo,kHttpactivateCode] withParameter:@{@"mobile":_phoneNumber.text} getData:^(NSMutableDictionary *dictionary, NSError *error) {
           
            LTWXTS(@"验证码已发送成功");
            _countdownLabel = [[UILabel alloc] init];
            _countdownLabel.frame = _getCode.frame;
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

        }];
        
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


#pragma mark --跳转重置密码
- (void)nextRePassword:(UIButton *)sender
{
    NSLog(@"重置密码");
    if(_phoneNumber.text.length&&_captcha.text.length){
        
     RePasswordViewController *repassword=[[RePasswordViewController alloc]init];
    repassword.view.backgroundColor=[UIColor colorWithRed:0.93 green:0.96 blue:0.96 alpha:1.0];
    repassword.mobile=_phoneNumber.text;
    repassword.code=_captcha.text;
    
    [self.navigationController pushViewController:repassword animated:YES];
    
    }
    else
    {
        LTWXTS(@"请输入完整信息");
    }
    
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
