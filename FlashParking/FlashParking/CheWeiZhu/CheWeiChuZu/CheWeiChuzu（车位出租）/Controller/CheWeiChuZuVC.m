//
//  CheWeiChuZuVC.m
//  FlashParking
//
//  Created by 薄号 on 16/6/15.
//  Copyright © 2016年 LettingTechnology. All rights reserved.
//

#import "CheWeiChuZuVC.h"
#import "DateViewController.h"
#import "GGCustomStepper.h"
#import "DescribeViewController.h"

#import "LTChooseTypeView.h"
#import "AddressViewController.h"
#import "LTHTTPManager.h"

#define LTWXTS(string) UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"温馨提示" message:string preferredStyle:UIAlertControllerStyleAlert];\
UIAlertAction *sure = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];\
[alertController addAction:sure];\
[self presentViewController:alertController animated:YES completion:nil];
@interface CheWeiChuZuVC ()<sencondelegate,timeDelegate,UITextFieldDelegate>
{   //底部轮播
    UIScrollView *_bgScrollView;
    //头视图
    UIImageView *_img;
    //姓名
    UITextField *_nameText;
    //手机号
    UITextField *_numberText;
    //地址
    UITextField *_addressText;
    //出租时间
    UITextField *_dateText;
    //费用(每小时)
    UITextField *_feeText;
    //车位类型
    UITextField *_typeText;
    //车位描述
    UITextField *_describeText;
    //价格
    NSString *_price;
    //类型1
    NSString *_parkType1;
    //类型2
    NSString *_parkType2;
    //出租时间4
    UIView *_view4;
    
    //开始时间
    UILabel *_startTime;
    //结束时间
    UILabel *_endTime;
   //智能托管
    NSString *_switch;
   //周
    UILabel *_week;
    
    //数字周
    NSString *_Mystr;
    
    //地址
    NSString *_address;
    
    
}
@end

