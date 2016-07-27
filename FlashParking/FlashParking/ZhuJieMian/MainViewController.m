//
//  MainViewController.m
//  FlashParking
//
//  Created by 薄号 on 16/6/13.
//  Copyright © 2016年 LettingTechnology. All rights reserved.
//
/**
 *  主界面
 *
 */

#import "MainViewController.h"
//停车人
#import "ShaiXuanViewController.h"
//车位主
#import "CheWeiChuZuVC.h"
#import "CheWeiGuanLiVC.h"
#import "DingDanGuanLiVC.h"
//侧边栏
#import "GeRenXinXiVC.h"
#import "MyWalletVC.h"
#import "CheLiangGuanLiVC.h"
#import "LiShiDingDanVC.h"
#import "MySetting.h"
#import "LoginVC.h"

#import "HYBStarEvaluationView.h"
#define kCellIdentifier @"cellIdentifier"

static NSString *const CenterCellIdentifier = @"CenterCellIdentifier";
static NSString *const OrderCellIdentifier = @"OrderCellIdentifier";


@interface MainViewController ()<UIScrollViewDelegate,UITableViewDataSource,UITableViewDelegate> {
    UIView *_buttonBackground;
    UIView *_backgroundView;
    UIScrollView *_pageBackgroundSV;
    UISwipeGestureRecognizer *_swipe;
    
    UILabel *_usersName;
}

@end

static CGFloat _oldSenderTag = TingCheRenBtn;
static CGFloat _kParkingOwnerSize = 15;
static UISwipeGestureRecognizerDirection _swipeDirection = UISwipeGestureRecognizerDirectionLeft;

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //移除BaseViewControllerswipe手势 手势冲突
    for (UIGestureRecognizer *gesture in self.view.gestureRecognizers) {
        [self.view removeGestureRecognizer:gesture];
    }
    
    [self setAttributeLeftItem:@"Menu.png" withMiddleItem:nil withRightItem:@"map.png"];
    
    [self pageLayout];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    _usersName.text = [[NSUserDefaults standardUserDefaults] objectForKey:@"phoneNumber"];
}

#pragma mark -- 导航按钮点击事件
- (void)leftButtonEvent:(UIButton *)sender {
//<<<<<<< HEAD
    if (0 != _backgroundView.frame.origin.x) {
        [UIView animateWithDuration:0.2 animations:^{
            _backgroundView.frame = CGRectMake(0, 0,  ScreenW + 200 * WIDTHSCALE, ScreenH);
            self.naviBackgroundView.frame = CGRectMake(200 * WIDTHSCALE, 0, ScreenW, 64);
        } completion:^(BOOL finished) {
            _swipe.direction = UISwipeGestureRecognizerDirectionLeft;
            _pageBackgroundSV.userInteractionEnabled = NO;
            _swipeDirection = UISwipeGestureRecognizerDirectionRight;
        }];
        
    }else {
        [UIView animateWithDuration:0.2 animations:^{
            _backgroundView.frame = CGRectMake(-(200 * WIDTHSCALE), 0,  ScreenW + 200 * WIDTHSCALE, ScreenH);
            self.naviBackgroundView.frame = CGRectMake(0, 0, ScreenW, 64);
        } completion:^(BOOL finished) {
            _swipe.direction = UISwipeGestureRecognizerDirectionRight;
            _pageBackgroundSV.userInteractionEnabled = YES;
            _swipeDirection = UISwipeGestureRecognizerDirectionLeft;
        }];
        
    }
}
- (void)rightButtonEvent:(UIButton *)sender {
    //地图界面
    ShaiXuanViewController *shaiXuan = [[ShaiXuanViewController alloc] init];
    shaiXuan.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController pushViewController:shaiXuan animated:YES];
}

#pragma mark -- 主页面背景手势
- (void)swipeGestureEvent:(UISwipeGestureRecognizer *)swipe {
    if (_swipeDirection == swipe.direction) {
        return;
    }
    [self leftButtonEvent:self.leftButton];
}

