//
//  CheLiangGuanLiVC.m
//  FlashParking
//
//  Created by 薄号 on 16/6/16.
//  Copyright © 2016年 LettingTechnology. All rights reserved.
//

#import "CheLiangGuanLiVC.h"
#import "CheLiangDetailVC.h"
#import "CheLiangRenZhengVC.h"
#import "CheLiangTianJiaVC.h"

@interface CheLiangGuanLiVC ()<UITableViewDelegate,UITableViewDataSource> {
    UITableView *_tableView;
}

@property (nonatomic, strong) NSMutableArray *dataArray;

@end

static NSString *const kCellIdentifier = @"kCheLiangGuanLiCell";

@implementation CheLiangGuanLiVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setAttributeLeftItem:@"back.png" withMiddleItem:@"车辆管理" withRightItem:nil];
    
    [self pageLayout];
    
    //表
    [self createMyTableView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    [LTHTTPManager postRequestWithURL:[NSString stringWithFormat:@"%@%@",kHttpDemo,kHttpCarManager] withParameter:@{@"uid":[[NSUserDefaults standardUserDefaults] objectForKey:@"userUid"]} getData:^(NSMutableDictionary *dictionary, NSError *error) {
        NSLog(@"%@",dictionary);
        
        if ([[dictionary valueForKeyPath:@"code"] isEqualToString:@"0"]) {
            self.dataArray = [dictionary valueForKeyPath:@"data.cars"];
            
            
            [_tableView reloadData];
        }else {
            LTWXTS([dictionary valueForKeyPath:@"message"]);
        }
    }];
}

#pragma mark -- 导航按钮点击事件
- (void)leftButtonEvent:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)rightButtonEvent:(UIButton *)sender {
    
}

#pragma mark -- 页面布局
- (void)pageLayout {
    //添加按钮
    UIButton *addCar = [UIButton buttonWithType:UIButtonTypeCustom];
    addCar.frame = CGRectMake(20, ScreenH - 70, ScreenW - 40, 40);
    
    [addCar setBackgroundColor:[self colorWithHexColorString:@"#3293fa"]];
    
    [addCar setTitle:@"添加" forState:UIControlStateNormal];
    
//
//    [addCar setBackgroundImage:[UIImage imageNamed:@"add_w"] forState:UIControlStateNormal];
//    [addCar setBackgroundImage:[UIImage imageNamed:@"add_y"] forState:UIControlStateHighlighted];
    [addCar addTarget:self action:@selector(addCarEvent:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:addCar];
}

#pragma mark -- tableView表
- (void)createMyTableView {
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, ScreenW, 240) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
}

#pragma mark -- tableView表的代理方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:kCellIdentifier];
    }
    for (UIView *subView in cell.contentView.subviews) {
        [subView removeFromSuperview];
    }
    
    cell.imageView.image = [UIImage imageNamed:@"car"];
    cell.textLabel.text = [self.dataArray[indexPath.row] valueForKeyPath:@"carPlate"];
    if ([[self.dataArray[indexPath.row] valueForKeyPath:@"carVerify"] isEqualToString:@"N"]) {
        UIImageView *renZhengImage = [[UIImageView alloc] init];
        renZhengImage.frame = CGRectMake(160, 28, 24, 24);
        renZhengImage.image = [UIImage imageNamed:@"yichang"];
        [cell.contentView addSubview:renZhengImage];
    }
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    //跳转
    CheLiangDetailVC *detail = [[CheLiangDetailVC alloc] init];
    detail.carDic = self.dataArray[indexPath.row];
    detail.view.backgroundColor = LTColor(220, 221, 222);
    [self.navigationController pushViewController:detail animated:YES];
}

#pragma mark -- 添加车辆
- (void)addCarEvent:(UIButton *)sender {
    CheLiangTianJiaVC *tianJai = [[CheLiangTianJiaVC alloc] init];
    tianJai.view.backgroundColor = [UIColor colorWithRed:0.93 green:0.96 blue:0.96 alpha:1.00];
    [self.navigationController pushViewController:tianJai animated:YES];
}


- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [[NSMutableArray alloc] initWithCapacity:0];
    }
    return _dataArray;
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
