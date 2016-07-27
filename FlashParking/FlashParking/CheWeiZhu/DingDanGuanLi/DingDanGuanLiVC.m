//
//  DingDanGuanLiVC.m
//  FlashParking
//
//  Created by 薄号 on 16/6/15.
//  Copyright © 2016年 LettingTechnology. All rights reserved.
//

#import "DingDanGuanLiVC.h"

@interface DingDanGuanLiVC ()<UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource> {
    UILabel *_pointerLine;
    UIScrollView *_backgroundScrollView;
}

@end

static NSInteger oldClickBtnIndex = 1600;
static NSString *const unfinishedOrderCellIdentifier = @"unfinishedOrderCellIdentifier";
static NSString *const finishedOrderCellIdentifier = @"finishedOrderCellIdentifier";

@implementation DingDanGuanLiVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setAttributeLeftItem:@"back.png" withMiddleItem:@"订单管理" withRightItem:nil];
    //页面
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
    //未完成订单按钮
    UIButton *unfinishedBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    unfinishedBtn.frame = CGRectMake(0, 64, ScreenW / 2, 40);
    [unfinishedBtn setTitle:@"未完成" forState:UIControlStateNormal];
    [unfinishedBtn setTitleColor:[self colorWithHexColorString:@"#3293fa"] forState:UIControlStateNormal];
    unfinishedBtn.tag = UnfinishedOrder;
    [unfinishedBtn addTarget:self action:@selector(carportInformationBtnEvent:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:unfinishedBtn];
    //已完成订单按钮
    UIButton *finishedBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    finishedBtn.frame = CGRectMake(ScreenW / 2, 64, ScreenW / 2, 40);
    [finishedBtn setTitle:@"已完成" forState:UIControlStateNormal];
    [finishedBtn setTitleColor:[UIColor colorWithRed:0.87 green:0.88 blue:0.88 alpha:1.0] forState:UIControlStateNormal];
    finishedBtn.tag = FinishedOrder;
    [finishedBtn addTarget:self action:@selector(carportInformationBtnEvent:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:finishedBtn];
    //按钮下方蓝线
    UILabel *blueLine = [[UILabel alloc] init];
    blueLine.frame = CGRectMake(0, 104, ScreenW / 2, 1);
    blueLine.backgroundColor = [self colorWithHexColorString:@"#3293fa"];
    [self.view addSubview:blueLine];
    _pointerLine = blueLine;
    
    [self createBackgroundScrollViewAndTableView];
}

#pragma mark -- 订单按钮点击事件
- (void)carportInformationBtnEvent:(UIButton *)sender {
    if (oldClickBtnIndex == sender.tag) {
        return;
    }
    //按钮字体颜色
    UIButton *oldBtn = [self.view viewWithTag:oldClickBtnIndex];
    [oldBtn setTitleColor:[UIColor colorWithRed:0.87 green:0.88 blue:0.88 alpha:1.0] forState:UIControlStateNormal];
    [sender setTitleColor:[self colorWithHexColorString:@"#3293fa"] forState:UIControlStateNormal];
    //指示线位置
    _pointerLine.frame = CGRectMake(sender.frame.origin.x, 104, ScreenW / 2, 1);
    //scrollView位置
    _backgroundScrollView.contentOffset = CGPointMake(ScreenW * (sender.tag - 1600), 0);
    //记录当前点击按钮tag
    oldClickBtnIndex = sender.tag;
}

#pragma mark -- 背景scrollView和左右tableView
- (void)createBackgroundScrollViewAndTableView {
    //背景scrollview
    UIScrollView *backgroundSV = [[UIScrollView alloc] init];
    backgroundSV.frame = CGRectMake(0, 125, ScreenW, ScreenH - 125);
    backgroundSV.contentSize = CGSizeMake(ScreenW * 2, 0);
    backgroundSV.pagingEnabled = YES;
    backgroundSV.showsHorizontalScrollIndicator = NO;
    backgroundSV.delegate = self;
    backgroundSV.scrollEnabled = NO;
    [self.view addSubview:backgroundSV];
    _backgroundScrollView = backgroundSV;
    //未完成订单表
    UITableView *unfinishedTV = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, backgroundSV.bounds.size.height) style:UITableViewStylePlain];
    unfinishedTV.delegate = self;
    unfinishedTV.dataSource = self;
    unfinishedTV.tag = UnfinishedTableView;
    unfinishedTV.separatorStyle = UITableViewCellSeparatorStyleNone;
    unfinishedTV.showsVerticalScrollIndicator = NO;
    [backgroundSV addSubview:unfinishedTV];
    //已完成订单表
    UITableView *finishedTV = [[UITableView alloc] initWithFrame:CGRectMake(ScreenW, 0, ScreenW, backgroundSV.bounds.size.height) style:UITableViewStylePlain];
    finishedTV.delegate = self;
    finishedTV.dataSource = self;
    finishedTV.tag = FinishedTableView;
    finishedTV.separatorStyle = UITableViewCellSeparatorStyleNone;
    [backgroundSV addSubview:finishedTV];
}

