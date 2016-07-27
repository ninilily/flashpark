//
//  CheLiangTianJiaVC.m
//  FlashParking
//
//  Created by 薄号 on 16/6/24.
//  Copyright © 2016年 LettingTechnology. All rights reserved.
//

#import "CheLiangTianJiaVC.h"

@interface CheLiangTianJiaVC () {
    //输入框按钮背景View
    UIView *_carNumView;
    //键盘背景View
    UIView *_keyBoardView;
    //省份键盘
    UIView *_provinceV;
    //数字、字母键盘
    UIView *_englishNumV;
}

@end

static NSInteger selectBtnIndex = -1;

@implementation CheLiangTianJiaVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setAttributeLeftItem:@"back.png" withMiddleItem:@"车辆添加" withRightItem:nil];
    //键盘
    [self createCarNumberInputKeyboard];
    //页面布局
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
    //背景View
    UIView *backgroundView = [[UIView alloc] init];
    backgroundView.frame = CGRectMake(5, 120 * HEIGHTSCALE, ScreenW - 10, 70);
    backgroundView.backgroundColor = [self colorWithHexColorString:@"#3293fa"];
    [self.view addSubview:backgroundView];
    _carNumView = backgroundView;
    //车牌号输入框
    for (NSInteger i = 0; i < 7; i++) {
        UIButton *inputBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        inputBtn.frame = CGRectMake(10 + ((ScreenW - 78) / 7 + 8) * i, (70 - (ScreenW - 78) / 7) / 2, (ScreenW - 78) / 7, (ScreenW - 78) / 7);
        inputBtn.backgroundColor = [UIColor whiteColor];
        [inputBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        inputBtn.tag = i + 1100;
        [inputBtn addTarget:self action:@selector(inputCarNumber:) forControlEvents:UIControlEventTouchUpInside];
        [backgroundView addSubview:inputBtn];
    }
    //圆点
    //提示语
    UILabel *propmtLabel = [[UILabel alloc] init];
    propmtLabel.center = CGPointMake(ScreenW / 2, ScreenH / 2 - 40);
    propmtLabel.bounds = CGRectMake(0, 0, 300, 20);
    propmtLabel.text = @"请输入您正确的车牌号码！";
    propmtLabel.textColor = [self colorWithHexColorString:@"#3293fa"];
    propmtLabel.textAlignment = NSTextAlignmentCenter;
    propmtLabel.font = [UIFont systemFontOfSize:15];
    [self.view addSubview:propmtLabel];
    
    //确定按钮
    UIButton *sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    sureBtn.center = self.view.center;
    sureBtn.bounds = CGRectMake(0, 0, ScreenW - 40, 40 * HEIGHTSCALE);
    
    [sureBtn setBackgroundColor:[self colorWithHexColorString:@"#3293fa"]];
    [sureBtn setTitle:@"确定" forState:UIControlStateNormal];
    
    
//    [sureBtn setBackgroundImage:[UIImage imageNamed:@"queding_w"] forState:UIControlStateNormal];
//    [sureBtn setBackgroundImage:[UIImage imageNamed:@"queding_y"] forState:UIControlStateHighlighted];
    [sureBtn addTarget:self action:@selector(sureBtnEvent:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:sureBtn];
    
}

#pragma mark -- 自定义输入键盘
- (void)createCarNumberInputKeyboard {
    NSArray *provinceArray = @[@"京", @"津", @"渝", @"沪", @"冀", @"晋", @"辽", @"吉", @"黑", @"苏", @"浙", @"皖", @"闽", @"赣", @"鲁", @"豫", @"鄂", @"湘", @"粤", @"琼", @"川", @"贵", @"云", @"陕", @"甘", @"青", @"蒙", @"桂", @"宁", @"新", @"藏", @"台", @"港", @"澳"];
    NSArray *numberArray = @[@"1", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"0", @"Q", @"W", @"E", @"R", @"T", @"Y", @"U", @"I", @"O", @"P", @"A", @"S", @"D", @"F", @"G", @"H", @"J", @"K", @"L", @"Z", @"X", @"C", @"V", @"B", @"N", @"M"];
    UIView *backgrounView = [[UIView alloc] init];
    backgrounView.frame = CGRectMake(0, ScreenH, ScreenW, ScreenH * 0.35);
    [self.view addSubview:backgrounView];
    _keyBoardView = backgrounView;
    //省份键盘
    UIView *province = [[UIView alloc] init];
    province.frame = CGRectMake(0, 0, backgrounView.bounds.size.width, backgrounView.bounds.size.height);
    province.backgroundColor = [UIColor colorWithRed:0.87 green:0.88 blue:0.89 alpha:1.00];
    [backgrounView addSubview:province];
    _provinceV = province;
    for (NSInteger i = 0; i < 34; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        if (i <= 26) {
            btn.frame = CGRectMake(10 + ((province.bounds.size.width - 84) / 9 + 8) * (i%9), 15 + ((province.bounds.size.height - 49) / 4 + 8) * (i/9), (province.bounds.size.width - 84) / 9, (province.bounds.size.height - 49) / 4);
        }else {
            btn.frame = CGRectMake(10 + ((province.bounds.size.width - 84) / 9 + 8) * ((i + 1)%9), 15 + ((province.bounds.size.height - 49) / 4 + 8) * ((i + 1)/9), (province.bounds.size.width - 84) / 9, (province.bounds.size.height - 49) / 4);
        }
        btn.backgroundColor = [UIColor whiteColor];
        [btn setTitle:provinceArray[i] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//        btn.layer.cornerRadius = 5;
//        btn.layer.shadowOffset =  CGSizeMake(1, 1);
//        btn.layer.shadowOpacity = 0.8;
//        btn.layer.shadowColor =  [UIColor blackColor].CGColor;
        btn.tag = 1300 + i;
        [btn addTarget:self action:@selector(inputBtnEvent:) forControlEvents:UIControlEventTouchUpInside];
        [province addSubview:btn];
    }
    
    //英文数字键盘
    UIView *number = [[UIView alloc] init];
    number.frame = CGRectMake(0, 0, backgrounView.bounds.size.width, backgrounView.bounds.size.height);
    number.backgroundColor = [UIColor colorWithRed:0.87 green:0.88 blue:0.89 alpha:1.00];
    [backgrounView addSubview:number];
    _englishNumV = number;
    for (NSInteger i = 0; i < 36; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        if (i <= 19) {
            btn.frame = CGRectMake(10 + ((province.bounds.size.width - 74) / 10 + 6) * (i%10), 15 + ((province.bounds.size.height - 49) / 4 + 8) * (i/10), (province.bounds.size.width - 74) / 10, (province.bounds.size.height - 49) / 4);
        }else if (i <= 28) {
            btn.frame = CGRectMake((province.bounds.size.width - ((province.bounds.size.width - 74) / 10 * 9 + 48)) / 2 + ((province.bounds.size.width - 74) / 10 + 6) * (i%10), 15 + ((province.bounds.size.height - 49) / 4 + 8) * (i/10), (province.bounds.size.width - 74) / 10, (province.bounds.size.height - 49) / 4);
        }else {
            btn.frame = CGRectMake((province.bounds.size.width - ((province.bounds.size.width - 74) / 10 * 7 + 36)) / 2 + ((province.bounds.size.width - 74) / 10 + 6) * ((i + 1)%10), 15 + ((province.bounds.size.height - 49) / 4 + 8) * ((i + 1)/10), (province.bounds.size.width - 74) / 10, (province.bounds.size.height - 49) / 4);
        }
        btn.backgroundColor = [UIColor whiteColor];
        [btn setTitle:numberArray[i] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//        btn.layer.cornerRadius = 5;
//        btn.layer.shadowOffset =  CGSizeMake(1, 1);
//        btn.layer.shadowOpacity = 0.8;
//        btn.layer.shadowColor =  [UIColor blackColor].CGColor;
        btn.tag = 1400 + i;
        [btn addTarget:self action:@selector(inputBtnEvent:) forControlEvents:UIControlEventTouchUpInside];
        [number addSubview:btn];
    }
}

#pragma mark -- 车牌号按钮点击事件
- (void)inputCarNumber:(UIButton *)sender {
    if (selectBtnIndex == sender.tag) {
        return;
    }
    if (!(_keyBoardView.frame.origin.y == ScreenH * 0.65)) {
        [UIView animateWithDuration:0.25 animations:^{
            _keyBoardView.frame = CGRectMake(0, ScreenH * 0.65, ScreenW, ScreenH * 0.35);
        }];
    }
    selectBtnIndex = sender.tag;
    for (NSInteger i = 0; i < 6; i++) {
        UIButton *btn = [_carNumView viewWithTag:1100 + i];
        btn.backgroundColor = [UIColor whiteColor];
    }
    sender.backgroundColor = [UIColor colorWithRed:0.82 green:0.91 blue:0.93 alpha:1.00];
    [_keyBoardView bringSubviewToFront:_englishNumV];
    if (1100 == sender.tag) {
        [_keyBoardView bringSubviewToFront:_provinceV];
    }
}

#pragma mark -- 输入按钮点击事件
- (void)inputBtnEvent:(UIButton *)sender {
    UIButton *currentBtn = [_carNumView viewWithTag:selectBtnIndex];
    [currentBtn setTitle:sender.currentTitle forState:UIControlStateNormal];
    if (selectBtnIndex <= 1105) {
        UIButton *nextBtn = [_carNumView viewWithTag:(selectBtnIndex + 1)];
        [self inputCarNumber:nextBtn];
    }
}

#pragma mark -- 确定按钮点击事件
- (void)sureBtnEvent:(UIButton *)sender {
    //车牌号
    NSMutableString *carNumberStr = [[NSMutableString alloc] init];
    for (NSInteger i = 0; i < 7; i++) {
        UIButton *btn = [_carNumView viewWithTag:i + 1100];
        if (btn.currentTitle) {
            [carNumberStr appendString:btn.currentTitle];
        }
    }
    if (7 == carNumberStr.length) {
        [LTHTTPManager postRequestWithURL:[NSString stringWithFormat:@"%@%@",kHttpDemo,kHttpaddcar] withParameter:@{@"uid":[[NSUserDefaults standardUserDefaults] objectForKey:@"userUid"],@"carPlate":carNumberStr,@"carType":@"C"} getData:^(NSMutableDictionary *dictionary, NSError *error) {
            if ([[dictionary valueForKeyPath:@"code"] isEqualToString:@"0"]) {
                LTWXBACK(@"恭喜添加成功");
            }else {
                LTWXTS([dictionary valueForKeyPath:@"message"]);
            }
        }];
    }else {
        LTWXTS(@"请输入正确车牌号码");
    }
}

#pragma mark -- 键盘收回
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [UIView animateWithDuration:0.25 animations:^{
        _keyBoardView.frame = CGRectMake(0, ScreenH, ScreenW, ScreenH * 0.35);
    }];
    UIButton *select = [_carNumView viewWithTag:selectBtnIndex];
    select.backgroundColor = [UIColor whiteColor];
    selectBtnIndex = -1;
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
