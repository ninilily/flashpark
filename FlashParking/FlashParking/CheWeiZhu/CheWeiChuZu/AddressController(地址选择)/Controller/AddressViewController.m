//
//  AddressViewController.m
//  FlashParking
//
//  Created by 张弛 on 16/7/25.
//  Copyright © 2016年 LettingTechnology. All rights reserved.
//

#import "AddressViewController.h"
#import "cityModel.h"
#import "CheWeiChuZuVC.h"

@interface AddressViewController ()<BMKMapViewDelegate,BMKGeoCodeSearchDelegate,BMKLocationServiceDelegate,UITableViewDataSource,UITableViewDelegate,BMKPoiSearchDelegate>
{
    
    BMKPinAnnotationView *newAnnotation;
    
    BMKGeoCodeSearch *_geoCodeSearch;
    
    BMKReverseGeoCodeOption *_reverseGeoCodeOption;
    
    BMKLocationService *_locService;
    
    BMKPoiSearch *_searcher;
    
    
    
}

@property (strong, nonatomic)  BMKMapView *mapView;
@property (strong, nonatomic)  UIButton *mapPin;

@property (strong, nonatomic)  UITableView *cityTableview;

@property(nonatomic,strong)NSMutableArray *cityDataArr;

@property (nonatomic,strong)NSString *address;

@end

@implementation AddressViewController

-(NSMutableArray *)cityDataArr
{
    if (_cityDataArr==nil)
    {
        _cityDataArr=[NSMutableArray arrayWithCapacity:0];
    }
    
    return _cityDataArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
     [self setAttributeLeftItem:@"back.png" withMiddleItem:@"地址选择" withRightItem:@""];
    [self initLocationService];
    
    [self initTableView];
    
    
}
#pragma mark -- 导航按钮点击事件
- (void)leftButtonEvent:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)initTableView
{
    _cityTableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 264, ScreenW, ScreenW -64)];
    _cityTableview.delegate =self;
    _cityTableview.dataSource = self;
    [self.view addSubview:_cityTableview];
    
    
}
#pragma mark  tableView
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.cityDataArr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID=@"cellID";
    UITableViewCell*cell=[tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell==nil)
    {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
    }
    
    cityModel*model=self.cityDataArr[indexPath.row];
    
    cell.textLabel.text=model.name;
    cell.detailTextLabel.text=model.address;
    cell.image =[UIImage imageNamed:@"lanse"];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    _address = [self.cityDataArr[indexPath.row]valueForKey:@"name"];
    NSLog(@"_address%@",_address);
    self.sendValueBlock(_address);
    [self.navigationController popViewControllerAnimated:YES];

}


#pragma mark 初始化地图，定位
-(void)initLocationService
{
    _mapView = [[BMKMapView alloc]initWithFrame:CGRectMake(0, 64, ScreenW, 200)];
    [self.view addSubview:_mapView];
    
    _mapPin = [UIButton buttonWithType:UIButtonTypeSystem];
    _mapPin.center = _mapView.center;
    _mapPin.frame = CGRectMake(100, 50, 30, 40);
    UIImage *img = [UIImage imageNamed:@"lanse"];
    img  = [img imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    [_mapPin setImage:img forState:UIControlStateNormal];
    
    [_mapView addSubview:_mapPin];
    
    [_mapView setMapType:BMKMapTypeStandard];// 地图类型 ->卫星／标准、
    
    _mapView.zoomLevel=17;
    _mapView.delegate=self;
    _mapView.showsUserLocation = YES;
    
    [_mapView bringSubviewToFront:_mapPin];
    
    
    if (_locService==nil) {
        
        _locService = [[BMKLocationService alloc]init];
        
        [_locService setDesiredAccuracy:kCLLocationAccuracyBest];
    }
    
    _locService.delegate = self;
    [_locService startUserLocationService];
    
    
    _mapView.showsUserLocation = NO;//先关闭显示的定位图层
    _mapView.userTrackingMode = BMKUserTrackingModeFollow;//设置定位的状态
    _mapView.showsUserLocation = YES;//显示定位图层
   
    
}
#pragma mark BMKLocationServiceDelegate
- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation
{
    _mapView.showsUserLocation = YES;//显示定位图层
    //设置地图中心为用户经纬度
    [_mapView updateLocationData:userLocation];
    
    [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%f",userLocation.location.coordinate.latitude] forKey:@"latitude"];
    [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%f",userLocation.location.coordinate.longitude] forKey:@"longitude"];
    
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    //    _mapView.centerCoordinate = userLocation.location.coordinate;
    BMKCoordinateRegion region ;//表示范围的结构体
    region.center = _mapView.centerCoordinate;//中心点
    region.span.latitudeDelta = 0.004;//经度范围（设置为0.1表示显示范围为0.2的纬度范围）
    region.span.longitudeDelta = 0.004;//纬度范围
    [_mapView setRegion:region animated:YES];
    
}
#pragma mark BMKMapViewDelegate
- (void)mapView:(BMKMapView *)mapView regionDidChangeAnimated:(BOOL)animated
{
    //屏幕坐标转地图经纬度
    CLLocationCoordinate2D MapCoordinate=[_mapView convertPoint:_mapPin.center toCoordinateFromView:_mapView];
    
    if (_geoCodeSearch==nil) {
        //初始化地理编码类
        _geoCodeSearch = [[BMKGeoCodeSearch alloc]init];
        _geoCodeSearch.delegate = self;
        
    }
    if (_reverseGeoCodeOption==nil) {
        
        //初始化反地理编码类
        _reverseGeoCodeOption= [[BMKReverseGeoCodeOption alloc] init];
    }
    
    //需要逆地理编码的坐标位置
    _reverseGeoCodeOption.reverseGeoPoint =MapCoordinate;
    [_geoCodeSearch reverseGeoCode:_reverseGeoCodeOption];
    
}
#pragma mark BMKGeoCodeSearchDelegate
-(void) onGetReverseGeoCodeResult:(BMKGeoCodeSearch *)searcher result:(BMKReverseGeoCodeResult *)result errorCode:(BMKSearchErrorCode)error
{
    //获取周边用户信息
    if (error==BMK_SEARCH_NO_ERROR) {
        
        [self.cityDataArr removeAllObjects];
        for(BMKPoiInfo *poiInfo in result.poiList)
        {
            cityModel *model=[[cityModel alloc]init];
            model.name=poiInfo.name;
            
            model.address=poiInfo.address;
            
            [self.cityDataArr addObject:model];
            [self.cityTableview reloadData];
        }
    }else{
        
        NSLog(@"BMKSearchErrorCode: %u",error);
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
