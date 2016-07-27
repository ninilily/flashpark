//
//  MyWalletVC.m
//  FlashParking
//
//  Created by 薄号 on 16/6/16.
//  Copyright © 2016年 LettingTechnology. All rights reserved.
//

#import "MyWalletVC.h"

@interface MyWalletVC ()

@end

@implementation MyWalletVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setAttributeLeftItem:@"back.png" withMiddleItem:@"我的钱包" withRightItem:nil];
    
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
    //账户余额
    UIView *balanceView = [[UIView alloc] init];
    balanceView.frame = CGRectMake(0, 64, ScreenW, 70);
    balanceView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:balanceView];
    UILabel *balanceLabel = [[UILabel alloc] init];
    balanceLabel.frame = CGRectMake(20, 20, 80, 30);
    balanceLabel.text = @"账户余额";
    [balanceView addSubview:balanceLabel];
    NSString *moneyNum = @"100.00";
    NSString *moneyL = [NSString stringWithFormat:@"%@¥",moneyNum];
    NSMutableAttributedString *moneyAttribute = [[NSMutableAttributedString alloc] initWithString:moneyL];
    [moneyAttribute addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:0.90 green:0.77 blue:0.49 alpha:1.00] range:NSMakeRange(0, moneyL.length - 1)];
    [moneyAttribute addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:0.58 green:0.58 blue:0.58 alpha:1.00] range:NSMakeRange(moneyL.length - 1, 1)];
    UILabel *moneyLabel = [[UILabel alloc] init];
    moneyLabel.center = CGPointMake(ScreenW / 2, 35);
    moneyLabel.bounds = CGRectMake(0, 0, 120, 30);
    moneyLabel.textAlignment = NSTextAlignmentCenter;
    moneyLabel.attributedText = moneyAttribute;
    [balanceView addSubview:moneyLabel];
    UIButton *tiXian = [UIButton buttonWithType:UIButtonTypeCustom];
    tiXian.frame = CGRectMake(ScreenW - 80, 20, 60, 30);
    [tiXian setTitle:@"提现" forState:UIControlStateNormal];
    [tiXian setTitleColor:[UIColor colorWithRed:0.50 green:0.80 blue:0.84 alpha:1.00] forState:UIControlStateNormal];
    tiXian.layer.cornerRadius = 5;
    tiXian.layer.masksToBounds = YES;
    tiXian.layer.borderColor = [[UIColor colorWithRed:0.50 green:0.80 blue:0.84 alpha:1.00] CGColor];
    tiXian.layer.borderWidth = 1;
    [tiXian addTarget:self action:@selector(tiXianBtnEvent:) forControlEvents:UIControlEventTouchUpInside];
    [balanceView addSubview:tiXian];
    
    //充值
    UIButton *chongZhi = [UIButton buttonWithType:UIButtonTypeCustom];
    chongZhi.frame = CGRectMake(0, 150, ScreenW, 60);
    chongZhi.backgroundColor = [UIColor whiteColor];
    [chongZhi setTitle:@"充值" forState:UIControlStateNormal];
    [chongZhi setImage:[UIImage imageNamed:@"jiantou"] forState:UIControlStateNormal];
    chongZhi.titleEdgeInsets = UIEdgeInsetsMake(20, 20, 20, ScreenW - 70);
    chongZhi.imageEdgeInsets = UIEdgeInsetsMake(20, ScreenW - 30, 20, 20);
    [chongZhi setTitleColor:[UIColor colorWithRed:0.60 green:0.84 blue:0.86 alpha:1.00] forState:UIControlStateNormal];
    chongZhi.titleLabel.font = [UIFont systemFontOfSize:18];
    [chongZhi addTarget:self action:@selector(chongZhiBtnEvent:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:chongZhi];
    
    //我的支付方式
    UILabel *myPayforWay = [[UILabel alloc] init];
    myPayforWay.frame = CGRectMake(20, 270, 300, 20);
    myPayforWay.text = @"我的支付方式";
    [self.view addSubview:myPayforWay];
    
    //微信支付
    UIView *weiXinView = [[UIView alloc] init];
    weiXinView.frame = CGRectMake(0, 310, ScreenW, 60);
    weiXinView.backgroundColor = [UIColor whiteColor];
    [weiXinView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(weiXinZhiFu)]];
    [self.view addSubview:weiXinView];
    UIImageView *weiXinImage = [[UIImageView alloc] init];
    weiXinImage.center = CGPointMake(35, weiXinView.bounds.size.height / 2);
    weiXinImage.bounds = CGRectMake(0, 0, 30, 30);
    weiXinImage.image = [UIImage imageNamed:@"weixin"];
    [weiXinView addSubview:weiXinImage];
    UILabel *weiXinLabel = [[UILabel alloc] init];
    weiXinLabel.frame = CGRectMake(ScreenW - 140, 20, 120, 20);
    weiXinLabel.text = @"微信支付";
    weiXinLabel.textAlignment = NSTextAlignmentRight;
    weiXinLabel.textColor = LTColor(151, 152, 153);
    weiXinLabel.font = [UIFont systemFontOfSize:18];
    [weiXinView addSubview:weiXinLabel];

    //支付宝支付
    UIView *zhiFuBaoView = [[UIView alloc] init];
    zhiFuBaoView.frame = CGRectMake(0, 371, ScreenW, 60);
    zhiFuBaoView.backgroundColor = [UIColor whiteColor];
    [zhiFuBaoView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(zhiFuBaoZhiFu)]];
    [self.view addSubview:zhiFuBaoView];
    UIImageView *zhiFuBaoImage = [[UIImageView alloc] init];
    zhiFuBaoImage.center = CGPointMake(35, weiXinView.bounds.size.height / 2);
    zhiFuBaoImage.bounds = CGRectMake(0, 0, 30, 30);
    zhiFuBaoImage.image = [UIImage imageNamed:@"zhifubao"];
    [zhiFuBaoView addSubview:zhiFuBaoImage];
    UILabel *zhiFuBaoLabel = [[UILabel alloc] init];
    zhiFuBaoLabel.frame = CGRectMake(ScreenW - 140, 20, 120, 20);
    zhiFuBaoLabel.text = @"支付宝支付";
    zhiFuBaoLabel.textAlignment = NSTextAlignmentRight;
    zhiFuBaoLabel.textColor = LTColor(151, 152, 153);
    zhiFuBaoLabel.font = [UIFont systemFontOfSize:18];
    [zhiFuBaoView addSubview:zhiFuBaoLabel];
}

#pragma mark -- 提现
- (void)tiXianBtnEvent:(UIButton *)sender {
    NSLog(@"提现");
}

#pragma mark -- 充值
- (void)chongZhiBtnEvent:(UIButton *)sender {
    NSLog(@"充值");
}

#pragma mark -- 微信支付
- (void)weiXinZhiFu {
    NSLog(@"微信支付");
}

#pragma mark -- 支付宝支付
- (void)zhiFuBaoZhiFu {
    NSLog(@"支付宝支付");
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
