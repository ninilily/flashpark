//
//  SearchResultVC.m
//  FlashParking
//
//  Created by 薄号 on 16/6/17.
//  Copyright © 2016年 LettingTechnology. All rights reserved.
//
//搜索地图
#import "SearchResultVC.h"
#import "CheWeiListVC.h"

@interface SearchResultVC ()<BMKMapViewDelegate,BMKLocationServiceDelegate> {
    BMKMapView* _mapView;
    BMKLocationService *_locService;
}

@end

@implementation SearchResultVC

- (void)viewDidLoad {
    [super viewDidLoad];
    //移除BaseViewControllerswipe手势 手势冲突
    for (UIGestureRecognizer *gesture in self.view.gestureRecognizers) {
        [self.view removeGestureRecognizer:gesture];
    }
    
    
    
    [self setAttributeLeftItem:@"back.png" withMiddleItem:@"租车筛选" withRightItem:@"列表"];
    
    [self pageLayout];
    
}
- (void)viewWillAppear:(BOOL)animated {
    [_mapView viewWillAppear];
    _mapView.delegate = self; // 此处记得不用的时候需要置nil，否则影响内存的释放
    _locService.delegate = self;

}
- (void)viewWillDisappear:(BOOL)animated {
    [_mapView viewWillDisappear];
    _mapView.delegate = nil; // 不用时，置nil
    _locService.delegate = self;

}


#pragma mark -- 导航按钮点击事件
- (void)leftButtonEvent:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)rightButtonEvent:(UIButton *)sender {

    
    CheWeiListVC *list = [[CheWeiListVC alloc] init];
    list.view.backgroundColor = [UIColor colorWithRed:0.93 green:0.96 blue:0.96 alpha:1.00];
    [self.navigationController pushViewController:list animated:YES];
}

#pragma mark -- 页面布局
- (void)pageLayout {
    
    
    [self createBMKMap];
    
    [self currentLocationCenter];
    
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

#pragma mark -- 定位代理
//实现相关delegate 处理位置信息更新
//处理方向变更信息
- (void)didUpdateUserHeading:(BMKUserLocation *)userLocation
{
    //NSLog(@"heading is %@",userLocation.heading);
    //以下_mapView为BMKMapView对象
    [_mapView updateLocationData:userLocation];
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
