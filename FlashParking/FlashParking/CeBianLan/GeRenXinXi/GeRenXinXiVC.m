//
//  GeRenXinXiVC.m
//  FlashParking
//
//  Created by 薄号 on 16/6/16.
//  Copyright © 2016年 LettingTechnology. All rights reserved.
//

#import "GeRenXinXiVC.h"


@interface GeRenXinXiVC ()<UITextFieldDelegate,STPickerDateDelegate,STPickerSingleDelegate>
{
    UIImageView *_headerBGView;
    UIView *_infoView;
    
    UITextField *_nick;
    UITextField *_sex;
    UITextField *_phone;
    UITextField *_birth;
    NSString *_birthday;
    
}

@end

@implementation GeRenXinXiVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setAttributeLeftItem:@"back.png" withMiddleItem:@"个人中心" withRightItem:@"确定"];
    
    [self pageLayout];
    //输入框代理
    _sex.delegate = self;
    _birth.delegate = self;
    
    //键盘弹出通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardShow:) name:UIKeyboardWillChangeFrameNotification object:nil];
    
    
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    _nick.text = [[NSUserDefaults standardUserDefaults] objectForKey:@"nickName"];
    _phone.text = [[NSUserDefaults standardUserDefaults] objectForKey:@"phoneNumber"];
    _birth.text = [[NSUserDefaults standardUserDefaults] objectForKey:@"birthday"];
    _sex.text = [[NSUserDefaults standardUserDefaults] objectForKey:@"userSex"];
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:YES];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillChangeFrameNotification object:nil];
}

#pragma mark -- 导航按钮点击事件
- (void)leftButtonEvent:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)rightButtonEvent:(UIButton *)sender {
    //提交修改个人信息
    [LTHTTPManager postRequestWithURL:[NSString stringWithFormat:@"%@%@",kHttpDemo,kHttpInfoUpdate] withParameter:@{@"uid":[[NSUserDefaults standardUserDefaults] objectForKey:@"userUid"],@"birthday":_birth.text,@"gender":_sex.text,@"intro":_nick.text} getData:^(NSMutableDictionary *dictionary, NSError *error) {
        if ([[dictionary valueForKeyPath:@"code"] isEqualToString:@"0"]) {
//            [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"phoneNumber"];
            [[NSUserDefaults standardUserDefaults] setObject:_nick.text forKey:@"nickName"];
            [[NSUserDefaults standardUserDefaults] setObject:_sex.text forKey:@"userSex"];
            [[NSUserDefaults standardUserDefaults] setObject:_birth.text forKey:@"birthday"];
            LTWXBACK(@"恭喜修改成功");
        }else {
            LTWXTS([dictionary valueForKeyPath:@"message"]);
        }
    }];
}

