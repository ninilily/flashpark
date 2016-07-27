//
//  DescribeViewController.m
//  FlashParking
//
//  Created by 张弛 on 16/6/23.
//  Copyright © 2016年 LettingTechnology. All rights reserved.
//

#import "DescribeViewController.h"

@interface DescribeViewController ()<UITextFieldDelegate>
{
    UITextField *_text;
    
}
@end

@implementation DescribeViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setAttributeLeftItem:@"back.png" withMiddleItem:@"车位描述" withRightItem:nil];
    
    [self createUI];

    
}
#pragma mark -- 导航按钮点击事件
- (void)leftButtonEvent:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)rightButtonEvent:(UIButton *)sender {
    
}
#pragma mark --页面布局
- (void)createUI
{
    self.view.backgroundColor=[UIColor colorWithRed:0.93 green:0.96 blue:0.97 alpha:1.0];
    
    _text=[[UITextField alloc]init];
    _text.frame=CGRectMake(10, 70 , ScreenW-20, 200);
    _text.placeholder=@"请输入";
    _text.backgroundColor=[UIColor whiteColor];
    _text.borderStyle=UITextBorderStyleRoundedRect;
    _text.delegate=self;
    
    [self.view addSubview:_text];
    
    UIButton *btn=[[UIButton alloc]init];
    [btn setBackgroundColor:[UIColor colorWithRed:0.17 green:0.71 blue:0.77 alpha:1.0]];
    [btn setTitle:@"保存" forState:UIControlStateNormal];
    btn.frame=CGRectMake(10,ScreenH-70 , ScreenW-20, 40);
    [btn addTarget:self action:@selector(backOrder:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:btn];
    
    
}

- (void)backOrder:(UIButton *)btn
{
    [self.navigationController popViewControllerAnimated:YES];
 
    if (self.sencondelegate && [self.sencondelegate respondsToSelector:@selector(sendDescribeLabel:)]) {
        [self.sencondelegate sendDescribeLabel:_text.text];
        
    }

    
}
#pragma mark --键盘代理
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if ((textField=_text)) {
        [textField resignFirstResponder];
    }
    return YES;
    
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