#pragma mark -- 页面布局
- (void)pageLayout {
    //侧边栏和主界面的背景视图
    _backgroundView = [[UIView alloc] init];
    _backgroundView.frame = CGRectMake(-(200 * WIDTHSCALE), 0, ScreenW + 200 * WIDTHSCALE, ScreenH);
    [self.view addSubview:_backgroundView];
    [self.view bringSubviewToFront:self.naviBackgroundView];
    _swipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeGestureEvent:)];
    [_backgroundView addGestureRecognizer:_swipe];
    //侧边栏
    [self createCeBianLan];
    //车位主、停车人按钮
    [self createCheWeiAndPeople];
    //背景ScrollView
    [self createpageBackgroundScrollView];
    //停车人
    [self createTingCheRenPage];
    //车位主
    [self createCheWeiZhuPage];
    
}
#pragma mark -- 侧边栏
- (void)createCeBianLan {
    //背景
    UIImageView *ceBianLan = [[UIImageView alloc] init];
    ceBianLan.frame = CGRectMake(0, 0, 200 * WIDTHSCALE, ScreenH);
    ceBianLan.image = [UIImage imageNamed:@"bj"];
    ceBianLan.userInteractionEnabled = YES;
    [_backgroundView addSubview:ceBianLan];
    //头像
    UIImageView *headerImage = [[UIImageView alloc] init];
    headerImage.center = CGPointMake(ceBianLan.bounds.size.width / 2, 80 * HEIGHTSCALE);
    headerImage.bounds = CGRectMake(0, 0, 45 *HEIGHTSCALE, 45 * HEIGHTSCALE);
    headerImage.image = [UIImage imageNamed:@"Person"];
    [ceBianLan addSubview:headerImage];
    //用户名
    UILabel *userName = [[UILabel alloc] init];
    userName.center = CGPointMake(ceBianLan.bounds.size.width / 2, headerImage.center.y + 50 * WIDTHSCALE);
    userName.bounds = CGRectMake(0, 0, 150, 20);
    userName.textAlignment = NSTextAlignmentCenter;
    userName.textColor = [UIColor whiteColor];
    [ceBianLan addSubview:userName];
    _usersName = userName;
    //按钮（透明）
    UIButton *headerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    headerBtn.center = headerImage.center;
    headerBtn.bounds = CGRectMake(0, 0, 45 *HEIGHTSCALE, 45 * HEIGHTSCALE);
    [headerBtn addTarget:self action:@selector(headerBtnEvent:) forControlEvents:UIControlEventTouchUpInside];
    [ceBianLan addSubview:headerBtn];
    
    NSArray *btnArr = @[@"我的钱包",@"车辆管理",@"全部订单",@"设        置"];
    for (NSInteger i = 0; i < 4; i++) {
        UIButton *ceBianBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        ceBianBtn.frame = CGRectMake(0, 150 * HEIGHTSCALE + 50 * i, ceBianLan.bounds.size.width, 40);
        [ceBianBtn setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%ld",i + 1]] forState:UIControlStateNormal];
        ceBianBtn.imageEdgeInsets = UIEdgeInsetsMake(6, 15, 6, 200 - 43);
        [ceBianBtn setTitle:btnArr[i] forState:UIControlStateNormal];
        [ceBianBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
        ceBianBtn.titleEdgeInsets = UIEdgeInsetsMake(10, 10, 10, 60);
        ceBianBtn.tag = 1020 + i;
        [ceBianBtn addTarget:self action:@selector(ceBianLanBtnEvent:) forControlEvents:UIControlEventTouchUpInside];
        [ceBianLan addSubview:ceBianBtn];
    }
    
}
#pragma mark -- 侧边栏按钮点击事件
- (void)ceBianLanBtnEvent:(UIButton *)sender {
    NSString *uid = [[NSUserDefaults standardUserDefaults] objectForKey:@"userUid"];
    NSString *phoneNumber = [[NSUserDefaults standardUserDefaults] objectForKey:@"phoneNumber"];
    NSString *password = [[NSUserDefaults standardUserDefaults] objectForKey:@"passwrod"];
    if (uid && phoneNumber && password) {
        switch (sender.tag) {
            case 1020:{
                MyWalletVC *wallet = [[MyWalletVC alloc] init];
                wallet.view.backgroundColor = [UIColor colorWithRed:0.93 green:0.96 blue:0.96 alpha:1.00];
                [self.navigationController pushViewController:wallet animated:YES];
                break;
            }
            case 1021:{
                CheLiangGuanLiVC *guanLi = [[CheLiangGuanLiVC alloc] init];
                guanLi.view.backgroundColor = [UIColor whiteColor];
                [self.navigationController pushViewController:guanLi animated:YES];
                break;
            }
            case 1022:{
                LiShiDingDanVC *dingDan = [[LiShiDingDanVC alloc] init];
                dingDan.view.backgroundColor = [UIColor whiteColor];
                [self.navigationController pushViewController:dingDan animated:YES];
                break;
            }
            case 1023:{
                MySetting *setting = [[MySetting alloc] init];
                setting.view.backgroundColor = [UIColor colorWithRed:0.93 green:0.96 blue:0.96 alpha:1.00];
                [self.navigationController pushViewController:setting animated:YES];
                break;
            }
            default:
                break;
        }
    }else {
        LoginVC *login = [[LoginVC alloc] init];
        login.view.backgroundColor = [UIColor colorWithRed:0.93 green:0.96 blue:0.96 alpha:1.00];
        [self.navigationController pushViewController:login animated:YES];
    }
}
#pragma mark -- 头像按钮
- (void)headerBtnEvent:(UIButton *)sender {
    NSString *uid = [[NSUserDefaults standardUserDefaults] objectForKey:@"userUid"];
    NSString *phoneNumber = [[NSUserDefaults standardUserDefaults] objectForKey:@"phoneNumber"];
    NSString *password = [[NSUserDefaults standardUserDefaults] objectForKey:@"passwrod"];
    if (uid && phoneNumber && password) {
        GeRenXinXiVC *xinXi = [[GeRenXinXiVC alloc] init];
        xinXi.view.backgroundColor = [UIColor colorWithRed:0.93 green:0.96 blue:0.96 alpha:1.00];
        [self.navigationController pushViewController:xinXi animated:YES];
    }else {
        LoginVC *login = [[LoginVC alloc] init];
        login.view.backgroundColor = [UIColor colorWithRed:0.93 green:0.96 blue:0.96 alpha:1.00];
        [self.navigationController pushViewController:login animated:YES];
    }
    
}

#pragma mark -- 车位主、停车人按钮
- (void)createCheWeiAndPeople {
    _buttonBackground = [[UIView alloc] init];
    _buttonBackground.center = CGPointMake(ScreenW / 2, 42);
    _buttonBackground.bounds = CGRectMake(0, 0, 140 * WIDTHSCALE, 30 * HEIGHTSCALE);
    _buttonBackground.clipsToBounds = YES;
    [self.naviBackgroundView addSubview:_buttonBackground];
    //车位主、停车人按钮
    UIButton *cheWeiZhu = [UIButton buttonWithType:UIButtonTypeCustom];
    cheWeiZhu.frame = CGRectMake(2, 2, _buttonBackground.bounds.size.width / 2 - 2, _buttonBackground.bounds.size.height - 4);
    cheWeiZhu.backgroundColor = [UIColor clearColor];
    [cheWeiZhu setBackgroundImage:[UIImage imageNamed:@"chewei"] forState:UIControlStateNormal];
    cheWeiZhu.tag = CheWeiZhuBtn;
    [cheWeiZhu addTarget:self action:@selector(cheWeiZhuAndTingCheRenEvent:) forControlEvents:UIControlEventTouchUpInside];
    [_buttonBackground addSubview:cheWeiZhu];
    
    UIButton *tingCheRen = [UIButton buttonWithType:UIButtonTypeCustom];
    tingCheRen.frame = CGRectMake(_buttonBackground.bounds.size.width / 2, 2, cheWeiZhu.bounds.size.width, cheWeiZhu.bounds.size.height);
    tingCheRen.backgroundColor = [UIColor clearColor];
    [tingCheRen setBackgroundImage:[UIImage imageNamed:@"tingcheren"] forState:UIControlStateNormal];
    tingCheRen.tag = TingCheRenBtn;
    [tingCheRen addTarget:self action:@selector(cheWeiZhuAndTingCheRenEvent:) forControlEvents:UIControlEventTouchUpInside];
    [_buttonBackground addSubview:tingCheRen];
}

#pragma mark -- 背景ScrollView
- (void)createpageBackgroundScrollView {
    _pageBackgroundSV = [[UIScrollView alloc] init];
    _pageBackgroundSV.frame = CGRectMake(200 * WIDTHSCALE, 64, ScreenW, ScreenH - 64);
    _pageBackgroundSV.pagingEnabled = YES;
    _pageBackgroundSV.showsHorizontalScrollIndicator = NO;
    _pageBackgroundSV.bounces = NO;
    _pageBackgroundSV.scrollEnabled = NO;
    _pageBackgroundSV.backgroundColor=[UIColor colorWithRed:0.93 green:0.96 blue:0.96 alpha:1.0];

    _pageBackgroundSV.contentSize = CGSizeMake(ScreenW * 2, 0);
    [_backgroundView addSubview:_pageBackgroundSV];
    [_backgroundView sendSubviewToBack:_pageBackgroundSV];
    _pageBackgroundSV.contentOffset = CGPointMake(ScreenW, 0);
}

#pragma mark -- 停车人视图
- (void)createTingCheRenPage {
    //首页背景图
    //可能换轮播效果图 点击进入广告页
    UIImageView *img=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"baner"]];
    img.frame=CGRectMake(ScreenW,0,ScreenW,200);
    [_pageBackgroundSV addSubview:img];
    //停车位筛选按钮
    UIButton *searchBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    searchBtn.frame=CGRectMake(ScreenW + 20, 210,ScreenW-40 , 32);
    [searchBtn setBackgroundImage:[UIImage imageNamed:@"search"] forState:UIControlStateNormal];
    [searchBtn setBackgroundImage:[UIImage imageNamed:@"search_y"] forState:UIControlStateHighlighted];
    [searchBtn addTarget:self action:@selector(createCheWei) forControlEvents:UIControlEventTouchUpInside];
    [_pageBackgroundSV addSubview:searchBtn];
    
    
    UITableView *tableView=[[UITableView alloc]initWithFrame:CGRectMake(ScreenW,250,ScreenW,ScreenH - 64-230)];
    tableView.delegate=self;
    tableView.dataSource=self;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_pageBackgroundSV addSubview:tableView];
    
    
}

