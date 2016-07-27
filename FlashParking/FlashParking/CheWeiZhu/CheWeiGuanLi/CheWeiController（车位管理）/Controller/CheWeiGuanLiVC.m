//
//  CheWeiGuanLiVC.m
//  FlashParking
//
//  Created by 薄号 on 16/6/15.
//  Copyright © 2016年 LettingTechnology. All rights reserved.
//

#import "CheWeiGuanLiVC.h"
#import "LTCheWeiDetailVC.h"
#import "LTHTTPManager.h"
#import "CheWeiChuZuVC.h"
#import "LoginVC.h"

#import "CheWeiEditorViewController.h"
@interface CheWeiGuanLiVC ()<UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource> {
    UILabel *_pointerLine;
    UIScrollView *_backgroundScrollView;
    
    NSArray *_stateImageArr;
    UITableView *_informationTableView;
    UITableView *_publishStateTableView;
    NSArray *_DataArray;
    NSInteger _page;
    
    
    
}

@end

static NSInteger oldClickBtnIndex = 1500;
static NSString *const informationCellIdentifier = @"informationCellIdentifier";
static NSString *const publishStateCellIdentifier = @"publishStateCellIdentifier";

@implementation CheWeiGuanLiVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self setAttributeLeftItem:@"back.png" withMiddleItem:@"车位管理" withRightItem:nil];
    
    [self pageLayout];
    
}
- (void)viewWillAppear:(BOOL)animated
{
    NSString *userId = [[NSUserDefaults standardUserDefaults] objectForKey:@"userUid"];
    if (userId) {
        
    [LTHTTPManager postRequestWithURL:[NSString stringWithFormat:@"%@%@",kHttpDemo,kHttpParkQuery] withParameter:@{@"userId":[[NSUserDefaults standardUserDefaults] objectForKey:@"userUid"]}getData:^(NSMutableDictionary *dictionary, NSError *error) {
        NSLog(@"%@",dictionary);
        
        if ([[dictionary valueForKeyPath:@"code"] isEqualToString:@"0"]) {
            _DataArray = [dictionary valueForKeyPath:@"data.parkList"];
            NSLog(@"DataArray:%@",_DataArray);
            
            [_informationTableView reloadData];
            [_publishStateTableView reloadData];
            
            
        }else {
            if ([[dictionary valueForKeyPath:@"message"] isEqualToString:nil]) {
                LTWXTS(@"信息空");
            }
            LTWXTS([dictionary valueForKeyPath:@"message"] );
        }

    }];
 }
    else
 {
     LoginVC *login = [[LoginVC alloc]init];
     //[self.navigationController pushViewController:login animated:YES];
     [self presentViewController:login animated:YES completion:nil];
     
 }
    
}

#pragma mark -- 导航按钮点击事件
- (void)leftButtonEvent:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)rightButtonEvent:(UIButton *)sender {
    
}

