//
//  BaseViewController.h
//  FlashParking
//
//  Created by 薄号 on 16/6/13.
//  Copyright © 2016年 LettingTechnology. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseViewController : UIViewController

@property (nonatomic, strong) UIView *naviBackgroundView;

@property (nonatomic, strong) UIButton *leftButton;
@property (nonatomic, strong) UIButton *rightButton;
@property (nonatomic, strong) UILabel *navigationTitle;

- (void)setAttributeLeftItem:(NSString *)leftTitle withMiddleItem:(NSString *)middleTitle withRightItem:(NSString *)rightTitle;
- (UIColor *)colorWithHexColorString:(NSString *)hexColorString;

@end