#pragma mark -- 页面布局
- (void)pageLayout {
    
    //头像背景图片
    UIImageView *backgroundImageView = [[UIImageView alloc] init];
    backgroundImageView.frame = CGRectMake(0, 64, ScreenW, 140 * HEIGHTSCALE);
    backgroundImageView.image = [UIImage imageNamed:@"cheweizhubj"];
    [self.view addSubview:backgroundImageView];
    _headerBGView = backgroundImageView;
    //头像
    UIButton *headerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    headerBtn.center = backgroundImageView.center;
    headerBtn.bounds = CGRectMake(0, 0, 100, 100);
    [headerBtn setBackgroundImage:[UIImage imageNamed:@"touxiang"] forState:UIControlStateNormal];
    [self.view addSubview:headerBtn];
    //信息背景View
    UIView *infoBackgroundView = [[UIView alloc] init];
    infoBackgroundView.frame = CGRectMake(0, backgroundImageView.frame.origin.y + backgroundImageView.bounds.size.height + 20, ScreenW, 203);
    infoBackgroundView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:infoBackgroundView];
    _infoView = infoBackgroundView;
    //分隔线、箭头
    for (NSInteger i = 0; i < 4; i++) {
        if (i < 3) {
            UILabel *line = [[UILabel alloc] init];
            line.frame = CGRectMake(20, 51 * i + 51, ScreenW - 20, 1);
            line.backgroundColor = [UIColor colorWithRed:0.88 green:0.89 blue:0.89 alpha:1.00];
            [infoBackgroundView addSubview:line];
            UIImageView *arrow = [[UIImageView alloc] init];
            arrow.frame = CGRectMake(ScreenW - 30, 15 + 51 * i, 10, 20);
            arrow.image = [UIImage imageNamed:@"jiantou"];
            [infoBackgroundView addSubview:arrow];
        }else {
            UIImageView *arrow = [[UIImageView alloc] init];
            arrow.frame = CGRectMake(ScreenW - 30, 15 + 51 * i, 10, 20);
            arrow.image = [UIImage imageNamed:@"jiantou"];
            [infoBackgroundView addSubview:arrow];
        }
    }
    //昵称
    UILabel *nickLabel = [[UILabel alloc] init];
    nickLabel.frame = CGRectMake(20, 15, 60, 30);
    nickLabel.text = @"昵 称";
    [infoBackgroundView addSubview:nickLabel];
    UITextField *nickText = [[UITextField alloc] init];
    nickText.frame = CGRectMake(ScreenW - 140, 15, 100, 20);
    nickText.textAlignment = NSTextAlignmentRight;
    nickText.placeholder = @"未 填 写 ";
    [infoBackgroundView addSubview:nickText];
    _nick = nickText;
    //性别
    UILabel *sexLabel = [[UILabel alloc] init];
    sexLabel.frame = CGRectMake(20, 66, 60, 30);
    sexLabel.text = @"性 别";
    [infoBackgroundView addSubview:sexLabel];
    UITextField *sexText = [[UITextField alloc] init];
    sexText.frame = CGRectMake(ScreenW - 140, 66, 100, 20);
    sexText.textAlignment = NSTextAlignmentRight;
    sexText.placeholder = @"未 填 写 ";
    [infoBackgroundView addSubview:sexText];
    _sex = sexText;
    //手机号
    UILabel *phoneLabel = [[UILabel alloc] init];
    phoneLabel.frame = CGRectMake(20, 117, 60, 30);
    phoneLabel.text = @"手 机 号";
    [infoBackgroundView addSubview:phoneLabel];
    UITextField *phoneText = [[UITextField alloc] init];
    phoneText.frame = CGRectMake(ScreenW - 160, 117, 120, 20);
    phoneText.textAlignment = NSTextAlignmentRight;
    phoneText.placeholder = @"未 填 写 ";
    [infoBackgroundView addSubview:phoneText];
    _phone = phoneText;
    //生日
    UILabel *birthLabel = [[UILabel alloc] init];
    birthLabel.frame = CGRectMake(20, 168, 60, 30);
    birthLabel.text = @"生 日";
    [infoBackgroundView addSubview:birthLabel];
    UITextField *birthText = [[UITextField alloc] init];
    birthText.frame = CGRectMake(ScreenW - 140, 168, 100, 20);
    birthText.textAlignment = NSTextAlignmentRight;
    birthText.placeholder = @"未 填 写 ";
    [infoBackgroundView addSubview:birthText];
    _birth = birthText;
}
#pragma mark -- textField 
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    if (textField == _birth) {
        [_birth resignFirstResponder];
        STPickerDate *pickerDate = [[STPickerDate alloc]init];
        [pickerDate setDelegate:self];
        
        [pickerDate show];
        
    }
    else if (textField == _sex)
    {
        [_sex resignFirstResponder];
        NSMutableArray *array = [NSMutableArray array];
        for (int i =0; i<2; i++) {
            NSArray *arr = @[@"男",@"女"];
            [array addObject:arr[i]];
        }
        
        STPickerSingle *single=[[STPickerSingle alloc]init];
        [single setDelegate:self];
        [single setArrayData:array];
        [single setTitleUnit:@""];
        [single setTitle:@"请选择性别"];
        [single show];
    }
}
#pragma mark -- singleDelegate 
- (void)pickerSingle:(STPickerSingle *)pickerSingle selectedTitle:(NSString *)selectedTitle
{
    _sex.text = selectedTitle;
}
#pragma mark -- DateDelegate 
- (void)pickerDate:(STPickerDate *)pickerDate year:(NSInteger)year month:(NSInteger)month day:(NSInteger)day
{
    //假如月份小于10和天数小于10
    if (month<10&&day<10) {
        _birthday = [NSString stringWithFormat:@"%ld-0%ld-0%ld", (long)year, (long)month, (long)day];
        
        
    }else if(month>=10&&day>=10)
    {
        _birthday = [NSString stringWithFormat:@"%ld-%ld-%ld", (long)year, (long)month, (long)day];
    }
    
   _birth.text = _birthday;
}
#pragma mark -- 头像点击事件
- (void)headerBtnEvent:(UIButton *)sender {
    
}

#pragma mark -- 键盘弹出 
- (void)keyBoardShow:(NSNotification *)userInformation {
    CGRect rect = [[userInformation valueForKeyPath:[NSString stringWithFormat:@"userInfo.%@",UIKeyboardFrameEndUserInfoKey]] CGRectValue];
    if (ScreenH == rect.origin.y) {
        _infoView.frame = CGRectMake(0, _headerBGView.frame.origin.y + _headerBGView.bounds.size.height + 20, ScreenW, 203);
    }else {
        _infoView.frame = CGRectMake(0, rect.origin.y - 203, ScreenW, 203);
    }
}

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