#pragma mark -- 表的代理方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 11;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 190;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CenterCellIdentifier];
        

            //标题头
            UILabel *label = [[UILabel alloc]init];
        if (indexPath.row==0) {
            label.text = @"最近浏览过的";
            
        }
        else{
             label.text = @"为你推荐的";
        }
        
            label.frame = CGRectMake(10, 5, 120, 20);
            label.textColor=[UIColor colorWithRed:0.50 green:0.50 blue:0.51 alpha:1.00];
            [cell.contentView addSubview:label];
            
            //图片
            UIImageView *headerImage = [[UIImageView alloc] init];
            headerImage.frame = CGRectMake(10, 30, ScreenW-20, 120);
            headerImage.image = [UIImage imageNamed:@"fbbg"];
            [cell.contentView addSubview:headerImage];
            
            UIView *view1= [[UIView alloc]init];
            view1.frame = CGRectMake(0, 80, 70, 20);
            view1.backgroundColor= [UIColor colorWithRed:0.31 green:0.34 blue:0.35 alpha:1.00];
            [headerImage addSubview:view1];
            //价格文字
            UILabel *priceLabel = [[UILabel alloc]init];
            priceLabel.text = @"¥1每小时";
            priceLabel.textColor = [UIColor colorWithRed:0.58 green:0.50 blue:0.29 alpha:1.00];
            priceLabel.frame = CGRectMake(10,2,50, 20);
            priceLabel.font= [UIFont systemFontOfSize:12];
            [view1 addSubview:priceLabel];
            
            //地址文字
            UILabel *addressLable = [[UILabel alloc]init];
            addressLable.text = @"上海市长宁区长宁路1551号地下停车场a2";
            addressLable.textColor = [UIColor colorWithRed:0.50 green:0.50 blue:0.51 alpha:1.00];
            addressLable.font=[UIFont systemFontOfSize:12];
            addressLable.frame = CGRectMake(10,150,230,20);
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
            starViewUnClick.actualScore = 1;
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
        
        
     
    }
    return cell;
}
#pragma mark -- 车位主
- (void)createCheWeiZhuPage {
    //背景图
    UIImageView *tingBJImage = [[UIImageView alloc] init];
    tingBJImage.frame = CGRectMake(0, 0, ScreenW, 200);
    tingBJImage.image = [UIImage imageNamed:@"cheweizhubj"];
    [_pageBackgroundSV addSubview:tingBJImage];
//    //昵称
//    UILabel *nickName = [[UILabel alloc] init];
//    nickName.frame = CGRectMake(20, 130, ScreenW / 2 - 20, 20);
//    nickName.text = @"昵 称 ：";
//    nickName.textColor = [UIColor whiteColor];
//    nickName.font = [UIFont systemFontOfSize:_kParkingOwnerSize];
//    [tingBJImage addSubview:nickName];
//    UILabel *nickNameText = [[UILabel alloc] init];
//    nickNameText.frame = CGRectMake(tingBJImage.bounds.size.width / 2, 130, ScreenW / 2 - 20, 20);
//    nickNameText.textAlignment = NSTextAlignmentRight;
//    nickNameText.textColor = [UIColor whiteColor];
//    nickNameText.font = [UIFont systemFontOfSize:_kParkingOwnerSize];
//    nickNameText.text = @"王大锤";
//    [tingBJImage addSubview:nickNameText];
    //手机号
    UILabel *phoneNumber = [[UILabel alloc] init];
    phoneNumber.frame = CGRectMake(20, 160, ScreenW / 2 - 20, 20);
    phoneNumber.text = @"王 小 姐";
    phoneNumber.textColor = [UIColor whiteColor];
    phoneNumber.font = [UIFont systemFontOfSize:_kParkingOwnerSize];
    [tingBJImage addSubview:phoneNumber];
    
    HYBStarEvaluationView *starView =[[HYBStarEvaluationView alloc]initWithFrame:CGRectMake(ScreenW -110, 160,100 , 20) numberOfStars:5 isVariable:NO];
    starView.actualScore = 3;
    starView.fullScore =5 ;
    starView.isContrainsHalfStar =YES;
    [tingBJImage addSubview:starView];
    
//    
//    UILabel *phoneNumberText = [[UILabel alloc] init];
//    phoneNumberText.frame = CGRectMake(tingBJImage.bounds.size.width / 2, 160, ScreenW / 2 - 20, 20);
//    phoneNumberText.textAlignment = NSTextAlignmentRight;
//    phoneNumberText.textColor = [UIColor whiteColor];
//    phoneNumberText.font = [UIFont systemFontOfSize:_kParkingOwnerSize];
//    phoneNumberText.text = @"13124568754";
//    [tingBJImage addSubview:phoneNumberText];
    //头像
    UIImageView *headerImage = [[UIImageView alloc] init];
    headerImage.center = tingBJImage.center;
    headerImage.bounds = CGRectMake(0, 0, tingBJImage.bounds.size.height * 3 / 5, tingBJImage.bounds.size.height * 3 / 5);
    headerImage.layer.cornerRadius = tingBJImage.bounds.size.height * 3 / 10;
    headerImage.layer.masksToBounds = YES;
    headerImage.image = [UIImage imageNamed:@"touxiang"];
    [tingBJImage addSubview:headerImage];
    //管理按钮
    NSArray *iconArr = @[@"cheweichuzu",@"cheweiguanli",@"dingdanganli"];
    NSArray *titArr = @[@"车位出租",@"车位管理",@"订单管理"];
    for (NSInteger i = 0; i < 3; i++) {
        [self myCustomButtonBGView:CGPointMake(ScreenW / 2, tingBJImage.frame.origin.y + tingBJImage.frame.size.height + 50 + 65 * i) withIcon:iconArr[i] withTitle:titArr[i]];
        UIButton *touMingButton = [UIButton buttonWithType:UIButtonTypeCustom];
        touMingButton.center = CGPointMake(ScreenW / 2, tingBJImage.frame.origin.y + tingBJImage.frame.size.height + 50 + 65 * i);
        touMingButton.bounds = CGRectMake(0, 0, ScreenW, 60);
        touMingButton.tag = i + 1010;
        [touMingButton addTarget:self action:@selector(createTingChe:) forControlEvents:UIControlEventTouchUpInside];
        [_pageBackgroundSV addSubview:touMingButton];
    }
}