@implementation CheWeiChuZuVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setAttributeLeftItem:@"back.png" withMiddleItem:@"审核" withRightItem:nil];
    
    self.view.backgroundColor=[UIColor yellowColor];
    //初始化_switch 
    _switch = @"false";
    //头视图
    [self createBgImg];
    //底部轮播图
    [self  createText];
    //姓名
    [self  createName];
    //手机号
    [self createNum];
    //地址
    [self createAddress];
    //出租时间
    [self createDate];
    //费用小时
    [self createPrice];
    //车位类型
    [self createType];
    //车位描述
    [self createDescribe];
    
   
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:YES];
   
}
#pragma mark -- 导航按钮点击事件
- (void)leftButtonEvent:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)rightButtonEvent:(UIButton *)sender {
    
}
#pragma mark -- 头视图
- (void)createBgImg
{
    _img=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"stu"]];
    _img.frame=CGRectMake(0,64,ScreenW,150);
    [self.view addSubview:_img];
    

    UIButton *camerabtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [camerabtn setBackgroundImage:[UIImage imageNamed:@"camera"] forState:UIControlStateNormal];
    camerabtn.frame = CGRectMake(ScreenW/2-20,50, 40, 40);
    [camerabtn addTarget:self action:@selector(addImage:) forControlEvents:UIControlEventTouchUpInside];
    [_img addSubview:camerabtn];
    
    
    
    UILabel *label=[[UILabel alloc]init];
    label.text=@"请上传真实的停车位图片";
    label.textColor=[UIColor whiteColor];
    label.frame=CGRectMake(ScreenW/2-60, 100, 200 ,40 );
    label.font=[UIFont systemFontOfSize:12];
    [_img addSubview:label];
    
    
}
#pragma mark --  底部轮播图
- (void)createText
{
    _bgScrollView=[[UIScrollView alloc]init];
    _bgScrollView.showsVerticalScrollIndicator=NO;
    _bgScrollView.frame=CGRectMake(0, 214, ScreenW, ScreenH - 64);
    _bgScrollView.contentSize=CGSizeMake(0, ScreenH*2-100);
    _bgScrollView.backgroundColor=[UIColor colorWithRed:0.93 green:0.96 blue:0.96 alpha:1.0];
    [self.view addSubview:_bgScrollView];
    
   
    //智能托管
    UIView *bgView=[[UIView alloc]init];
    bgView.backgroundColor=[UIColor whiteColor];
    bgView.frame=CGRectMake(0, 65*7 + 50, ScreenW,60);
    [_bgScrollView addSubview:bgView];
    
    UILabel *tblabel=[[UILabel alloc]init];
    tblabel.text=@"智能托管";
    tblabel.frame=CGRectMake(10, 20, 150, 20);
    tblabel.font=[UIFont systemFontOfSize:12];
    [bgView addSubview:tblabel];
    
    //提示语
    UILabel *remindLabel=[[UILabel alloc]init];
    remindLabel.text=@"vip专享";
    remindLabel.textColor=[self colorWithHexColorString:@"#3293fa"];
    remindLabel.frame=CGRectMake(ScreenW/2 -40, 20, 150, 20);
    remindLabel.font=[UIFont systemFontOfSize:12];
    [bgView addSubview:remindLabel];
    
    //选择按钮
    UISwitch *lock=[[UISwitch alloc]init];
    lock.frame= CGRectMake(ScreenW -70, 15, 100, 20);
    lock.onTintColor=[UIColor colorWithRed:0.17 green:0.71 blue:0.78 alpha:1.0];
    [lock addTarget:self action:@selector(lock:) forControlEvents:UIControlEventValueChanged];
    [bgView addSubview:lock];
    
    //审核按钮
    UIButton *btn=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    btn.frame=CGRectMake(10, 65*7 + 130, ScreenW-20,60);
    [btn setBackgroundColor:[self colorWithHexColorString:@"#3293fa"]];
    [btn addTarget:self action:@selector(cheweizhuxinxi:) forControlEvents:UIControlEventTouchUpInside];
    [btn setTitle:@"审核" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_bgScrollView addSubview:btn];
    
    
}
#pragma mark --智能托管开启提示
- (void)lock:(UISwitch *)sender {
    NSLog(@"智能托管%d",sender.isOn);
    
    if (sender.isOn) {
        _switch = @"true";
        LTWXTS(@"智能托管已开启")
    }else {
        _switch = @"false";
        
        LTWXTS(@"智能托管已取消")
    }
}
#pragma mark --姓名
- (void)createName
{
    UIView *view1 = [[UIView alloc]init];
    view1.backgroundColor=[UIColor whiteColor];
    view1.center=CGPointMake(ScreenW/2, _img.frame.origin.y);
    view1.bounds=CGRectMake(0, 0, ScreenW,60);
    [_bgScrollView addSubview:view1];
    
    UILabel *nameLabel = [[UILabel alloc] init];
    nameLabel.frame = CGRectMake(10, 20, 150, 20);
    nameLabel.text = @"姓名";
    nameLabel.font=[UIFont systemFontOfSize:12];
    [view1 addSubview:nameLabel];
    
    UIImageView *arrowImage = [[UIImageView alloc] init];
    arrowImage.frame = CGRectMake(ScreenW - 30, 20, 8, 15);
    arrowImage.image = [UIImage imageNamed:@"jiantou"];
    [view1 addSubview:arrowImage];
    
    
    _nameText=[[UITextField alloc]init];
    _nameText.placeholder=@"未填写";
    _nameText.font=[UIFont systemFontOfSize:12];
    _nameText.frame=CGRectMake(ScreenW -90, 20, 150, 20);
    _nameText.delegate=self;
    
    [view1 addSubview:_nameText];
    
}
#pragma mark -- 手机号
- (void)createNum
{
    UIView *view2 = [[UIView alloc]init];
    view2.backgroundColor=[UIColor whiteColor];
    view2.center=CGPointMake(ScreenW/2 , _img.frame.origin.y +65 );
    view2.bounds=CGRectMake(0, 0, ScreenW,60);
    [_bgScrollView addSubview:view2];
    
    UILabel *nameLabel = [[UILabel alloc] init];
    nameLabel.frame = CGRectMake(10, 20, 150, 20);
    nameLabel.text = @"手机号";
    nameLabel.font=[UIFont systemFontOfSize:12];
    [view2 addSubview:nameLabel];
    
    UIImageView *arrowImage = [[UIImageView alloc] init];
    arrowImage.frame = CGRectMake(ScreenW - 30, 20, 8, 15);
    arrowImage.image = [UIImage imageNamed:@"jiantou"];
    [view2 addSubview:arrowImage];
    
    
    _numberText=[[UITextField alloc]init];
    _numberText.placeholder=@"未填写";
    _numberText.font=[UIFont systemFontOfSize:12];
    _numberText.keyboardType = UIKeyboardTypeNumberPad;
    _numberText.textAlignment = NSTextAlignmentLeft;
    _numberText.clearButtonMode = UITextFieldViewModeWhileEditing;
    _numberText.frame=CGRectMake(ScreenW -100, 20, 110, 20);
    _numberText.delegate=self;
    
    [view2 addSubview:_numberText];
    
}
#pragma mark -- 地址
- (void)createAddress
{
    UIView *view3 = [[UIView alloc]init];
    view3.backgroundColor=[UIColor whiteColor];
    view3.center=CGPointMake(ScreenW/2 , _img.frame.origin.y +65 *2);
    view3.bounds=CGRectMake(0, 0, ScreenW,60);
    [_bgScrollView addSubview:view3];
    
    UILabel *nameLabel = [[UILabel alloc] init];
    nameLabel.frame = CGRectMake(10, 20, 150, 20);
    nameLabel.text = @"地址";
    nameLabel.font=[UIFont systemFontOfSize:12];
    [view3 addSubview:nameLabel];
    
    UIImageView *arrowImage = [[UIImageView alloc] init];
    arrowImage.frame = CGRectMake(ScreenW - 30, 20, 8, 15);
    arrowImage.image = [UIImage imageNamed:@"jiantou"];
    [view3 addSubview:arrowImage];
    
    
    _addressText=[[UITextField alloc]init];
    _addressText.placeholder=@"未填写";
    _addressText.font=[UIFont systemFontOfSize:12];
    _addressText.textAlignment = NSTextAlignmentRight;
    _addressText.frame=CGRectMake(ScreenW -200, 20, 150, 20);
    _addressText.delegate=self;
    
    [view3 addSubview:_addressText];
    
    UIButton *AddButton = [UIButton buttonWithType:UIButtonTypeCustom];
    AddButton.center=CGPointMake(ScreenW/2 , _img.frame.origin.y +65 *2);
    AddButton.bounds=CGRectMake(0, 0, ScreenW,60);
    [AddButton addTarget:self action:@selector(createAddress:) forControlEvents:UIControlEventTouchUpInside];
    [_bgScrollView addSubview:AddButton];
    
       
}
#pragma mark  --出租时间
- (void)createDate
{
    _view4 = [[UIView alloc]init];
    _view4.backgroundColor=[UIColor whiteColor];
    _view4.center=CGPointMake(ScreenW/2 , _img.frame.origin.y +65 *3);
    _view4.bounds=CGRectMake(0, 0, ScreenW,60);
    [_bgScrollView addSubview:_view4];
    
    UILabel *nameLabel = [[UILabel alloc] init];
    nameLabel.frame = CGRectMake(10, 20, 150, 20);
    nameLabel.text = @"出租时间";
    nameLabel.font=[UIFont systemFontOfSize:12];
    [_view4 addSubview:nameLabel];
    
    UIImageView *arrowImage = [[UIImageView alloc] init];
    arrowImage.frame = CGRectMake(ScreenW - 30, 20, 8, 15);
    arrowImage.image = [UIImage imageNamed:@"jiantou"];
    [_view4 addSubview:arrowImage];
    
    
    _dateText=[[UITextField alloc]init];
    if (_startTime.text.length&&_endTime.text.length) {
        _dateText.hidden=YES;
        
        
    }
    _dateText.textAlignment=UITextAlignmentRight;
    _dateText.font=[UIFont systemFontOfSize:12];
    _dateText.frame=CGRectMake(ScreenW -250, 20, 200, 20);
    _dateText.delegate=self;
    [_view4 addSubview:_dateText];
    
    UIButton *DateButton = [UIButton buttonWithType:UIButtonTypeCustom];
    DateButton.center=CGPointMake(ScreenW/2 , _img.frame.origin.y +65 *3);
    DateButton.bounds=CGRectMake(0, 0, ScreenW,60);
    [DateButton addTarget:self action:@selector(createDate:) forControlEvents:UIControlEventTouchUpInside];
    [_bgScrollView addSubview:DateButton];
    
    
    
    
}

