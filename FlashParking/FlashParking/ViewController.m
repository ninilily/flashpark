//
//  ViewController.m
//  FlashParking
//
//  Created by 薄号 on 16/6/13.
//  Copyright © 2016年 LettingTechnology. All rights reserved.
//
/**
 *  引导页
 */
#import "ViewController.h"
#import "MainViewController.h"

@interface ViewController ()<UIScrollViewDelegate>
{
    UIScrollView *_yinDaoTuBackground;
    UIPageControl *_pageController;
    
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    // 引导图
    [self yinDaoTuScrollView];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
}

#pragma mark - 引导图
- (void)yinDaoTuScrollView {
    
    NSArray *imageNameArray = [NSArray arrayWithObjects:@"y1",@"y2",@"y3",@"y4", nil];
    
    _yinDaoTuBackground = [[UIScrollView alloc] init];
    _yinDaoTuBackground.frame = CGRectMake(0, -20, ScreenW, ScreenH + 20);
    _yinDaoTuBackground.backgroundColor = [UIColor whiteColor];
    _yinDaoTuBackground.bounces = NO;
    _yinDaoTuBackground.showsHorizontalScrollIndicator = NO;
    _yinDaoTuBackground.pagingEnabled = YES;
    _yinDaoTuBackground.delegate = self;
    [self.view addSubview:_yinDaoTuBackground];
    _yinDaoTuBackground.contentSize = CGSizeMake(ScreenW * imageNameArray.count, 0);
    
    _pageController=[[UIPageControl alloc]init];
    _pageController.currentPageIndicatorTintColor=[UIColor cyanColor];
    _pageController.pageIndicatorTintColor=[UIColor whiteColor];
    _pageController.numberOfPages=4;
    [_pageController addTarget:self action:@selector(scrollView) forControlEvents:UIControlEventValueChanged];
    _pageController.center=CGPointMake(ScreenW / 2, ScreenH - 30);
    [self.view addSubview:_pageController];
    
    
    for (NSInteger i = 0; i < imageNameArray.count; i++) {
        UIImageView *yinDaoTuImage = [[UIImageView alloc] init];
        yinDaoTuImage.frame = CGRectMake(ScreenW * i, 0, ScreenW, ScreenH + 20);
        yinDaoTuImage.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@",imageNameArray[i]]];
        [_yinDaoTuBackground addSubview:yinDaoTuImage];
        
    }
    
    // 开始体验按钮
    UIButton *tiYanBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    tiYanBtn.center = CGPointMake(_yinDaoTuBackground.contentSize.width - ScreenW / 2, 500 * HEIGHTSCALE);
    tiYanBtn.bounds = CGRectMake(0, 0, 100, 40);
    [tiYanBtn  setImage:[UIImage imageNamed:@"b-w1"] forState:UIControlStateNormal];
    [tiYanBtn  setImage:[UIImage imageNamed:@"b-d1"] forState:UIControlStateSelected];
    
    [tiYanBtn addTarget:self action:@selector(gotoMainViewController:) forControlEvents:UIControlEventTouchUpInside];
    [_yinDaoTuBackground addSubview:tiYanBtn];
    
}
/**
 *
 跳转主界面
 */
- (void)gotoMainViewController:(UIButton *)sender {

    
    if(self.callback)
    {
        self.callback();
        
    }
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    _pageController.currentPage = scrollView.contentOffset.x/ScreenW;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
