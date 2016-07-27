//
//  ParkDetailViewController.m
//  FlashParking
//
//  Created by 张弛 on 16/7/19.
//  Copyright © 2016年 LettingTechnology. All rights reserved.
//

#import "ParkDetailViewController.h"

@interface ParkDetailViewController ()

@end

@implementation ParkDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
     [self setAttributeLeftItem:@"back.png" withMiddleItem:@"车场详情" withRightItem:@".png"];
}

#pragma mark -- 返回、地图切换
- (void)leftButtonEvent:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)rightButtonEvent:(UIButton *)sender {
    
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