#pragma mark --费用每小时
-(void)createPrice
{
    UIView *view5 = [[UIView alloc]init];
    view5.backgroundColor=[UIColor whiteColor];
    view5.center=CGPointMake(ScreenW/2 , _img.frame.origin.y +65 *4);
    view5.bounds=CGRectMake(0, 0, ScreenW,60);
    [_bgScrollView addSubview:view5];
    
    UILabel *nameLabel = [[UILabel alloc] init];
    nameLabel.frame = CGRectMake(10, 20, 150, 20);
    nameLabel.text = @"费用(每小时)";
    nameLabel.font=[UIFont systemFontOfSize:12];
    [view5 addSubview:nameLabel];
    
   
    
    GGCustomStepper *stepper =[[GGCustomStepper alloc]initWithFrame:CGRectMake(ScreenW -100, 20, 60, 20)];
    stepper.autorepeat=YES;
    stepper.minimumValue=0;
    stepper.maximumValue=20;
    stepper.stepValue=1.0;
    [stepper setIncrementImage:[UIImage imageNamed:@"jia"] forState:UIControlStateNormal];
    [stepper setDecrementImage:[UIImage imageNamed:@"jian"] forState:UIControlStateNormal];
    [stepper setBackgroundImageWithColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [view5 addSubview:stepper];
    
    UILabel *priceLabel=[[UILabel alloc]init];
    priceLabel.text=@"元/小时";
    priceLabel.font=[UIFont systemFontOfSize:14];
    priceLabel.frame= CGRectMake(ScreenW -45, 20, 100, 20);
    [view5 addSubview:priceLabel];
    
    stepper.valueChange=^(double oldValue,double newValue)
    {
        NSLog(@"block :oldValue --%0.f ,newValue -- %0.f",oldValue,newValue);
        _price=[NSString stringWithFormat:@"%0.f",newValue];
        
        
    };
    
    
}
#pragma mark -- 车位类型
- (void)createType
{
    UIView *view6 = [[UIView alloc]init];
    view6.backgroundColor=[UIColor whiteColor];
    view6.center=CGPointMake(ScreenW/2 , _img.frame.origin.y +65 *5);
    view6.bounds=CGRectMake(0, 0, ScreenW,60);
    [_bgScrollView addSubview:view6];
    
    UILabel *nameLabel = [[UILabel alloc] init];
    nameLabel.frame = CGRectMake(10, 20, 150, 20);
    nameLabel.text = @"车位类型";
    nameLabel.font=[UIFont systemFontOfSize:12];
    [view6 addSubview:nameLabel];
    
    UIImageView *arrowImage = [[UIImageView alloc] init];
    arrowImage.frame = CGRectMake(ScreenW - 30, 20, 8, 15);
    arrowImage.image = [UIImage imageNamed:@"jiantou"];
    [view6 addSubview:arrowImage];
    
    
    _typeText=[[UITextField alloc]init];
    _typeText.placeholder=@"请选择";
    _typeText.font=[UIFont systemFontOfSize:12];
    _typeText.textAlignment=UITextAlignmentRight;
    _typeText.frame=CGRectMake(ScreenW -150, 20, 100, 20);
    _typeText.delegate=self;
    
    [view6 addSubview:_typeText];
    
    UIButton *typeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    typeButton.center=CGPointMake(ScreenW/2 , _img.frame.origin.y +65 *5);
    typeButton.bounds=CGRectMake(0, 0, ScreenW,60);
    [typeButton addTarget:self action:@selector(createtype:) forControlEvents:UIControlEventTouchUpInside];
    [_bgScrollView addSubview:typeButton];
    
    
    
    
}
#pragma mark -- 车位描述
- (void)createDescribe
{
    UIView *view7 = [[UIView alloc]init];
    view7.backgroundColor=[UIColor whiteColor];
    view7.center=CGPointMake(ScreenW/2 , _img.frame.origin.y +65 *6 );
    view7.bounds=CGRectMake(0, 0, ScreenW,60);
    [_bgScrollView addSubview:view7];
    
    UILabel *nameLabel = [[UILabel alloc] init];
    nameLabel.frame = CGRectMake(10, 20, 150, 20);
    nameLabel.text = @"车位描述(20个字以内)";
    nameLabel.font=[UIFont systemFontOfSize:12];
    [view7 addSubview:nameLabel];
    
    UIImageView *arrowImage = [[UIImageView alloc] init];
    arrowImage.frame = CGRectMake(ScreenW - 30, 20, 8, 15);
    arrowImage.image = [UIImage imageNamed:@"jiantou"];
    [view7 addSubview:arrowImage];
    
    
    _describeText=[[UITextField alloc]init];
    _describeText.placeholder=@"未填写";
    _describeText.font=[UIFont systemFontOfSize:12];
    _describeText.frame=CGRectMake(ScreenW -90, 20, 150, 20);
    [view7 addSubview:_describeText];
    _describeText.delegate=self;
    
    DescribeViewController *decribe=[[DescribeViewController alloc]init];
    _describeText.text=decribe.describeString;
    UIButton *DescribeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    DescribeButton.center=CGPointMake(ScreenW/2 , _img.frame.origin.y +65 *6);
    DescribeButton.bounds=CGRectMake(0, 0, ScreenW,60);
    [DescribeButton addTarget:self action:@selector(createDescribe:) forControlEvents:UIControlEventTouchUpInside];
    [_bgScrollView addSubview:DescribeButton];
    
    
}


#pragma mark-- 添加车位上传
- (void)cheweizhuxinxi:(UIButton *)btn
{
    if (_addressText.text.length&&_numberText.text.length&&_startTime.text.length&&_endTime.text.length&&_nameText.text.length) {
        
    
    [LTHTTPManager postRequestWithURL:[NSString stringWithFormat:@"%@%@",kHttpDemo,kHttpParkAdd] withParameter:@{@"park_longitude":[[NSUserDefaults standardUserDefaults] objectForKey:@"longitude"],@"park_latitude":[[NSUserDefaults standardUserDefaults] objectForKey:@"latitude"],@"userId":[[NSUserDefaults standardUserDefaults] objectForKey:@"userUid"],@"name":_nameText.text,@"mobileNo":_numberText.text,@"address":_addressText.text,@"beginTime":_startTime.text,@"endTime":_endTime.text,@"price":_price,@"parkType":_parkType1,@"parkType2":_parkType2,@"isTrust":_switch,@"week":_Mystr} getData:^(NSMutableDictionary *dictionary, NSError *error) {
            NSLog(@"%@",dictionary);
            
            if ([[dictionary valueForKeyPath:@"code"] isEqualToString:@"0"]) {
                 LTWXBACK(@"上传成功");
                
                [[NSUserDefaults standardUserDefaults]setObject:_nameText.text forKey:@"name"];
                [[NSUserDefaults standardUserDefaults]setObject:_numberText.text forKey:@"number"];
                [[NSUserDefaults standardUserDefaults]setObject:_addressText.text forKey:@"address"];
                [[NSUserDefaults standardUserDefaults]setObject:_startTime.text forKey:@"statTime"];
                [[NSUserDefaults standardUserDefaults]setObject:_endTime.text forKey:@"endTime"];
                [[NSUserDefaults standardUserDefaults]setObject:_price forKey:@"price"];
                [[NSUserDefaults standardUserDefaults]setObject:_parkType1 forKey:@"parkType1"];
                [[NSUserDefaults standardUserDefaults]setObject:_parkType2 forKey:@"parkType2"];
                [[NSUserDefaults standardUserDefaults]setObject:_week forKey:@"week"];
                
                [[NSUserDefaults standardUserDefaults]synchronize];
                
                
                
            }else {
                LTWXTS([dictionary valueForKeyPath:@"message"]);
            }

            
        
        }];
    }else
    {
        LTWXTS(@"信息填写完整");
    }

    
}

#pragma mark --出租时间选择
- (void)createDate:(UIButton *)btn
{
    
    DateViewController  *date=[[DateViewController alloc]init];
    date.view.backgroundColor=[UIColor colorWithRed:0.93 green:0.96 blue:0.96 alpha:1.00];
    date.timedelegate=self;

    [self.navigationController pushViewController:date animated:YES];
}
#pragma mark  --出租时间代理
- (void)sendStartTime:(NSString *)Starttimestring
{

    _startTime=[[UILabel alloc]initWithFrame:CGRectMake(ScreenW -80, 10, 100, 20)];
    _startTime.text=Starttimestring;
    _startTime.font=[UIFont systemFontOfSize:12];
    [_view4 addSubview:_startTime];

}
- (void)sendEndTime:(NSString *)endTime
{
    
    _endTime=[[UILabel alloc]initWithFrame:CGRectMake(ScreenW -80, 30, 100, 20)];
    _endTime.text=endTime;
    _endTime.font=[UIFont systemFontOfSize:12];
    [_view4 addSubview:_endTime];
}

- (void)sendWeek:(NSString *)week
{
    _week =[[UILabel alloc]init];
    _week.text = week;
    if ([_week.text isEqualToString:@"工作日"]&&[_week.text isEqualToString:@"周末"]&&[_week.text isEqualToString:@"每天"]) {
        _week.frame = CGRectMake(ScreenW - 100, 10, 40, 20);
        
    }
    else{
        _week.frame = CGRectMake(ScreenW -200, 10, 200, 20);
        
    }
    _week.font = [UIFont systemFontOfSize:12];
    [_view4 addSubview:_week];
    
}
//数字周
- (void)sendMystr:(NSString *)Mystr
{
    _Mystr =Mystr;
    
}

#pragma mark --车位类型
- (void)createtype:(UIButton *)btn
{
    NSLog(@"车位类型");
    LTChooseTypeView *view = [[LTChooseTypeView alloc] initWithFrame:CGRectMake(0, 64, ScreenW, ScreenH - 64)];
    
    view.block = ^(NSString *firstType,NSString *secondType) {
        _typeText.text = [NSString stringWithFormat:@"%@%@",firstType,secondType];
        _parkType1=[NSString stringWithFormat:@"%@",firstType];//固定车位 临时车位 产权车位
        
        _parkType2=[NSString stringWithFormat:@"%@",secondType];//地上车位  地下车位
        if ([_parkType1 isEqualToString:@"固定车位"]) {
            _parkType1 = @"2";

        }
        else if([_parkType1 isEqualToString:@"临时车位"])
        {
            _parkType1 = @"3";
        }
        else if ([_parkType1 isEqualToString:@"产权车位"])
        {
            _parkType1= @"1";
            
        }
        
        
        if ([_parkType2  isEqualToString:@"地上车位"]) {
            _parkType2 = @"O";
        }
        else if([_parkType2 isEqualToString:@"地下车位"])
        {
            _parkType2 = @"I";
        }
        else
        {
            _parkType2 = @"H";
            
        }
        NSLog(@"%@",[NSString stringWithFormat:@"%@%@",firstType,secondType]);
    };
    [self.view addSubview:view];
}

#pragma mark --车位描述
- (void)createDescribe:(UIButton *)btn
{
    NSLog(@"车位描述");
    DescribeViewController *describe=[[DescribeViewController alloc]init];
    describe.view.backgroundColor=[UIColor whiteColor];
    describe.sencondelegate=self;
    
    [self.navigationController pushViewController:describe animated:YES];
    
}
#pragma mark --车位描述代理方法
- (void)sendDescribeLabel:(NSString *)textString
{
    _describeText.text=textString;
    
}

#pragma mark --头视图照片添加
- (void)addImage:(UIButton *)sender
{
    NSLog(@"上传照片");
    
}
#pragma mark --地址上传
- (void)createAddress:(UIButton *)sender
{
    AddressViewController *address=[[AddressViewController alloc]init];
    address.view.backgroundColor=[UIColor whiteColor];
    [address setSendValueBlock:^(NSString *string) {
        _addressText.text = string;
        
    }];
    
    [self.navigationController pushViewController:address animated:YES];
    
}




#pragma mark --UItextField 键盘隐藏
-  (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if ((textField=_nameText)&&(textField=_addressText)&&(textField==_numberText)&&(textField==_dateText)&&(textField==_typeText)&&(textField==_describeText)) {
        [textField resignFirstResponder];
        
    }
    return YES;
    
}

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
