//
//  CheWeiEditorViewController.m
//  FlashParking
//
//  Created by 张弛 on 16/7/26.
//  Copyright © 2016年 LettingTechnology. All rights reserved.
//

#import "CheWeiEditorViewController.h"
#import "AddressViewController.h"
#import "DateViewController.h"

@interface CheWeiEditorViewController ()
{
    //头视图
    UIImageView *_img;
    //底部轮播
    UIScrollView *_bgScrollView;
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
    //智能托管
    NSString *_switch;
    

}
@end

@implementation CheWeiEditorViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setAttributeLeftItem:@"back.png" withMiddleItem:@"修改车位信息" withRightItem:nil];
    [self playout];
    
}

#pragma mark -- 导航按钮点击事件
- (void)leftButtonEvent:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)rightButtonEvent:(UIButton *)sender {
    
}

#pragma mark -- 页面布局
- (void)playout
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
    
    //发布按钮
    UIButton *btn=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    btn.frame=CGRectMake(10, 65*7 + 130, ScreenW-20,60);
    [btn setBackgroundColor:[self colorWithHexColorString:@"#3293fa"]];
    [btn addTarget:self action:@selector(cheweizhuRegister:) forControlEvents:UIControlEventTouchUpInside];
    [btn setTitle:@"发布" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_bgScrollView addSubview:btn];
   
    //管理按钮
    NSArray *titArr = @[@"姓名",@"手机号",@"地址",@"出租时间",@"费用每小时",@"车位类型",@"车位描述"];
    for (NSInteger i = 0; i < 7; i++) {
        
        [self myCustomButtonBGView:CGPointMake(ScreenW / 2, 60 + 65 * i) withTitle:titArr[i]];
        UIButton *Button = [UIButton buttonWithType:UIButtonTypeCustom];
        Button.center = CGPointMake(ScreenW / 2,  60  + 65 * i);
        Button.bounds = CGRectMake(0, 0, ScreenW, 60);
        Button.tag = i + 2000;
        [Button addTarget:self action:@selector(createTingChe:) forControlEvents:UIControlEventTouchUpInside];
        [_bgScrollView addSubview:Button];
    }

    //姓名
   
        
}
#pragma mark -- 管理按钮
- (void)myCustomButtonBGView:(CGPoint)point  withTitle:(NSString *)title {
    UIView *bgView = [[UIView alloc] init];
    bgView.backgroundColor=[UIColor whiteColor];
    
    bgView.center = CGPointMake(point.x, point.y);
    bgView.bounds = CGRectMake(0, 0, ScreenW, 60);
    [_bgScrollView addSubview:bgView];
    //标题
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.frame = CGRectMake(20, 20, 100, 20);
    titleLabel.text = title;
    titleLabel.font = [UIFont systemFontOfSize:12];
    
    [bgView addSubview:titleLabel];
    //箭头
    UIImageView *arrowImage = [[UIImageView alloc] init];
    arrowImage.frame = CGRectMake(ScreenW - 40, 20, 8, 15);
    arrowImage.image = [UIImage imageNamed:@"jiantou"];
    [bgView addSubview:arrowImage];
    
    
    
}
#pragma mark -- 信息修改
- (void)createTingChe:(UIButton *)sender
{
    switch (sender.tag) {
            //姓名
        case 2000:{
            
            break;
        }
            //手机号
        case 2001:{
            break;
        }
            //地址
        case 2002:
        {
            AddressViewController *address=[[AddressViewController alloc]init];
            [self.navigationController pushViewController:address animated:YES];
            break;
            
        }
            //出租时间
        case 2003:
        {
            DateViewController *date = [[DateViewController alloc]init];
            [self.navigationController pushViewController:date animated:YES];
            break;
            
        }
            //费用每小时
        case 2004:
        {
            break;
        }
            //车位类型
        case 2005:
        {
            break;
        }
            //车位描述
        case 2006:
        {
            break;
        }
            //智能托管
            case 2007:
        {
            break;
            
        }
        default:
            break;
    }
}
//发布
- (void)cheweizhuRegister:(UIButton *)sender
{
    [LTHTTPManager postRequestWithURL:[NSString stringWithFormat:@"%@%@",kHttpDemo,kHttpModify] withParameter:@{@"parkType1":@"O",@"parkType2":@"1",@"name":@"1111",@"mobileNo":@"13758114274",@"address":@"1114",@"beginTime":@"14:11:21",@"endTime":@"14:22:22",@"price":@"4",@"isTrust":@"true",@"userId":@"u14569636925300528FN",@"week":@"1,2,3"} getData:^(NSMutableDictionary *dictionary, NSError *error) {
        
        
        
    }];
    
    
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