#pragma mark ---车位主页面
- (void)createTingChe:(UIButton *)sender
{
    switch (sender.tag) {
        case 1010:{
            CheWeiChuZuVC *chuZu = [[CheWeiChuZuVC alloc] init];
            chuZu.view.backgroundColor = [UIColor whiteColor];
            [self.navigationController pushViewController:chuZu animated:YES];
            break;
        }
        case 1011:{
            CheWeiGuanLiVC *guanLi = [[CheWeiGuanLiVC alloc] init];
            guanLi.view.backgroundColor = [UIColor whiteColor];
            [self.navigationController pushViewController:guanLi animated:YES];
            break;
        }
        case 1012:{
            DingDanGuanLiVC *dingDan = [[DingDanGuanLiVC alloc] init];
            dingDan.view.backgroundColor = [UIColor whiteColor];
            [self.navigationController pushViewController:dingDan animated:YES];
            break;
        }
            
        default:
            break;
    }
}
#pragma mark ---停车人首页
-(void)createCheWei
{
    ShaiXuanViewController *shaiXuan = [[ShaiXuanViewController alloc] init];
    shaiXuan.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController pushViewController:shaiXuan animated:YES];
    
}
#pragma mark -- 车位主、停车人按钮点击事件
- (void)cheWeiZhuAndTingCheRenEvent:(UIButton *)sender {
    if (_oldSenderTag == sender.tag) {
        return;
    }
    
    if (TingCheRenBtn == sender.tag) {
        [sender setBackgroundImage:[UIImage imageNamed:@"tingcheren"] forState:UIControlStateNormal];
        UIButton *cheW = [_buttonBackground viewWithTag:CheWeiZhuBtn];
        [cheW setBackgroundImage:[UIImage imageNamed:@"chewei"] forState:UIControlStateNormal];
        [_pageBackgroundSV setContentOffset:CGPointMake(ScreenW, 0) animated:YES];
        _oldSenderTag = TingCheRenBtn;
    }else {
        [sender setBackgroundImage:[UIImage imageNamed:@"chewei_y"] forState:UIControlStateNormal];
        UIButton *tingC = [_buttonBackground viewWithTag:TingCheRenBtn];
        [tingC setBackgroundImage:[UIImage imageNamed:@"tingcheren_y"] forState:UIControlStateNormal];
        [_pageBackgroundSV setContentOffset:CGPointMake(0, 0) animated:YES];
        _oldSenderTag = CheWeiZhuBtn;
    }
}


#pragma mark -- 管理按钮
- (void)myCustomButtonBGView:(CGPoint)point withIcon:(NSString *)icon withTitle:(NSString *)title {
    UIView *bgView = [[UIView alloc] init];
    bgView.backgroundColor=[UIColor whiteColor];
    
    bgView.center = CGPointMake(point.x, point.y);
    bgView.bounds = CGRectMake(0, 0, ScreenW, 60);
    [_pageBackgroundSV addSubview:bgView];
    //图标
    UIImageView *iconImage = [[UIImageView alloc] init];
    iconImage.frame = CGRectMake(20, 20, 20, 20);
    iconImage.image = [UIImage imageNamed:icon];
    [bgView addSubview:iconImage];
    //标题
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.frame = CGRectMake(60, 20, 100, 20);
    titleLabel.text = title;
    titleLabel.textColor = [UIColor grayColor];
    [bgView addSubview:titleLabel];
    //箭头
    UIImageView *arrowImage = [[UIImageView alloc] init];
    arrowImage.frame = CGRectMake(ScreenW - 40, 20, 8, 15);
    arrowImage.image = [UIImage imageNamed:@"jiantou"];
    [bgView addSubview:arrowImage];
    
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
