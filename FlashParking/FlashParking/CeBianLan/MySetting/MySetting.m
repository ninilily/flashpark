//
//  MySetting.m
//  FlashParking
//
//  Created by 薄号 on 16/6/16.
//  Copyright © 2016年 LettingTechnology. All rights reserved.
//

#import "MySetting.h"
#import "LTAboutUsVC.h"

@interface MySetting ()

@end

@implementation MySetting

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setAttributeLeftItem:@"back.png" withMiddleItem:@"设置" withRightItem:nil];
    
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
    [self createTuiSongPart];
    
    [self createSettingBtnPart];
    
    [self createQuitBtnPart];
    
    [self createServicePhonePart];
}

#pragma mark -- 推送
- (void)createTuiSongPart {
    //推送背景View
    UIView *tuiSongView  = [[UIView alloc] init];
    tuiSongView.frame = CGRectMake(0, 80 * HEIGHTSCALE, ScreenW, 101);
    tuiSongView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:tuiSongView];
    //消息
    UILabel *xiaoXiLabel = [[UILabel alloc] init];
    xiaoXiLabel.frame = CGRectMake(20, 17, 150, 20);
    xiaoXiLabel.text = @"消息推送";
    xiaoXiLabel.font = [UIFont systemFontOfSize:18];
    xiaoXiLabel.textColor = LTColor(146, 147, 148);
    [tuiSongView addSubview:xiaoXiLabel];
    UISwitch *xiaoXiSwitch = [[UISwitch alloc] init];
    xiaoXiSwitch.frame = CGRectMake(tuiSongView.bounds.size.width - 70, 11, 40, 20);
    [xiaoXiSwitch addTarget:self action:@selector(xiaoXiTuiSong:) forControlEvents:UIControlEventValueChanged];
    [tuiSongView addSubview:xiaoXiSwitch];
    //分隔线
    UILabel *middleLine = [[UILabel alloc] init];
    middleLine.frame = CGRectMake(20, 51, ScreenW - 40, 1);
    middleLine.backgroundColor = [UIColor colorWithRed:0.89 green:0.89 blue:0.89 alpha:1.00];
    [tuiSongView addSubview:middleLine];
    //短信
    UILabel *messageLabel = [[UILabel alloc] init];
    messageLabel.frame = CGRectMake(20, 67, 150, 20);
    messageLabel.text = @"短信推送";
    messageLabel.font = [UIFont systemFontOfSize:18];
    messageLabel.textColor = LTColor(146, 147, 148);
    [tuiSongView addSubview:messageLabel];
    UISwitch *messageSwitch = [[UISwitch alloc] init];
    messageSwitch.frame = CGRectMake(tuiSongView.bounds.size.width - 70, 62, 40, 20);
    [messageSwitch addTarget:self action:@selector(messageTuiSong:) forControlEvents:UIControlEventValueChanged];
    [tuiSongView addSubview:messageSwitch];
}
#pragma mark -- 推荐好友、意见反馈、关于闪停
- (void)createSettingBtnPart {
    //推荐好友、意见反馈、关于闪停背景View
    UIView *backgroundView = [[UIView alloc] init];
    backgroundView.frame = CGRectMake(0, 100 * HEIGHTSCALE + 101, ScreenW, 152);
    backgroundView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:backgroundView];
    //标题
    NSArray *titArr = @[@"推荐好友",@"意见反馈",@"关于FLASHPARK"];
    for (NSInteger i = 0; i < 3; i++) {
        UILabel *label = [[UILabel alloc] init];
        label.frame = CGRectMake(20, 17 + 51 * i, 150, 20);
        label.text = titArr[i];
        label.font = [UIFont systemFontOfSize:18];
        label.textColor = LTColor(146, 147, 148);
        [backgroundView addSubview:label];
    }
    //分隔线
    for (NSInteger i = 0; i < 2; i++) {
        UILabel *line = [[UILabel alloc] init];
        line.frame = CGRectMake(20, 51 * i + 51, ScreenW - 40, 1);
        line.backgroundColor = [UIColor colorWithRed:0.88 green:0.88 blue:0.89 alpha:1.00];
        [backgroundView addSubview:line];
    }
    //按钮
    for (NSInteger i = 0; i < 3; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(0, 51 * i, backgroundView.bounds.size.width, 50);
        button.tag = 1030 + i;
        [button addTarget:self action:@selector(settingButtonEvent:) forControlEvents:UIControlEventTouchUpInside];
        [backgroundView addSubview:button];
    }
}
#pragma mark -- 客服电话
- (void)createServicePhonePart {
    //头像图标
    UIImageView *headImage = [[UIImageView alloc] init];
    headImage.frame = CGRectMake(ScreenW / 4 - 40, 120 * HEIGHTSCALE + 261, 20, 20);
    headImage.image = [UIImage imageNamed:@"call"];
    headImage.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:headImage];
    //客服电话Label
    UILabel *serviceLabel = [[UILabel alloc] init];
    serviceLabel.frame = CGRectMake(ScreenW / 4 - 15, 120 * HEIGHTSCALE + 257, 80, 25);
    serviceLabel.text = @"客服电话";
    serviceLabel.font = [UIFont systemFontOfSize:15];
    //    serviceLabel.adjustsFontSizeToFitWidth = YES;
    [self.view addSubview:serviceLabel];
    //电话按钮
    UIButton *phoneNumber = [UIButton buttonWithType:UIButtonTypeCustom];
    phoneNumber.frame = CGRectMake(ScreenW * 3 / 4 - 70, 120 * HEIGHTSCALE + 257, 120, 25);
    phoneNumber.titleLabel.font = [UIFont systemFontOfSize:15];
    [phoneNumber setTitle:@"12345678901" forState:UIControlStateNormal];
    [phoneNumber setTitleColor:LTColor(222, 116, 98) forState:UIControlStateNormal];
    [phoneNumber addTarget:self action:@selector(serviceBtnEvent:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:phoneNumber];
}
#pragma mark -- 退出按钮
- (void)createQuitBtnPart {
    //退出按钮
    UIButton *quitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    quitBtn.frame = CGRectMake(20, 120 * HEIGHTSCALE + 297, ScreenW - 40, 40);
    [quitBtn setBackgroundImage:[UIImage imageNamed:@"backTo_w"] forState:UIControlStateNormal];
    [quitBtn setBackgroundImage:[UIImage imageNamed:@"backTo_y"] forState:UIControlStateHighlighted];
    [quitBtn addTarget:self action:@selector(quitButtonEvent:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:quitBtn];
}

#pragma mark -- 推送开关点击事件
- (void)xiaoXiTuiSong:(UISwitch *)sender {
    NSLog(@"消息%d",sender.isOn);
    if (sender.isOn) {
        LTWXTS(@"消息推送已开启")
    }else {
        LTWXTS(@"消息推送已取消")
    }
}
- (void)messageTuiSong:(UISwitch *)sender {
    if (sender.isOn) {
        LTWXTS(@"短信推送已开启")
    }else {
        LTWXTS(@"短信推送已取消")
    }
}
//按钮
- (void)settingButtonEvent:(UIButton *)sender {
    switch (sender.tag) {
        case TuiJianHaoYou: {
            NSLog(@"推荐好友");
            break;
        }
        case YiJianFanKui: {
            NSLog(@"意见反馈");
            break;
        }
        case GuanYuFlashPark: {
            LTAboutUsVC *aboutUs = [[LTAboutUsVC alloc] init];
            aboutUs.view.backgroundColor = [UIColor colorWithRed:0.93 green:0.96 blue:0.96 alpha:1.00];
            [self.navigationController pushViewController:aboutUs animated:YES];
            break;
        }
        default:
            break;
    }
}

#pragma mark -- 退出按钮点击事件
- (void)quitButtonEvent:(UIButton *)sender {
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"userUid"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"phoneNumber"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"passwrod"];
    if ([[NSUserDefaults standardUserDefaults] synchronize]) {
        LTWXBACK(@"退出成功");
    }
}

#pragma mark -- 客服电话按钮点击事件
- (void)serviceBtnEvent:(UIButton *)sender {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"tel://10086"]];
    NSLog(@"拨打电话");
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
