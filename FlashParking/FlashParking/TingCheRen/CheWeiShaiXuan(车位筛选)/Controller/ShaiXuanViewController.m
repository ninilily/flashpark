//
//  ShaiXuanViewController.m
//  FlashParking
//
//  Created by 薄号 on 16/6/13.
//  Copyright © 2016年 LettingTechnology. All rights reserved.
//

#import "ShaiXuanViewController.h"
#import "SearchResultVC.h"
#import "LTHTTPManager.h"
#import "ParkDetailViewController.h"

@interface ShaiXuanViewController ()<BMKMapViewDelegate,BMKLocationServiceDelegate> {
    BMKMapView* _mapView;
    BMKLocationService *_locService;
    NSArray *_ParkArray;
    UIView *_backgroundV;
    
    NSMutableArray *_annoArr;
}

@end

@implementation ShaiXuanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //移除BaseViewControllerswipe手势 手势冲突
    for (UIGestureRecognizer *gesture in self.view.gestureRecognizers) {
        [self.view removeGestureRecognizer:gesture];
    }
    
    [self setAttributeLeftItem:@"back.png" withMiddleItem:@"租车筛选" withRightItem:@"map.png"];
    
    //创建百度地图
    [self createBMKMap];
    //定位
    [self currentLocationCenter];
    
    //创建搜索按钮
    [self createSearchButton];
    //条件输入框
    [self createConditionInputText];
    
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    [_mapView viewWillAppear];
    _mapView.delegate = self; // 此处记得不用的时候需要置nil，否则影响内存的释放
    _locService.delegate = self;
    
    //设置大头针
    BMKPointAnnotation* annotation = [[BMKPointAnnotation alloc]init];
    CLLocationCoordinate2D coor;
    coor.latitude = 31.22289800;
    coor.longitude = 121.41446500;
    annotation.coordinate = coor;
    annotation.title = @"上海停车场B";
    [_mapView addAnnotation:annotation];
    
    
    
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:YES];
    [_mapView viewWillDisappear];
    _mapView.delegate = nil; // 不用时，置nil
    _locService.delegate = nil;
}

//- (void)addMoreAnnotion
//{
//    [_annoArr removeAllObjects];
//    [_mapView removeAnnotation:_mapView.annotations];
//    for (int i =0; i<10; i++) {
//        
//    }
//    
//}

#pragma mark -- 返回、地图切换
- (void)leftButtonEvent:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)rightButtonEvent:(UIButton *)sender {
    
}

#pragma mark -- 百度地图
- (void)createBMKMap {
    _mapView = [[BMKMapView alloc]initWithFrame:CGRectMake(0, 64, ScreenW, ScreenH - 64)];
    _mapView.zoomLevel = 16;
    _mapView.isSelectedAnnotationViewFront = YES;
    [self.view addSubview:_mapView];
}

