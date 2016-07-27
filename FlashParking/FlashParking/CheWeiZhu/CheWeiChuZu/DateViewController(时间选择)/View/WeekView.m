//
//  WeekView.m
//  FlashParking
//
//  Created by 张弛 on 16/7/20.
//  Copyright © 2016年 LettingTechnology. All rights reserved.
//

#import "WeekView.h"
static NSString *Week = nil;

static NSString *Mystr = nil;

#import "ChangeRepeat.h"
@interface WeekView () {
    NSArray *_WeekArr;
    UIView *_View;
    
    NSMutableArray *_TimeArray;
    
}
@end

@implementation WeekView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.opaque = NO;
        
        _TimeArray = [[NSMutableArray alloc]init];
        
        _WeekArr = @[@"星期一",@"星期二",@"星期三",@"星期四",@"星期五",@"星期六",@"星期日"];
        UIView  *Weekview = [[UIView alloc]init];
        Weekview.frame = CGRectMake(0, 200, ScreenW, ScreenH);
        
        Weekview.backgroundColor = [UIColor whiteColor];
        [self addSubview:Weekview];
        
        _View = Weekview;
        
        for (NSInteger i=0; i<7; i++) {
            
            UILabel *titleLabel = [[UILabel alloc] init];
            titleLabel.frame = CGRectMake(20,45 + i *40 , 80, 20);
            titleLabel.text = _WeekArr[i];
            titleLabel.tag = 1900 +i;
            
            [_View addSubview:titleLabel];
            
            UIButton *selectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            selectBtn.frame = CGRectMake(ScreenW - 70, 40 + i * 40, 40, 40);
            [selectBtn setImage:[UIImage imageNamed:@"choose_no"] forState:UIControlStateNormal];
            [selectBtn addTarget:self action:@selector(secondTypeBtnEvent:) forControlEvents:UIControlEventTouchUpInside];
            selectBtn.tag = 1800 + i;
            [_View addSubview:selectBtn];
            
        }
        
        for (NSInteger i=0; i<6; i++) {
            UILabel *line  = [[UILabel alloc]init];
            line.backgroundColor = [UIColor colorWithRed:0.88 green:0.88 blue:0.89 alpha:1.00];
            line.frame = CGRectMake(20, (i+2)*40 , ScreenW -40, 1);
            [_View addSubview:line];
            
            
        }
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setImage:[UIImage imageNamed:@"OK"] forState:UIControlStateNormal];
        btn.frame = CGRectMake(ScreenW - 70, 5, 44, 44);
        [btn addTarget:self action:@selector(clickOK:) forControlEvents:UIControlEventTouchUpInside];
        [_View addSubview:btn];
        
    }
    return self;
    
}
#pragma mark -- 选中切换Week

- (void)secondTypeBtnEvent:(UIButton *)sender
{
    
    
    for (int i =0; i<7; i++) {
        if (sender.tag ==1800+i) {
            if (sender.selected == YES) {
                sender.selected = NO;
                UIButton *btn = [_View viewWithTag:1800+i];
                [btn setImage:[UIImage  imageNamed:@"choose_no"] forState:UIControlStateNormal];
                
                UILabel *label = [_View viewWithTag:1900 +i];
                [_TimeArray removeObject:[NSString stringWithFormat:@"%ld",label.tag +1- 1900]];
                
            }else{
                sender.selected = YES;
                UILabel *label = [_View viewWithTag:1900 +i];
                if ([_TimeArray containsObject:label.text]) {
                    break;
                    
                }
              [_TimeArray addObject:[NSString stringWithFormat:@"%ld",label.tag +1 -1900]];
               
                
               [sender setImage:[UIImage imageNamed:@"choose"] forState:UIControlStateNormal];
            }
            
        }
    }
    
    NSLog(@"_TimeArray:%@",_TimeArray);
   
    Mystr = [_TimeArray componentsJoinedByString:@","];
       
    Week = [ChangeRepeat changeRepeat:_TimeArray];
    
    
                  
}

#pragma mark - -确定按钮
- (void)clickOK:(UIButton *)sender
{
    if (Week.length) {
        if (self.block) {
            self.block(Week,Mystr);
        }
        [self removeFromSuperview];
    }
    else
    {
        LTWLTS(@"请选择日期");
        return;

    }
    
   
}


@end
