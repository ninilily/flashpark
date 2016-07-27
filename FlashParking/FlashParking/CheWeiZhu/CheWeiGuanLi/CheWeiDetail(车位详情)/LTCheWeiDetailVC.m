//
//  LTCheWeiDetailVC.m
//  FlashParking
//
//  Created by 薄号 on 16/7/1.
//  Copyright © 2016年 LettingTechnology. All rights reserved.
//
#import "LTCheWeiDetailVC.h"
#import "LTChatViewController.h"

@interface LTCheWeiDetailVC ()

@end

@implementation LTCheWeiDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setAttributeLeftItem:@"back.png" withMiddleItem:@"车位详情" withRightItem:nil];
    
    [self pageLayout];
    
}

#pragma mark -- 导航按钮点击事件
- (void)leftButtonEvent:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)rightButtonEvent:(UIButton *)sender {
    
}
- (void)viewWillAppear:(BOOL)animated
{
    
}

#pragma mark -- 页面布局
- (void)pageLayout {
    //车库图片
    UIImageView *carportImage = [[UIImageView alloc] init];
    carportImage.frame = CGRectMake(20, 70, ScreenW - 40, 130);
    carportImage.image = [UIImage imageNamed:@"cheweibg"];
    [self.view addSubview:carportImage];
    
    //背景scrollview
    UIScrollView *backgroundScrollView = [[UIScrollView alloc] init];
    backgroundScrollView.frame = CGRectMake(0, 210, ScreenW, ScreenH - 290);
    backgroundScrollView.showsVerticalScrollIndicator = NO;
    backgroundScrollView.bounces = NO;
    [self.view addSubview:backgroundScrollView];
    //标签Label
    NSArray *markArray = @[@"地址",@"姓名",@"电话",@"停车时间",@"金额",@"定金"];
    for (NSInteger i = 0; i < 6; i++) {
        UIView *markView = [[UIView alloc] init];
        markView.frame = CGRectMake(0, 65 *i, ScreenW, 60);
        markView.backgroundColor = [UIColor whiteColor];
        [backgroundScrollView addSubview:markView];
        UILabel *markLabel = [[UILabel alloc] init];
        markLabel.frame = CGRectMake(20, 20, 70, 20);
        markLabel.backgroundColor = [UIColor whiteColor];
        markLabel.text = markArray[i];
        [markView addSubview:markLabel];
        switch (i) {
            case 0: {
                //地址
                UILabel *addressLabel = [[UILabel alloc] init];
                addressLabel.frame = CGRectMake(90, 20, ScreenW - 180, 20);
                addressLabel.text = @"上海市长宁区长宁路1551号地下停车场a2";
                
                
                addressLabel.adjustsFontSizeToFitWidth = YES;
                [markView addSubview:addressLabel];
                UIButton *daoHang = [UIButton buttonWithType:UIButtonTypeCustom];
                daoHang.frame = CGRectMake(ScreenW - 80, 0, 80, 60);
                daoHang.backgroundColor = [UIColor colorWithRed:0.25 green:0.71 blue:0.77 alpha:1.00];
                [daoHang setTitle:@"导航" forState:UIControlStateNormal];
                //                [daoHang setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
                [daoHang addTarget:self action:@selector(daoHangBtnEvent:) forControlEvents:UIControlEventTouchUpInside];
                [markView addSubview:daoHang];
                break;
            }
            case 1: {
                //姓名
                UIButton *callBtn = [UIButton buttonWithType:UIButtonTypeCustom];
                callBtn.frame = CGRectMake(ScreenW - 90, 10, 40, 40);
                [callBtn setImage:[UIImage imageNamed:@"liaotian_y"] forState:UIControlStateNormal];
                [callBtn addTarget:self action:@selector(callCarportHost:) forControlEvents:UIControlEventTouchUpInside];
                [markView addSubview:callBtn];
                UILabel *nameLabel = [[UILabel alloc] init];
                nameLabel.frame = CGRectMake(ScreenW - 60, 20, 40, 20);
                nameLabel.text = @"王大锤";
                nameLabel.adjustsFontSizeToFitWidth = YES;
                [markView addSubview:nameLabel];
                break;
            }
            case 2: {
                //电话
                UILabel *promptLabel = [[UILabel alloc] init];
                promptLabel.center = CGPointMake(ScreenW / 2, 30);
                promptLabel.bounds = CGRectMake(0, 0, 120, 20);
                promptLabel.text = @"（提交定金才能显示）";
                promptLabel.adjustsFontSizeToFitWidth = YES;
                promptLabel.textColor = [UIColor colorWithRed:0.62 green:0.83 blue:0.87 alpha:1.00];
                [markView addSubview:promptLabel];
                UILabel *phoneNumber = [[UILabel alloc] init];
                phoneNumber.frame = CGRectMake(ScreenW - 100, 20, 80, 20);
                phoneNumber.text = @"***********";
                phoneNumber.adjustsFontSizeToFitWidth = YES;
                [markView addSubview:phoneNumber];
                break;
            }
            case 3: {
                //停车时间
                UILabel *stopTime = [[UILabel alloc] init];
                stopTime.frame = CGRectMake(ScreenW - 160, 20, 140, 20);
                stopTime.text = @"从上午9点到下午6点";
                stopTime.adjustsFontSizeToFitWidth = YES;
                stopTime.textAlignment = NSTextAlignmentRight;
                stopTime.textColor = [UIColor colorWithRed:0.62 green:0.83 blue:0.87 alpha:1.00];
                [markView addSubview:stopTime];
                break;
            }
            case 4: {
                //金额、价格
                UILabel *priceLabel = [[UILabel alloc] init];
                priceLabel.frame = CGRectMake(ScreenW - 100, 20, 80, 20);
                priceLabel.textAlignment = NSTextAlignmentRight;
                priceLabel.text = @"1元（每小时）";
                priceLabel.adjustsFontSizeToFitWidth = YES;
                priceLabel.textColor = [UIColor colorWithRed:0.92 green:0.68 blue:0.61 alpha:1.00];
                [markView addSubview:priceLabel];
                break;
            }
            case 5: {
                //定金
                UILabel *orderMondy = [[UILabel alloc] init];
                orderMondy.frame = CGRectMake(ScreenW - 60, 20, 40, 20);
                orderMondy.textAlignment = NSTextAlignmentRight;
                orderMondy.adjustsFontSizeToFitWidth = YES;
                orderMondy.text = @"10元";
                orderMondy.textColor = [UIColor colorWithRed:0.92 green:0.68 blue:0.61 alpha:1.00];
                [markView addSubview:orderMondy];
                break;
            }
            default:
                break;
        }
    }
    backgroundScrollView.contentSize = CGSizeMake(0, 65 * 6);
    
    //租车位按钮
    UIButton *zuCheWei = [UIButton buttonWithType:UIButtonTypeCustom];
    zuCheWei.frame = CGRectMake(20, ScreenH - 70, ScreenW - 40, 40 * HEIGHTSCALE);
    zuCheWei.backgroundColor = [UIColor colorWithRed:0.25 green:0.71 blue:0.77 alpha:1.00];
    [zuCheWei setTitle:@"租车位" forState:UIControlStateNormal];
    [self.view addSubview:zuCheWei];
    
}


#pragma mark -- 开始导航
- (void)daoHangBtnEvent:(UIButton *)sender {
    NSLog(@"开始导航");
}

#pragma mark -- 租车位
- (void)zuCheWeiBtnEvent:(UIButton *)sender {
    NSLog(@"租车位");
}

#pragma mark -- 对话车位主
- (void)callCarportHost:(UIButton *)sender {
    NSLog(@"即时通讯");
    
    //新建一个聊天会话View Controller对象
    LTChatViewController *chat = [[LTChatViewController alloc]init];
    //设置会话的类型，如单聊、讨论组、群聊、聊天室、客服、公众服务会话等
    chat.conversationType = ConversationType_PRIVATE;
    //设置会话的目标会话ID。（单聊、客服、公众服务会话为对方的ID，讨论组、群聊、聊天室为会话的ID）
    //    chat.targetId = [[NSUserDefaults standardUserDefaults] objectForKey:@"user"];
    chat.targetId = @"u14570124030730525bU";
    
    
    //设置聊天会话界面要显示的标题
    chat.title = @"想显示的会话标题";
    //显示聊天会话界面
    [self.navigationController pushViewController:chat animated:YES];
    
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
