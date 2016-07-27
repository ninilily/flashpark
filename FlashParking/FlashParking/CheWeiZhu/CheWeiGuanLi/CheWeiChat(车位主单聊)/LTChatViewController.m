//
//  LTChatViewController.m
//  FlashParking
//
//  Created by 薄号 on 16/7/4.
//  Copyright © 2016年 LettingTechnology. All rights reserved.
//

#import "LTChatViewController.h"


@interface LTChatViewController ()

@end

@implementation LTChatViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBarHidden = YES;
    
    [self pageLayout];
    
    self.conversationMessageCollectionView.frame = CGRectMake(0, 64, ScreenW, ScreenH - 64);
    
    
    
}

#pragma mark -- 页面布局
- (void)pageLayout {
    //导航条
    UIView *naviView = [[UIView alloc] init];
    naviView.frame = CGRectMake(0, 0, ScreenW, 64);
    naviView.backgroundColor = [UIColor colorWithRed:0.33 green:0.55 blue:0.99 alpha:1.00];
    [self.view addSubview:naviView];
    //返回按钮
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(10, 27, 30, 30);
    [backBtn setBackgroundImage:[UIImage imageNamed:@"back.png"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(backBtnEvent:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backBtn];
    //标题
    UILabel *middleTitle = [[UILabel alloc] init];
    middleTitle.center = CGPointMake(ScreenW / 2, 42);
    middleTitle.bounds = CGRectMake(0, 0, 200, 30);
    middleTitle.textColor = [UIColor whiteColor];
    middleTitle.textAlignment = NSTextAlignmentCenter;
    middleTitle.text = @"聊天界面";
    middleTitle.font = [UIFont boldSystemFontOfSize:20];
    [self.view addSubview:middleTitle];
}

#pragma mark -- 返回上级界面
- (void)backBtnEvent:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
    
    
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
