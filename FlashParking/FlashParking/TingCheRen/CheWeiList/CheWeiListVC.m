//
//  CheWeiListVC.m
//  FlashParking
//
//  Created by 薄号 on 16/6/17.
//  Copyright © 2016年 LettingTechnology. All rights reserved.
//

#import "CheWeiListVC.h"
#import "CheWeiDetailVC.h"
#import "HYBStarEvaluationView.h"


#define kCellIdentifier @"cellIdentifier"

@interface CheWeiListVC ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation CheWeiListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setAttributeLeftItem:@"back.png" withMiddleItem:@"车位列表" withRightItem:nil];
    
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
    UILabel *label = [[UILabel alloc]init];
    label.text = @"您搜索到的结果";
    label.font = [UIFont systemFontOfSize:14];
    label.textColor = [UIColor lightGrayColor];
    
    label.frame = CGRectMake(10, 64, 100, 20);
    [self.view addSubview:label];
    
    
    //创建表
    [self createTableView];
}

#pragma mark -- 创建表
- (void)createTableView {
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 84, ScreenW, ScreenH - 84) style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
}

#pragma mark -- 表代理方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 11;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 190;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:kCellIdentifier];
    }
    //图片
    UIImageView *headerImage = [[UIImageView alloc] init];
    headerImage.frame = CGRectMake(10, 30, ScreenW-20, 120);
    headerImage.image = [UIImage imageNamed:@"fbbg"];
    [cell.contentView addSubview:headerImage];
    
    UIImageView *image = [[UIImageView alloc]init];
    image.image = [UIImage imageNamed:@"shangyong"];
    image.frame = CGRectMake(10, 155, 18, 18);
    [cell.contentView addSubview:image];
    
    
    //地址文字
    UILabel *addressLable = [[UILabel alloc]init];
    addressLable.text = @"上海市长宁区长宁路1551号地下停车场a2";
    addressLable.textColor = [UIColor colorWithRed:0.50 green:0.50 blue:0.51 alpha:1.00];
    addressLable.font=[UIFont systemFontOfSize:12];
    addressLable.frame = CGRectMake(40,150,230,20);
    [cell.contentView addSubview:addressLable];
    
    //评价
    UILabel *appraiselabel = [[UILabel alloc]init];
    appraiselabel.text = @"评价";
    appraiselabel.textColor = [UIColor colorWithRed:0.50 green:0.50 blue:0.51 alpha:1.00];
    appraiselabel.font = [UIFont systemFontOfSize:12];
    appraiselabel.frame = CGRectMake(10,170,30, 20);
    [cell.contentView addSubview:appraiselabel];
    
    
    //星级评价
    HYBStarEvaluationView *starViewUnClick = [[HYBStarEvaluationView alloc]initWithFrame:CGRectMake(40, 170, 100, 15) numberOfStars:5 isVariable:NO];
    starViewUnClick.actualScore = 5;
    starViewUnClick.fullScore = 5;
    starViewUnClick.isContrainsHalfStar = YES;
    [cell.contentView addSubview:starViewUnClick];
    
    //评价内容
    UIButton *orderMain=[UIButton buttonWithType:UIButtonTypeSystem];
    [orderMain setTitle:@"(共178条评价)" forState:UIControlStateNormal];
    orderMain.frame = CGRectMake(150, 170, 100, 15);
    [cell.contentView addSubview:orderMain];
    
    //聊天切入
    UIButton *chat = [UIButton buttonWithType:UIButtonTypeSystem];
    [chat setImage:[UIImage imageNamed:@"liaotian_y"] forState:UIControlStateHighlighted];
    [chat setImage:[UIImage imageNamed:@"liaotian"] forState:UIControlStateNormal];
    
    chat.frame = CGRectMake(270, 160, 40, 40);
    [cell.contentView addSubview:chat];

    
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    CheWeiDetailVC *detail = [[CheWeiDetailVC alloc] init];
    detail.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController pushViewController:detail animated:YES];
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