#pragma mark -- 表的代理方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 11;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView.tag == UnfinishedTableView) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:unfinishedOrderCellIdentifier];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:unfinishedOrderCellIdentifier];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            
            
        }
        for (UIView *subViews in cell.contentView.subviews) {
            [subViews removeFromSuperview];
        }
        
        if (0 == indexPath.row%2) {
            UIImageView *headerImage = [[UIImageView alloc] init];
            headerImage.frame = CGRectMake(0, 0, 60, 60);
            headerImage.image = [UIImage imageNamed:@"ding"];
            [cell.contentView addSubview:headerImage];
            //单号
            UILabel *danHao = [[UILabel alloc] init];
            danHao.frame = CGRectMake(80, 5, 80, 20);
            danHao.text = @"单号";
            [cell.contentView addSubview:danHao];
            UILabel *danHaoNumber = [[UILabel alloc] init];
            danHaoNumber.frame = CGRectMake(ScreenW - 160, 10, 120, 20);
            danHaoNumber.textAlignment = NSTextAlignmentRight;
            danHaoNumber.text = @"zxc1234567";
            [cell.contentView addSubview:danHaoNumber];
            //创建时间
            UILabel *createTime = [[UILabel alloc] init];
            createTime.frame = CGRectMake(80, 35, 80, 20);
            createTime.text = @"创建时间";
            createTime.textColor = [UIColor colorWithRed:0.81 green:0.81 blue:0.82 alpha:1.00];
            [cell.contentView addSubview:createTime];
            UILabel *createTimeText = [[UILabel alloc] init];
            createTimeText.frame = CGRectMake(ScreenW - 160, 35, 120, 20);
            createTimeText.textColor = [UIColor colorWithRed:0.81 green:0.81 blue:0.82 alpha:1.00];
            createTimeText.text = @"2016-5-5 13:13";
            [cell.contentView addSubview:createTimeText];
        }else {
            UIImageView *headerImage = [[UIImageView alloc] init];
            headerImage.frame = CGRectMake(0, 0, 60, 60);
            headerImage.image = [UIImage imageNamed:@"yu"];
            [cell.contentView addSubview:headerImage];
            //车位确认
            UILabel *makeSure = [[UILabel alloc] init];
            makeSure.frame = CGRectMake(80, 20, 80, 20);
            makeSure.text = @"车位确认";
            [cell.contentView addSubview:makeSure];
            UILabel *sureTime = [[UILabel alloc] init];
            sureTime.frame = CGRectMake(ScreenW - 160, 20, 120, 20);
            sureTime.textColor = [UIColor colorWithRed:0.81 green:0.81 blue:0.82 alpha:1.00];
            sureTime.text = @"2016-5-5 13:13";
            [cell.contentView addSubview:sureTime];
        }
       
        return cell;
    }else {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:finishedOrderCellIdentifier];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:finishedOrderCellIdentifier];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        
        UIImageView *headerView = [[UIImageView alloc]init];
        headerView.frame = CGRectMake(0, 0, 60, 60);
        headerView.image =[UIImage imageNamed:@"wan"];
        [cell.contentView addSubview:headerView];
        
        //单号
        UILabel *danHao = [[UILabel alloc] init];
        danHao.frame = CGRectMake(80, 5, 80, 20);
        danHao.text = @"单号";
        [cell.contentView addSubview:danHao];
        UILabel *danHaoNumber = [[UILabel alloc] init];
        danHaoNumber.frame = CGRectMake(ScreenW - 160, 10, 120, 20);
        danHaoNumber.textAlignment = NSTextAlignmentRight;
        danHaoNumber.text = @"zxc1234567";
        [cell.contentView addSubview:danHaoNumber];
        //创建时间
        UILabel *createTime = [[UILabel alloc] init];
        createTime.frame = CGRectMake(80, 35, 80, 20);
        createTime.text = @"创建时间";
        createTime.textColor = [UIColor colorWithRed:0.81 green:0.81 blue:0.82 alpha:1.00];
        [cell.contentView addSubview:createTime];
        UILabel *createTimeText = [[UILabel alloc] init];
        createTimeText.frame = CGRectMake(ScreenW - 160, 35, 120, 20);
        createTimeText.textColor = [UIColor colorWithRed:0.81 green:0.81 blue:0.82 alpha:1.00];
        createTimeText.text = @"2016-5-5 13:13";
        [cell.contentView addSubview:createTimeText];
        
        
        return cell;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 70;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView.tag == UnfinishedTableView) {
//        LTCheWeiDetailVC *cheWeiDetail = [[LTCheWeiDetailVC alloc] init];
//        cheWeiDetail.view.backgroundColor = [UIColor colorWithRed:0.93 green:0.96 blue:0.96 alpha:1.00];
//        [self.navigationController pushViewController:cheWeiDetail animated:YES];
    }
    
    
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