#pragma mark -- 页面布局
- (void)pageLayout {
    //车位信息按钮
    UIButton *informationBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    informationBtn.frame = CGRectMake(0, 64, ScreenW / 2, 40);
    [informationBtn setTitle:@"车位信息" forState:UIControlStateNormal];
    [informationBtn setTitleColor:[self colorWithHexColorString:@"#3293fa"] forState:UIControlStateNormal];
    informationBtn.tag = CarprotInformation;
    [informationBtn addTarget:self action:@selector(carportInformationBtnEvent:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:informationBtn];
    //发布状态按钮
    UIButton *publishStateBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    publishStateBtn.frame = CGRectMake(ScreenW / 2, 64, ScreenW / 2, 40);
    [publishStateBtn setTitle:@"发布状态" forState:UIControlStateNormal];
    [publishStateBtn setTitleColor:[UIColor colorWithRed:0.87 green:0.88 blue:0.88 alpha:1.0] forState:UIControlStateNormal];
    publishStateBtn.tag = PublishState;
    [publishStateBtn addTarget:self action:@selector(carportInformationBtnEvent:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:publishStateBtn];
    //按钮下方蓝线
    UILabel *blueLine = [[UILabel alloc] init];
    blueLine.frame = CGRectMake(0, 104, ScreenW / 2, 1);
    blueLine.backgroundColor = [self colorWithHexColorString:@"#3293fa"];
    [self.view addSubview:blueLine];
    _pointerLine = blueLine;
    
    [self createBackgroundScrollViewAndTableView];
}

#pragma mark -- 车位信息按钮、发布状态按钮点击事件
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
    _backgroundScrollView.contentOffset = CGPointMake(ScreenW * (sender.tag - 1500), 0);
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
    //车位信息表
    UITableView *carportInfo = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, backgroundSV.bounds.size.height) style:UITableViewStylePlain];
    carportInfo.delegate = self;
    carportInfo.dataSource = self;
    carportInfo.tag = InformationTableView;
    carportInfo.separatorStyle = UITableViewCellSeparatorStyleNone;
    carportInfo.showsVerticalScrollIndicator = NO;
    [backgroundSV addSubview:carportInfo];
    _informationTableView=carportInfo;
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        _page = 0;
        //上拉加载刷新
         [self updateData];
    }];
    _informationTableView.mj_header =header;
    header.stateLabel.font = [UIFont systemFontOfSize:12];
    header.lastUpdatedTimeLabel.font = [UIFont systemFontOfSize:14];
    
    MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        //下拉刷新
          [self updateData];
    }];
    
    _informationTableView.mj_footer =footer;
    
    //发布状态表
    _stateImageArr = @[@"yitongguo",@"weitongguo",@"daishenhe"];
    UITableView *publishState = [[UITableView alloc] initWithFrame:CGRectMake(ScreenW, 0, ScreenW, backgroundSV.bounds.size.height) style:UITableViewStylePlain];
    publishState.delegate = self;
    publishState.dataSource = self;
    publishState.tag = PublishStateTableView;
    publishState.separatorStyle = UITableViewCellSeparatorStyleNone;
    [backgroundSV addSubview:publishState];
    _publishStateTableView = publishState;
    
    MJRefreshNormalHeader *publishheader = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        _page = 0;
        //上拉加载刷新
        [self updateDataPublish];
    }];
    _publishStateTableView.mj_header =publishheader ;
    publishheader .stateLabel.font = [UIFont systemFontOfSize:12];
    publishheader .lastUpdatedTimeLabel.font = [UIFont systemFontOfSize:14];
    
    MJRefreshAutoNormalFooter *publishfooter = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        //下拉刷新
        [self updateDataPublish];
    }];
    
    _publishStateTableView.mj_footer =publishfooter;

    
}
//更新视图
- (void)updateinformationView
{
    [_informationTableView reloadData];
    
}
- (void)updatepublishView
{
    [_publishStateTableView reloadData];
    
}
//停止刷新
- (void)endRefreshInformation
{
    [_informationTableView.mj_header endRefreshing];
    [_informationTableView.mj_footer endRefreshing];
    
}
- (void)endRefreshPublish
{
    [_publishStateTableView.mj_header endRefreshing];
    [_publishStateTableView.mj_footer endRefreshing];
}

#pragma Mark --  车位信息更新数据
- (void)updateData
{
    
}

