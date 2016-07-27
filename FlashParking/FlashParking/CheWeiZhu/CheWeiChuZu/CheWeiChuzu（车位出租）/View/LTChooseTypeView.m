//
//  LTChooseTypeView.m
//  FlashParking
//
//  Created by 薄号 on 16/7/11.
//  Copyright © 2016年 LettingTechnology. All rights reserved.
//

#import "LTChooseTypeView.h"

static NSString *firstType = nil;
static NSString *secondType = nil;

@interface LTChooseTypeView () {
    NSArray *_secondTypeArr;
    NSArray *_secondImageArr;
    UIView *_secondView;
    
    NSArray *_firstTypeArr;
    NSArray *_firstImageArr;
    UIView *_firstView;
}

@end

@implementation LTChooseTypeView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        self.opaque = NO;
        
        //第二类型
        _secondTypeArr = @[@"地上车位",@"地下车位"];
        _secondImageArr = @[@"dishang",@"dixia"];
        UIView *secondTypeView = [[UIView alloc] init];
        secondTypeView.center = CGPointMake(frame.size.width / 2, frame.size.height / 2);
        secondTypeView.bounds = CGRectMake(0, 0, ScreenW - 20, 120);
        secondTypeView.backgroundColor = [UIColor whiteColor];
        secondTypeView.opaque = YES;
        [self addSubview:secondTypeView];
        _secondView = secondTypeView;
        for (NSInteger i = 0; i < 2; i++) {
            UIImageView *headerImage = [[UIImageView alloc] init];
            headerImage.frame = CGRectMake(10, 5 + i%2 * 40, 24, 30);
            headerImage.image = [UIImage imageNamed:_secondImageArr[i]];
            [secondTypeView addSubview:headerImage];
            UILabel *titleLabel = [[UILabel alloc] init];
            titleLabel.frame = CGRectMake(50, 10 + i%2 * 40, 80, 20);
            titleLabel.text = _secondTypeArr[i];
            [secondTypeView addSubview:titleLabel];
            UIButton *selectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            selectBtn.frame = CGRectMake(ScreenW - 70, i%2 * 40, 40, 40);
            [selectBtn setImage:[UIImage imageNamed:@"weixuan"] forState:UIControlStateNormal];
            [selectBtn addTarget:self action:@selector(secondTypeBtnEvent:) forControlEvents:UIControlEventTouchUpInside];
            selectBtn.tag = 1600 + i;
            [secondTypeView addSubview:selectBtn];
        }
        UIButton *sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        sureBtn.frame = CGRectMake(0, 80, ScreenW - 20, 40);
        [sureBtn setBackgroundImage:[UIImage imageNamed:@"longbj"] forState:UIControlStateNormal];
        [sureBtn setBackgroundImage:[UIImage imageNamed:@"longbj_y"] forState:UIControlStateHighlighted];
        [sureBtn setTitle:@"确定" forState:UIControlStateNormal];
        [sureBtn addTarget:self action:@selector(sureBtnEvent:) forControlEvents:UIControlEventTouchUpInside];
        [secondTypeView addSubview:sureBtn];
        //第一类型
        _firstTypeArr = @[@"固定车位",@"临时车位",@"产权车位"];
        _firstImageArr = @[@"guding",@"chan",@"linshi"];
        UIView *firstTypeView = [[UIView alloc] init];
        firstTypeView.center = CGPointMake(frame.size.width / 2, frame.size.height / 2);;
        firstTypeView.bounds = CGRectMake(0, 0, ScreenW - 20, 160);
        firstTypeView.backgroundColor = [UIColor whiteColor];
        firstTypeView.opaque = YES;
        [self addSubview:firstTypeView];
        _firstView = firstTypeView;
        for (NSInteger i = 0; i < 3; i++) {
            UIImageView *headerImage = [[UIImageView alloc] init];
            headerImage.frame = CGRectMake(10, 5 + i%3 * 40, 24, 30);
            headerImage.image = [UIImage imageNamed:_firstImageArr[i]];
            [firstTypeView addSubview:headerImage];
            UILabel *titleLabel = [[UILabel alloc] init];
            titleLabel.frame = CGRectMake(50, 10 + i%3 * 40, 80, 20);
            titleLabel.text = _firstTypeArr[i];
            [firstTypeView addSubview:titleLabel];
            UIButton *selectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            selectBtn.frame = CGRectMake(ScreenW - 70, i%3 * 40, 40, 40);
            [selectBtn setImage:[UIImage imageNamed:@"weixuan"] forState:UIControlStateNormal];
            [selectBtn addTarget:self action:@selector(firstTypeBtnEvent:) forControlEvents:UIControlEventTouchUpInside];
            selectBtn.tag = 1700 + i;
            [firstTypeView addSubview:selectBtn];
        }
        UIButton *nextBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        nextBtn.frame = CGRectMake(0, 120, ScreenW - 20, 40);
        [nextBtn setBackgroundImage:[UIImage imageNamed:@"longbj"] forState:UIControlStateNormal];
        [nextBtn setBackgroundImage:[UIImage imageNamed:@"longbj_y"] forState:UIControlStateHighlighted];
        [nextBtn setTitle:@"下一步" forState:UIControlStateNormal];
        [nextBtn addTarget:self action:@selector(nextBtnEvent:) forControlEvents:UIControlEventTouchUpInside];
        [firstTypeView addSubview:nextBtn];
    }
    return self;
}

#pragma mark -- secondView按钮点击事件
- (void)secondTypeBtnEvent:(UIButton *)sender {
    for (NSInteger i = 0; i < 2; i++) {
        UIButton *btn = [_secondView viewWithTag:1600 + i];
        [btn setImage:[UIImage imageNamed:@"weixuan"] forState:UIControlStateNormal];
    }
    [sender setImage:[UIImage imageNamed:@"yixuan"] forState:UIControlStateNormal];
    secondType = _secondTypeArr[sender.tag - 1600];
}

#pragma mark -- 确定按钮
- (void)sureBtnEvent:(UIButton *)sender {
    if (secondType.length) {
        if (self.block) {
            self.block(firstType,secondType);
        }
        [self removeFromSuperview];
    }else {
        LTWLTS(@"请选择车位类型");
        return;
    }
}

#pragma mark -- firstView按钮点击事件
- (void)firstTypeBtnEvent:(UIButton *)sender {
    for (NSInteger i = 0; i < 3; i++) {
        UIButton *btn = [_firstView viewWithTag:1700 + i];
        [btn setImage:[UIImage imageNamed:@"weixuan"] forState:UIControlStateNormal];
    }
    [sender setImage:[UIImage imageNamed:@"yixuan"] forState:UIControlStateNormal];
    firstType = _firstTypeArr[sender.tag - 1700];
}

#pragma mark -- 下一步按钮
- (void)nextBtnEvent:(UIButton *)sender {
    if (firstType.length) {
        [_firstView removeFromSuperview];
    }else {
        LTWLTS(@"请选择车位类型");
        return;
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
