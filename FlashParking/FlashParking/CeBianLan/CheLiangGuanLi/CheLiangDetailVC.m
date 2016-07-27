//
//  CheLiangDetailVC.m
//  FlashParking
//
//  Created by 薄号 on 16/6/22.
//  Copyright © 2016年 LettingTechnology. All rights reserved.
//

#import "CheLiangDetailVC.h"
#import "CheLiangRenZhengVC.h"

@interface CheLiangDetailVC ()

@end

static CGFloat kFontSize = 17;

@implementation CheLiangDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setAttributeLeftItem:@"back.png" withMiddleItem:@"车辆详情" withRightItem:nil];
    
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
    //背景View
    UIView *backgroundView = [[UIView alloc] init];
    backgroundView.frame = CGRectMake(20, 100 * HEIGHTSCALE, ScreenW - 40, 182);
    backgroundView.backgroundColor = [UIColor whiteColor];
    backgroundView.layer.borderColor = LTColor(204, 208, 208).CGColor;
    backgroundView.layer.borderWidth = 1;
    backgroundView.layer.cornerRadius = 5;
    backgroundView.layer.masksToBounds = YES;
    [self.view addSubview:backgroundView];
    //标题
    NSArray *titArr = @[@"车牌号",@"车辆状态",@"备注"];
    for (NSInteger i = 0; i < 3; i++) {
        UILabel *titLabel = [[UILabel alloc] init];
        titLabel.frame = CGRectMake(20, 16 + 60 * i, 80, 30);
        titLabel.text = titArr[i];
        titLabel.font = [UIFont systemFontOfSize:kFontSize];
        [backgroundView addSubview:titLabel];
    }
    //车牌号
    UILabel *carLabel = [[UILabel alloc] init];
    carLabel.frame = CGRectMake(ScreenW - 140, 16, 80, 30);
    carLabel.text = [self.carDic valueForKeyPath:@"carPlate"];
    carLabel.textColor = [self colorWithHexColorString:@"#3293fa"];
    carLabel.font = [UIFont systemFontOfSize:kFontSize];
    [backgroundView addSubview:carLabel];
    //车辆状态
    UILabel *stateLabel = [[UILabel alloc] init];
    stateLabel.frame = CGRectMake(ScreenW - 140, 76, 80, 30);
    stateLabel.text = @"正常";
    stateLabel.font = [UIFont systemFontOfSize:kFontSize];
    [backgroundView addSubview:stateLabel];
    //备注
    UITextField *remark = [[UITextField alloc] init];
    remark.frame = CGRectMake(ScreenW - 230, 136, 170, 30);
    remark.backgroundColor = LTColor(237, 238, 239);
    remark.text = @"无";
    remark.textColor = LTColor(206, 207, 208);
    remark.textAlignment = NSTextAlignmentCenter;
    remark.font = [UIFont systemFontOfSize:kFontSize];
    [backgroundView addSubview:remark];
    //认证按钮
    UIButton *renZheng = [UIButton buttonWithType:UIButtonTypeCustom];
    renZheng.frame = CGRectMake(20, 130 * HEIGHTSCALE + 182, ScreenW - 40, 40);
    
    [renZheng  setBackgroundColor:[self colorWithHexColorString:@"#3293fa"]];
    [renZheng  setTitle:@"认证" forState:UIControlStateNormal];
    
//    
//    [renZheng setBackgroundImage:[UIImage imageNamed:@"renzheng_w"] forState:UIControlStateNormal];
//    [renZheng setBackgroundImage:[UIImage imageNamed:@"renzheng_y"] forState:UIControlStateHighlighted];
    [renZheng addTarget:self action:@selector(renZhengBtnEvent:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:renZheng];
    //解除绑定按钮
    UIButton *jieChu = [UIButton buttonWithType:UIButtonTypeCustom];
    jieChu.frame = CGRectMake(20, 140 * HEIGHTSCALE + 222, ScreenW - 40, 40);
    [jieChu setBackgroundImage:[UIImage imageNamed:@"delete_w"] forState:UIControlStateNormal];
    [jieChu setBackgroundImage:[UIImage imageNamed:@"delete_y"] forState:UIControlStateHighlighted];
    [jieChu addTarget:self action:@selector(jieChuBangDingBtnEvent:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:jieChu];
    if ([[self.carDic valueForKeyPath:@"carVerify"] isEqualToString:@"V"]) {
        renZheng.hidden = YES;
    }
}

#pragma mark -- 解除绑定按钮点击事件
- (void)jieChuBangDingBtnEvent:(UIButton *)sender {
    [LTHTTPManager postRequestWithURL:[NSString stringWithFormat:@"%@%@",kHttpDemo,kHttpDelcar] withParameter:@{@"carId":[self.carDic valueForKeyPath:@"carId"]} getData:^(NSMutableDictionary *dictionary, NSError *error) {
        if ([[dictionary valueForKeyPath:@"code"] isEqualToString:@"0"]) {
            LTWXBACK([dictionary valueForKeyPath:@"message"]);
        }else {
            LTWXTS([dictionary valueForKeyPath:@"message"]);
        }
    }];
}

#pragma mark -- 认证按钮点击事件
- (void)renZhengBtnEvent:(UIButton *)sender {
    CheLiangRenZhengVC *renZheng = [[CheLiangRenZhengVC alloc] init];
    renZheng.carDictionary = self.carDic;
    renZheng.view.backgroundColor = LTColor(220, 221, 222);
    [self.navigationController pushViewController:renZheng animated:YES];
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