#pragma mark -- 发布信息刷新
- (void)updateDataPublish
{
    
}
#pragma mark -- 表的代理方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _DataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView.tag == InformationTableView) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:informationCellIdentifier];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:informationCellIdentifier];
           }
         for (UIView *subView in cell.contentView.subviews) {
            [subView removeFromSuperview];
          }
            //图片
            UIImageView *carportImage = [[UIImageView alloc] init];
            carportImage.frame = CGRectMake(20, 10, ScreenW - 40, 140);
            carportImage.image = [UIImage imageNamed:@"cheweibg"];
            [cell.contentView addSubview:carportImage];
            //地址
            UILabel *address = [[UILabel alloc] init];
            address.frame = CGRectMake(20, 150, ScreenW - 40, 20);
        
            address.text =[_DataArray[indexPath.row] valueForKeyPath:@"address"];
            address.textColor = [UIColor colorWithRed:0.60 green:0.60 blue:0.61 alpha:1.00];
            address.font = [UIFont systemFontOfSize:15];
            [cell.contentView addSubview:address];
            //编辑
            UILabel *resetEdit = [[UILabel alloc] init];
            resetEdit.frame = CGRectMake(20, 170, 70, 30);
            resetEdit.text = @"重新编辑";
            resetEdit.textColor = [UIColor colorWithRed:0.60 green:0.60 blue:0.61 alpha:1.00];
            resetEdit.font = [UIFont systemFontOfSize:15];
            [cell.contentView addSubview:resetEdit];
            UIButton *resetBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            resetBtn.frame = CGRectMake(90, 170, 30, 30);
            [resetBtn setImage:[UIImage imageNamed:@"bianji"] forState:UIControlStateNormal];
            [resetBtn addTarget:self action:@selector(resetEditBtnEvent:) forControlEvents:UIControlEventTouchUpInside];
            [cell.contentView addSubview:resetBtn];
            //下架
            UILabel *repealLabel = [[UILabel alloc] init];
            repealLabel.frame = CGRectMake(ScreenW - 90, 170, 40, 30);
            repealLabel.text = @"下架";
            repealLabel.textColor = [UIColor colorWithRed:0.60 green:0.60 blue:0.61 alpha:1.00];
            repealLabel.font = [UIFont systemFontOfSize:15];
            [cell.contentView addSubview:repealLabel];
            UIButton *repealBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            repealBtn.frame = CGRectMake(ScreenW - 50, 170, 30, 30);
            [repealBtn setImage:[UIImage imageNamed:@"xiajia"] forState:UIControlStateNormal];
            [repealBtn addTarget:self action:@selector(repealBtnEvent:) forControlEvents:UIControlEventTouchUpInside];
            [cell.contentView addSubview:repealBtn];
          cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:publishStateCellIdentifier];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:publishStateCellIdentifier];
        }
        for (UIView *subView in cell.contentView.subviews) {
            [subView removeFromSuperview];
        }
            //图片
            UIImageView *carportImage = [[UIImageView alloc] init];
            carportImage.frame = CGRectMake(20, 10, 200, 100);
            carportImage.image = [UIImage imageNamed:@"cheweibg"];
            [cell.contentView addSubview:carportImage];
            //通过状态
            UIImageView *tongGuoStateImage = [[UIImageView alloc] init];
            tongGuoStateImage.frame = CGRectMake(ScreenW - 100, 20, 80, 80);
            tongGuoStateImage.image = [UIImage imageNamed:@"yitongguo"];
            [cell.contentView addSubview:tongGuoStateImage];
            //地址
            UILabel *address = [[UILabel alloc] init];
            address.frame = CGRectMake(20, 120, ScreenW - 40, 20);
            //address.text = @"上海市长宁区长宁路1551号地下停车场a2";
            address.text =[_DataArray[indexPath.row] valueForKeyPath:@"address"];
            address.font = [UIFont systemFontOfSize:15];
            [cell.contentView addSubview:address];
            UIButton *publishBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            publishBtn.frame = CGRectMake(20, 140, ScreenW - 40, 40);
            publishBtn.backgroundColor = [self colorWithHexColorString:@"#3293fa"];
            [publishBtn setTitle:@"发布" forState:UIControlStateNormal];
            publishBtn.layer.cornerRadius = 5;
            publishBtn.layer.masksToBounds = YES;
            [publishBtn addTarget:self action:@selector(publish:) forControlEvents:UIControlEventTouchUpInside];
            
            [cell.contentView addSubview:publishBtn];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView.tag == InformationTableView) {
        return 200;
    }else {
        return 180;
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    //车位信息
    if (tableView.tag == InformationTableView) {
        LTCheWeiDetailVC *cheWeiDetail = [[LTCheWeiDetailVC alloc] init];
        cheWeiDetail.view.backgroundColor = [UIColor colorWithRed:0.93 green:0.96 blue:0.96 alpha:1.00];
        
        cheWeiDetail.parkList = _DataArray[indexPath.row];
        NSLog(@"cheWeiDetail.parkList:%@",cheWeiDetail.parkList);
        
        [self.navigationController pushViewController:cheWeiDetail animated:YES];
    }
    //发布状态
    else if(tableView.tag == PublishStateTableView)
    {
        
    }
}

#pragma mark -- 编辑
- (void)resetEditBtnEvent:(UIButton *)sender {
    NSLog(@"编辑");
    
    CheWeiEditorViewController *editor = [[CheWeiEditorViewController alloc]init];
    editor.view.backgroundColor  = [UIColor colorWithRed:0.93 green:0.96 blue:0.96 alpha:1.00];
    
    
    [self.navigationController pushViewController:editor animated:YES];
    
    
    
}
#pragma mark -- 下架
- (void)repealBtnEvent:(UIButton *)sender {
    NSLog(@"下架");
    
}

#pragma mark --发布车位
- (void)publish:(UIButton *)sender
{
    NSLog(@"发布");
    

        
  
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
