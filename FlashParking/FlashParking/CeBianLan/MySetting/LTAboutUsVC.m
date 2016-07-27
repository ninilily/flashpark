//
//  LTAboutUsVC.m
//  FlashParking
//
//  Created by 薄号 on 16/7/1.
//  Copyright © 2016年 LettingTechnology. All rights reserved.
//

#import "LTAboutUsVC.h"

@interface LTAboutUsVC ()

@end

@implementation LTAboutUsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setAttributeLeftItem:@"back.png" withMiddleItem:@"关于我们" withRightItem:nil];
    
    [self pageLayout];
    
}

#pragma mark -- 导航按钮点击事件
- (void)leftButtonEvent:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)rightButtonEvent:(UIButton *)sender {
    
}

#pragma mark -- 页面布局
- (void)pageLayout {
    //logo
    UIImageView *headerImage = [[UIImageView alloc] init];
    headerImage.center = CGPointMake(ScreenW / 2, 120);
    headerImage.bounds = CGRectMake(0, 0, 60, 60);
    headerImage.backgroundColor = [UIColor cyanColor];
    headerImage.image = [UIImage imageNamed:@""];
    [self.view addSubview:headerImage];
    
    //介绍
    NSString *introduceString = @"闪停APP是上海乐停科技有限公司设计开发的“互联网+”模式的智能停车管理软件，通过采用国内最先进的停车场管理设备进行项目集成，使得目前已有的传统停车场和新建的停车场可以实现车牌识别进出、预约停车充电等互联网+停车功能，通过手机端软件进一步整合推广，达到停车智能化、分享化与新能源化。";
    CGRect rect = [introduceString boundingRectWithSize:CGSizeMake(ScreenW - 40, 10000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil];
    UIView *backgroundView = [[UIView alloc] init];
    backgroundView.center = CGPointMake(ScreenW / 2, ScreenH / 2);
    backgroundView.bounds = CGRectMake(0, 0, rect.size.width + 10, rect.size.height + 40);
    backgroundView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:backgroundView];
    
    UILabel *introduction = [[UILabel alloc] init];
    introduction.center = CGPointMake(ScreenW / 2, ScreenH / 2);
    introduction.bounds = CGRectMake(0, 0, rect.size.width, rect.size.height);
    introduction.backgroundColor = [UIColor whiteColor];
    introduction.font = [UIFont systemFontOfSize:15];
    introduction.numberOfLines = 0;
    introduction.textAlignment = NSTextAlignmentCenter;
    introduction.text = introduceString;
    introduction.textColor = [UIColor colorWithRed:0.61 green:0.62 blue:0.62 alpha:1.00];
    [self.view addSubview:introduction];
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