#pragma mark -- 定位
- (void)currentLocationCenter {
    _locService = [[BMKLocationService alloc]init];
    //启动LocationService
    [_locService startUserLocationService];
    _mapView.userTrackingMode = BMKUserTrackingModeFollow;//设置定位的状态
    _mapView.showsUserLocation = YES;//显示定位图层
    
    
}
#pragma mark -- 修改大头针样式
- (BMKAnnotationView *)mapView:(BMKMapView *)mapView viewForAnnotation:(id<BMKAnnotation>)annotation {
    if ([annotation isKindOfClass:[BMKPointAnnotation class]]) {
        BMKPinAnnotationView *newAnnotationView = [[BMKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"myAnnotation"];
        newAnnotationView.pinColor = BMKPinAnnotationColorPurple;
       // newAnnotationView.animatesDrop = YES;// 设置该标注点动画显示，商用
        newAnnotationView.image = [UIImage imageNamed:@"geren"];
        
        return newAnnotationView;
        
        
    }
    return nil;
}

#pragma mark -- 点击自定义大头针自定义View
- (void)mapView:(BMKMapView *)mapView didSelectAnnotationView:(BMKAnnotationView *)view
{

    
    UIView *viewDetail =[[UIView alloc]initWithFrame:CGRectMake(10, ScreenH -270, ScreenW -20, 90)];
    viewDetail.backgroundColor=[UIColor whiteColor];
    [[viewDetail layer]setCornerRadius:10];
    [_mapView addSubview:viewDetail];
    
    
    UILabel *nameLabel = [[UILabel alloc]init];
    
    nameLabel.text = @"上海停车场B";
    nameLabel.frame  =CGRectMake(10, 5, 100, 30);
    nameLabel.font  =[UIFont systemFontOfSize:12];
    [viewDetail addSubview:nameLabel];
    
    UILabel *totalLabel =[[UILabel alloc]init];
    totalLabel.text= @"空车位:    30车位";
    totalLabel.font = [UIFont systemFontOfSize:12];
    totalLabel.frame = CGRectMake(10, 35, 100, 30);
    [viewDetail addSubview:totalLabel];
    
    
    UILabel *priceLabel =[[UILabel alloc]init];
    priceLabel.text= @"价格:    10元/小时";
    priceLabel.font=[UIFont systemFontOfSize:12];
    priceLabel.frame = CGRectMake(10, 55 , 100, 30);
    [viewDetail addSubview:priceLabel];
    
    
    UILabel *longLabel=[[UILabel alloc]init];
    longLabel.text = @"857km";
    longLabel.font = [UIFont systemFontOfSize:12];
    longLabel.frame =CGRectMake(ScreenW/2, 5, 40, 30);
    [viewDetail addSubview:longLabel];
    
    
    UIButton *btnDetail=[UIButton buttonWithType:UIButtonTypeSystem];
    [btnDetail setTitle:@"详情>" forState:UIControlStateNormal];
    [btnDetail setTintColor:[UIColor colorWithRed:0.58 green:0.76 blue:0.98 alpha:1.00]];
    btnDetail.frame = CGRectMake(ScreenW/2,20, 40, 40);
    [btnDetail addTarget:self action:@selector(controlToDetail:) forControlEvents:UIControlEventTouchUpInside];
    [viewDetail addSubview:btnDetail];
    
    
    
    UIButton  * navigate =[UIButton buttonWithType:UIButtonTypeSystem];    
    UIImage *daohang=[UIImage imageNamed:@"daohang"];
    daohang=[daohang imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [navigate setImage:daohang forState:UIControlStateNormal];
    
    UIImage *daohang1=[UIImage imageNamed:@"daohang_y"];
    daohang1=[daohang1 imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [navigate setImage:daohang1 forState:UIControlStateHighlighted];
    [navigate  addTarget:self action:@selector(nav:) forControlEvents:UIControlEventTouchUpInside];
    navigate.frame = CGRectMake(ScreenW/2+70, 5, 70, 70);
    [viewDetail addSubview:navigate];
    
    
}




#pragma mark -- 定位代理
//实现相关delegate 处理位置信息更新
//处理方向变更信息
- (void)didUpdateUserHeading:(BMKUserLocation *)userLocation
{
    NSLog(@"heading is %@",userLocation.heading);
    //以下_mapView为BMKMapView对象
    [_mapView updateLocationData:userLocation];
}
//处理位置坐标更新
- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation
{
    NSLog(@"didUpdateUserLocation lat %f,long %f",userLocation.location.coordinate.latitude,userLocation.location.coordinate.longitude);
    //以下_mapView为BMKMapView对象
    //获取附近的停车场

    [LTHTTPManager postRequestWithURL:[NSString stringWithFormat:@"%@%@",kHttpDemo,kHttpNearpark] withParameter:@{@"distance":@"15000",@"price":@"8",@"longitude":[NSString stringWithFormat:@"%f",userLocation.location.coordinate.longitude],@"latitude":[NSString stringWithFormat:@"%f",userLocation.location.coordinate.latitude ]} getData:^(NSMutableDictionary *dictionary, NSError *error) {
           NSLog(@"%@",dictionary);
         if ([[dictionary valueForKeyPath:@"code"] isEqualToString:@"0"]) {
             _ParkArray = [dictionary valueForKeyPath:@"data.parks"];
             NSLog(@"ParkArray:%@",_ParkArray);
             
        }
        
        
    }];
    
    
    [_mapView updateLocationData:userLocation];
}


#pragma mark -- 添加动画Annotation
- (void)addAnimatedAnnotationWithName:(NSString *)name withAddress:(CLLocationCoordinate2D)coor
{
    
    BMKPointAnnotation*animatedAnnotation = [[BMKPointAnnotation alloc]init];
    animatedAnnotation.coordinate = coor;
    animatedAnnotation.title = name;
    [_mapView addAnnotation:animatedAnnotation];
}

#pragma mark -- 条件输入框
- (void)createConditionInputText {
    //背景View
    UIView *backgroundView = [[UIView alloc] init];
    backgroundView.frame = CGRectMake(20, 100, ScreenW - 40, 40);
    backgroundView.backgroundColor = [UIColor whiteColor];
    backgroundView.layer.cornerRadius = 5;
    backgroundView.layer.masksToBounds = YES;
    [self.view addSubview:backgroundView];
    _backgroundV = backgroundView;
    //分隔线
    for (NSInteger i = 0; i < 2; i++) {
        UILabel *separatorLine = [[UILabel alloc] init];
        separatorLine.frame = CGRectMake(20, 40 + 40 * i, ScreenW - 80, 1);
        separatorLine.backgroundColor = [UIColor colorWithRed:0.87 green:0.87 blue:0.86 alpha:1.00];
        [backgroundView addSubview:separatorLine];
    }
    //画圆圈
    for (NSInteger i = 0; i < 3; i++) {
        UIImageView *circleImage = [[UIImageView alloc] init];
        circleImage.frame = CGRectMake(10, 16 + 40 * i, 7, 7);
        circleImage.image = [UIImage imageNamed:(2 == i)?@"yello":@"blue"];
        [backgroundView addSubview:circleImage];
    }
    //停那里
    UITextField *stopWhere = [[UITextField alloc] init];
    stopWhere.frame = CGRectMake(20, 10, ScreenW - 80, 20);
    stopWhere.font = [UIFont systemFontOfSize:12];
    stopWhere.placeholder = @"您要停哪里";
    [backgroundView addSubview:stopWhere];
    //停的时间段
    UITextField *stopTime = [[UITextField alloc] init];
    stopTime.frame = CGRectMake(20, 50, ScreenW - 80, 20);
    stopTime.font = [UIFont systemFontOfSize:12];
    stopTime.placeholder = @"您要停的时间段";
    [backgroundView addSubview:stopTime];
    //停车费用
    UITextField *stopPrice = [[UITextField alloc] init];
    stopPrice.frame = CGRectMake(20, 90, ScreenW - 80, 20);
    stopPrice.font = [UIFont systemFontOfSize:12];
    stopPrice.placeholder = @"您能接受的停车费用（每小时）";
    [stopPrice setValue:[UIColor colorWithRed:0.96 green:0.76 blue:0.47 alpha:1.00] forKeyPath:@"_placeholderLabel.textColor"];
    [backgroundView addSubview:stopPrice];
    //高级按钮
    UIButton *gaoJi = [UIButton buttonWithType:UIButtonTypeCustom];
    gaoJi.frame = CGRectMake(backgroundView.bounds.size.width - 60, 10, 42, 21);
    [gaoJi setBackgroundImage:[UIImage imageNamed:@"gaoji_w"] forState:UIControlStateNormal];
    [gaoJi setBackgroundImage:[UIImage imageNamed:@"gaoji_y"] forState:UIControlStateHighlighted];
    [gaoJi addTarget:self action:@selector(gaoJiBtnEvent:) forControlEvents:UIControlEventTouchUpInside];
    [backgroundView addSubview:gaoJi];
    
}
#pragma mark -- 高级按钮关联事件
- (void)gaoJiBtnEvent:(UIButton *)sender {
    if (40 == _backgroundV.bounds.size.height) {
        [UIView animateWithDuration:0.2 animations:^{
            _backgroundV.frame = CGRectMake(20, 100, ScreenW - 40, 120);
        }];
    }else {
        [UIView animateWithDuration:0.2 animations:^{
            _backgroundV.frame = CGRectMake(20, 100, ScreenW - 40, 40);
        }];
    }
}

#pragma mark -- 搜索按钮
- (void)createSearchButton {

    UIView *bgview =[[UIView alloc]init];
    bgview.center=CGPointMake(ScreenW/2,ScreenH - 50);
    bgview.bounds=CGRectMake(0, 0, ScreenW , 95);
    bgview.backgroundColor=[UIColor colorWithRed:0.93 green:0.96 blue:0.96 alpha:1.0];
    [self.view addSubview:bgview];
    
    
    UIButton *searchButton = [UIButton buttonWithType:UIButtonTypeCustom];
    searchButton.center = CGPointMake(ScreenW / 2, ScreenH - 50);
    searchButton.bounds = CGRectMake(0, 0, ScreenW - 40, 40);
    searchButton.backgroundColor = [UIColor colorWithRed:0.33 green:0.55 blue:0.99 alpha:1.00];
    [searchButton setTitle:@"搜索" forState:UIControlStateNormal];
    [searchButton addTarget:self action:@selector(searchButtonEvent:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:searchButton];
}

#pragma mark -- 进入车位详情
- (void)controlToDetail:(UIButton *)sender
{
    NSLog(@"车位详情");
//    ParkDetailViewController *parkDetail=[[ParkDetailViewController alloc]init];
//   // parkDetail.parkId =
//    [self.navigationController pushViewController:parkDetail animated:YES];
    
}

#pragma mark -- 导航
- (void)nav:(UIButton *)sender
{
    NSLog(@"导航");
    
}
- (void)searchButtonEvent:(UIButton *)sender {
    SearchResultVC *result = [[SearchResultVC alloc] init];
    result.searchCondition = @"传入搜索条件";
    result.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController pushViewController:result animated:YES];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}



- (void)dealloc {
    if (_mapView) {
        _mapView = nil;
    }
    NSLog(@"百度地图页面被释放了");
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
