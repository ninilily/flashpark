//
//  BaseViewController.m
//  FlashParking
//
//  Created by 薄号 on 16/6/13.
//  Copyright © 2016年 LettingTechnology. All rights reserved.
//
/**
 *  基础页面
 *
 */
#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createMyNavigationController];
    self.view.backgroundColor=[UIColor whiteColor];
    
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    //手势返回
    [self addSwipeGesture];
}

#pragma mark -- 设置导航
- (void)createMyNavigationController {
    _naviBackgroundView = [[UIView alloc] init];
    _naviBackgroundView.backgroundColor = [self colorWithHexColorString:@"#3293fa"];
    
    _naviBackgroundView.frame = CGRectMake(0, 0, ScreenW, 64);
    [self.view addSubview:_naviBackgroundView];
    
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftBtn addTarget:self action:@selector(leftButtonEvent:) forControlEvents:UIControlEventTouchUpInside];
    [_naviBackgroundView addSubview:leftBtn];
    
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightBtn addTarget:self action:@selector(rightButtonEvent:) forControlEvents:UIControlEventTouchUpInside];
    [_naviBackgroundView addSubview:rightBtn];
    
    UILabel *naviTitle = [[UILabel alloc] init];
    naviTitle.textColor = [UIColor whiteColor];
    naviTitle.textAlignment = NSTextAlignmentCenter;
    [_naviBackgroundView addSubview:naviTitle];
    
    _leftButton = leftBtn;
    _rightButton = rightBtn;
    _navigationTitle = naviTitle;
    
}

- (void)setAttributeLeftItem:(NSString *)leftTitle withMiddleItem:(NSString *)middleTitle withRightItem:(NSString *)rightTitle {
    if (!leftTitle && !middleTitle && !rightTitle) {
        return;
    }
    
    if (leftTitle) {
        if ([leftTitle hasSuffix:@".png"] || [leftTitle hasSuffix:@".jpg"]) {
            _leftButton.frame = CGRectMake(10, 27, 30, 30);
            [_leftButton setBackgroundImage:[UIImage imageNamed:leftTitle] forState:UIControlStateNormal];
        }else {
            _leftButton.frame = CGRectMake(10, 27, 30, 30);
            [_leftButton setTitle:leftTitle forState:UIControlStateNormal];
            _leftButton.titleLabel.font = [UIFont systemFontOfSize:20];
        }
    }
    
    if (middleTitle) {
        _navigationTitle.center = CGPointMake(ScreenW / 2, 42);
        _navigationTitle.bounds = CGRectMake(0, 0, 200, 30);
        _navigationTitle.text = middleTitle;
        _navigationTitle.font = [UIFont boldSystemFontOfSize:20];
        if ([middleTitle isEqualToString:@"登入"]) {
            _navigationTitle.font = [UIFont boldSystemFontOfSize:23];
        }
    }
    
    if (rightTitle) {
        if ([rightTitle hasSuffix:@".png"] || [rightTitle hasSuffix:@".jpg"]) {
            _rightButton.frame = CGRectMake(ScreenW - 40, 27, 30, 30);
            [_rightButton setBackgroundImage:[UIImage imageNamed:rightTitle] forState:UIControlStateNormal];
        }else {
            _rightButton.frame = CGRectMake(ScreenW - 60, 27, 50, 30);
            [_rightButton setTitle:rightTitle forState:UIControlStateNormal];
            _rightButton.titleLabel.font = [UIFont systemFontOfSize:20];
        }
    }
}

- (UIColor *)colorWithHexColorString:(NSString *)hexColorString{
    if ([hexColorString length] <6){//长度不合法
        return [UIColor clearColor];
    }
    NSString *tempString=[hexColorString lowercaseString];
    if ([tempString hasPrefix:@"0X"]){//检查开头是0x
        tempString = [tempString substringFromIndex:2];
    }
    else if ([tempString hasPrefix:@"#"]){//检查开头是#
        tempString = [tempString substringFromIndex:1];
    }
    if ([tempString length] != 6){
        return [UIColor clearColor];
    }
    //分解三种颜色的值
    NSRange range;
    range.location = 0;
    range.length = 2;
    
    // r
    NSString *rString = [tempString substringWithRange:range];
    // g
    range.location = 2;
    NSString *gString = [tempString substringWithRange:range];
    // b
    range.location = 4;
    NSString *bString = [tempString substringWithRange:range];
    //取三种颜色值
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString]scanHexInt:&r];
    [[NSScanner scannerWithString:gString]scanHexInt:&g];
    [[NSScanner scannerWithString:bString]scanHexInt:&b];
    return [UIColor colorWithRed:((float) r /255.0f)
                           green:((float) g /255.0f)
                            blue:((float) b /255.0f)
                           alpha:1.0f];
}
#pragma mark -- 手势返回
- (void)addSwipeGesture {
    UISwipeGestureRecognizer *swipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeEvent:)];
    swipe.direction = UISwipeGestureRecognizerDirectionRight;
    [self.view addGestureRecognizer:swipe];
}
- (void)swipeEvent:(UISwipeGestureRecognizer *)sender {
    [self leftButtonEvent:_leftButton];
}

#pragma mark -- 导航按钮点击事件
- (void)leftButtonEvent:(UIButton *)sender {
    
}
- (void)rightButtonEvent:(UIButton *)sender {
    
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
