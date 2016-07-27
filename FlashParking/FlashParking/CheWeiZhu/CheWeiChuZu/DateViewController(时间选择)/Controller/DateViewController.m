//
//  DateViewController.m
//  FlashParking
//
//  Created by 张弛 on 16/6/21.
//  Copyright © 2016年 LettingTechnology. All rights reserved.
//

#import "DateViewController.h"
#import "RBCustomDatePickerView.h"
#import "FDAlertView.h"
#import "WeekView.h"

@interface DateViewController ()<sendTheValueDelegate>
{
    UITextField *_startTime;
    UITextField *_endTime;
    
    UITextField *_Week;
    
    //周
    NSString *_myStr;
    
    NSString *_start;
    
    NSString *_end;
    
    
}
@end

@implementation DateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setAttributeLeftItem:@"back.png" withMiddleItem:@"" withRightItem:@"保存"];
    //始末时间页面布局
    [self createStartAndEnd];
    
    //出租日期选择
    [self createWeek];
    
    
   
}
#pragma mark -- 导航按钮点击事件
- (void)leftButtonEvent:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)rightButtonEvent:(UIButton *)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
    
    if (self.timedelegate && [self.timedelegate respondsToSelector:@selector(sendStartTime:)]) {
        
        [self.timedelegate sendStartTime:[NSString stringWithFormat:@"%@",_startTime.text]];
        
    }
    
    if (self.timedelegate&&[self.timedelegate respondsToSelector:@selector(sendEndTime:)]) {
        [self.timedelegate sendEndTime:[NSString stringWithFormat:@"%@",_endTime.text]];
    }
    
   
    if (self.timedelegate&&[self.timedelegate respondsToSelector:@selector(sendWeek:)]) {
        
        [self.timedelegate sendWeek:[NSString stringWithFormat:@"%@",_Week.text]];
        
    }
    
    if (self.timedelegate&& [self.timedelegate respondsToSelector:@selector(sendMystr:)]) {
        [self.timedelegate sendMystr:[NSString stringWithFormat:@"%@",_myStr]];
        
    }
    
}
#pragma mark --始末时间页面布局
- (void)createStartAndEnd
{
    UIView *DateView  = [[UIView alloc] init];
    DateView.frame = CGRectMake(0, 100 * HEIGHTSCALE, ScreenW, 101);
    DateView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:DateView];
    
    UIButton *Startbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    Startbtn.frame = CGRectMake(0, 100 * HEIGHTSCALE, ScreenW, 50);
    [Startbtn addTarget:self action:@selector(seletStart:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:Startbtn];
    
    UIButton *Endbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    Endbtn.frame = CGRectMake(0, 130 * HEIGHTSCALE, ScreenW, 50);
    [Endbtn addTarget:self action:@selector(seletEnd:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:Endbtn];
    
    
    //分割线
    UILabel *middleLine = [[UILabel alloc] init];
    middleLine.frame = CGRectMake(20, 51, ScreenW - 40, 1);
    middleLine.backgroundColor = [UIColor colorWithRed:0.89 green:0.89 blue:0.89 alpha:1.00];
    [DateView addSubview:middleLine];
    //起始时间
    UILabel *label1 = [[UILabel alloc]init];
    label1.frame = CGRectMake(20, 20, 100, 20);
    label1.text = @"起始时间";
    [DateView addSubview:label1];
    
    //结束时间
    UILabel *label2 = [[UILabel alloc]init];
    label2.frame = CGRectMake(20, 55, 100, 40);
    label2.text = @"结束时间";
    [DateView addSubview:label2];
    //箭头icon
    for (int i=0; i<2; i++) {
        UIImageView *arrowImage = [[UIImageView alloc] init];
        arrowImage.frame = CGRectMake(ScreenW - 30, i*50+20, 8, 15);
        arrowImage.image = [UIImage imageNamed:@"jiantou"];
        [DateView addSubview:arrowImage];
 
    }
    //起始时间输入
    UITextField *textStart = [[UITextField alloc]init];
    textStart.placeholder = @"未选择";
    textStart.frame = CGRectMake(ScreenW - 100,20 , 100, 20);
    [DateView addSubview:textStart];
    _startTime = textStart;
    
    
    //结束时间输入
    UITextField *textEnd =[[UITextField alloc]init];
    textEnd.placeholder = @"未选择";
    textEnd.frame = CGRectMake(ScreenW -100, 70, 100, 20);
    [DateView addSubview:textEnd];
    _endTime = textEnd;
    
 
}
#pragma mark --出租日期选择
-(void)createWeek
{
    UIView *weekView = [[UIView alloc]init];
    weekView.frame = CGRectMake(0, 230, ScreenW, 50);
    weekView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:weekView];
    
    //出租日期
    UILabel *label1 = [[UILabel alloc]init];
    label1.text = @"出租日期";
    label1.frame = CGRectMake(20, 15, 100, 20);
    [weekView addSubview:label1];
    
    UIImageView *arrowImage = [[UIImageView alloc]init];
    arrowImage.frame = CGRectMake(ScreenW - 30 , 20, 8, 15);
    arrowImage.image = [UIImage imageNamed:@"jiantou"];
    [weekView addSubview:arrowImage];
    
    
    UITextField *textMenu = [[UITextField alloc]init];
    textMenu.placeholder = @"未选择";
    textMenu.frame = CGRectMake(ScreenW - 100,20 , 100, 20);
    [weekView addSubview:textMenu];
    _Week = textMenu;
    
    
    UIButton *WeekButton = [UIButton buttonWithType:UIButtonTypeCustom];
    WeekButton.center=CGPointMake(0 ,230);
    WeekButton.bounds=CGRectMake(0, 0, ScreenW,50);
    [WeekButton addTarget:self action:@selector(createWeek:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:WeekButton];
    
    
}


#pragma mark -- 出租日期选择
- (void)createWeek:(UIButton *)sender
{
    NSLog(@"出租Week");
    
      WeekView *view = [[WeekView alloc] initWithFrame:CGRectMake(0, 64, ScreenW, ScreenH - 64)];
    
      view.block = ^(NSString *Week,NSString *myStr){
        
        _Week.text = [NSString stringWithFormat:@"%@",Week];
          
          _myStr = [NSString stringWithFormat:@"%@",myStr];
          
      };
    [self.view addSubview:view];


    
    
}

#pragma mark -- 起始时间选择
- (void)seletStart:(UIButton *)sender
{
    
    
    FDAlertView *alert = [[FDAlertView alloc] init];
    RBCustomDatePickerView * contentView=[[RBCustomDatePickerView alloc]init];
    contentView.delegate=self;
    contentView.frame = CGRectMake(0, 0, 300, 300);
    alert.contentView = contentView;
    [alert show];
    _startTime.text =_start;
    
    
}

#pragma mark -- 结束时间选择
- (void)seletEnd:(UIButton *)sender
{
    NSLog(@"结束时间");
    
    FDAlertView *alert = [[FDAlertView alloc] init];
    
    RBCustomDatePickerView * contentView=[[RBCustomDatePickerView alloc]init];
    contentView.delegate=self;
    contentView.frame = CGRectMake(0, 0, 300, 300);
    alert.contentView = contentView;
    [alert show];
    _endTime.text = _end;
  
    
    
    
}
#pragma mark -- 获取时间
-(void)getTimeToValue:(NSString *)theTimeStr
{

    
    _start =theTimeStr;
    
    _end = theTimeStr;
    
}




#pragma mark -- 点击空白处空白消失
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
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
