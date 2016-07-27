//
//  LiShiDingDanVC.m
//  FlashParking
//
//  Created by 薄号 on 16/6/16.
//  Copyright © 2016年 LettingTechnology. All rights reserved.
//

#import "LiShiDingDanVC.h"
#import "WZXDateToStrTool.h"

@interface LiShiDingDanVC ()<UITableViewDelegate,UITableViewDataSource> {
    UITableView *_tableView;
    
    NSArray *_dataArray;
    
    
}

@end

static NSString *kDingDanCellIdentifier = @"kDingDanCellIdentifier";

@implementation LiShiDingDanVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setAttributeLeftItem:@"back.png" withMiddleItem:@"历史订单" withRightItem:nil];
    
    [self createTableView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    [LTHTTPManager postRequestWithURL:[NSString stringWithFormat:@"%@%@",kHttpDemo,kHttpMine] withParameter:@{@"uid":[[NSUserDefaults standardUserDefaults] objectForKey:@"userUid"],@"start":@"0",@"size":@"5"} getData:^(NSMutableDictionary *dictionary, NSError *error) {
        NSLog(@"%@",dictionary);
        if ([[dictionary valueForKeyPath:@"code"] isEqualToString:@"0"]) {
            _dataArray = [dictionary valueForKeyPath:@"data.orders"];
            
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


#pragma mark -- 创建表
- (void)createTableView {
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, ScreenW, ScreenH - 64) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    
    
}

#pragma mark -- 表代理方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kDingDanCellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:kDingDanCellIdentifier];
        cell.imageView.image = [UIImage imageNamed:@"car"];
    }
    
    UILabel *topTitle = [[UILabel alloc] init];
    topTitle.frame = CGRectMake(60, 5, 200, 20);
    topTitle.text = [_dataArray[indexPath.row] valueForKeyPath:@"orderName"];
    topTitle.font = [UIFont systemFontOfSize:12];
    [cell.contentView addSubview:topTitle];
    UILabel *enterTime = [[UILabel alloc] init];
    enterTime.frame = CGRectMake(60, 30, 200, 20);
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy年MM月dd日 HH时mm分"];
    NSDate *enterDate = [NSDate dateWithTimeIntervalSince1970:[[[_dataArray[indexPath.row] valueForKeyPath:@"enterTime"] substringToIndex:10] doubleValue]];
    enterTime.text = [NSString stringWithFormat:@"进场时间:%@",[formatter stringFromDate:enterDate]];
    enterTime.font = [UIFont systemFontOfSize:12];
    [cell.contentView addSubview:enterTime];
    
    UILabel *leaveTime = [[UILabel alloc] init];
    leaveTime.frame = CGRectMake(60, 55, 200, 20);
    NSDate *stopDate =[NSDate dateWithTimeIntervalSince1970:[[[_dataArray[indexPath.row] valueForKeyPath:@"enterTime"] substringToIndex:10] doubleValue]];
    NSString *message = [[WZXDateToStrTool tool]dateToStrWithDate:stopDate WithStrType:StrType1];
    
    leaveTime.text = [NSString stringWithFormat:@"停车时长:%@",message
                      ];
    
    leaveTime.font = [UIFont systemFontOfSize:12];
    [cell.contentView addSubview:leaveTime];
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    //查看订单详情
    
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
