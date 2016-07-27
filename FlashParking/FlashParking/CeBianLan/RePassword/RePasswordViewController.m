//
//  RePasswordViewController.m
//  FlashParking
//
//  Created by 张弛 on 16/7/18.
//  Copyright © 2016年 LettingTechnology. All rights reserved.
//

#import "RePasswordViewController.h"

@interface RePasswordViewController ()
{
    UITextField *_password;
    
    UITextField *_rePassword;
    
}
@end

@implementation RePasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
     [self setAttributeLeftItem:@"back.png" withMiddleItem:@"密码重置" withRightItem:@"登入"];
    
    //密码输入1
    [self password];
    
    //密码输入2
    [self repassword];
    
}
#pragma mark -- 导航按钮点击事件
- (void)leftButtonEvent:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark --页面布局
- (void)password
{
    UIImageView *mobileBackgroundView = [[UIImageView alloc] init];
    mobileBackgroundView.frame = CGRectMake(20, 30 * HEIGHTSCALE + 70, 40, 40);
    
    mobileBackgroundView.image = [UIImage imageNamed:@"drbg"];
    [self.view addSubview:mobileBackgroundView];
    
    UIImageView *iconImage = [[UIImageView alloc] init];
    iconImage.center = mobileBackgroundView.center;
    iconImage.bounds = CGRectMake(0, 0, 20, 20);
    iconImage.image = [UIImage imageNamed:@"mima"];
    [self.view addSubview:iconImage];
    UITextField *passwordText = [[UITextField alloc] init];
    passwordText.frame = CGRectMake(60, 30 * HEIGHTSCALE + 70, ScreenW - 80, 40);
    passwordText.backgroundColor = [UIColor whiteColor];
    passwordText.font = [UIFont systemFontOfSize:14];
    passwordText.keyboardType = UIKeyboardTypeNumberPad;
    passwordText.clearButtonMode = UITextFieldViewModeWhileEditing;
    [self.view addSubview:passwordText];
    _password = passwordText;
}
#pragma mark --重新输入密码
- (void)repassword
{
    UIImageView *mobileBackgroundView = [[UIImageView alloc] init];
    mobileBackgroundView.frame = CGRectMake(20, 30 * HEIGHTSCALE + 120, 40, 40);
    
    mobileBackgroundView.image = [UIImage imageNamed:@"drbg"];
    [self.view addSubview:mobileBackgroundView];
    
    UIImageView *iconImage = [[UIImageView alloc] init];
    iconImage.center = mobileBackgroundView.center;
    iconImage.bounds = CGRectMake(0, 0, 20, 20);
    iconImage.image = [UIImage imageNamed:@"mima"];
    [self.view addSubview:iconImage];
    
    UITextField *passwordText = [[UITextField alloc] init];
    passwordText.frame = CGRectMake(60, 30 * HEIGHTSCALE + 120, ScreenW - 80, 40);
    passwordText.backgroundColor = [UIColor whiteColor];
    passwordText.font = [UIFont systemFontOfSize:14];
    passwordText.keyboardType = UIKeyboardTypeNumberPad;
    passwordText.clearButtonMode = UITextFieldViewModeWhileEditing;
    [self.view addSubview:passwordText];
    _rePassword=passwordText;
  
    
    UIButton *Next = [UIButton buttonWithType:UIButtonTypeCustom];
    Next.frame = CGRectMake(10, 100 * HEIGHTSCALE +400, ScreenW-20, 40);
    [Next setTitle:@"完成" forState:UIControlStateNormal];
    [Next setBackgroundColor:[self colorWithHexColorString:@"#3293fa"]];
    [Next addTarget:self action:@selector(RePassword:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:Next];
}

#pragma mark ---密码重置
- (void)RePassword:(UIButton *)sender
{
    if (_password.text==_rePassword.text&&_password.text.length&&_rePassword.text.length) {
        [LTHTTPManager postRequestWithURL:[NSString stringWithFormat:@"%@%@",kHttpDemo,kHttpPwdrst] withParameter:@{@"password":_rePassword.text,@"mobile":self.mobile,@"code":self.code} getData:^(NSMutableDictionary *dictionary, NSError *error) {
            NSLog(@"%@",dictionary);
            
            if ([[dictionary valueForKey:@"code"] isEqualToString:@"0"]) {
                 LTWXTS(@"重置成功");
            }
            else
            {
                LTWXTS([dictionary valueForKeyPath:@"message"]);
            }
            
        }];
        
        
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
