//
//  DingDanGuanLiVC.h
//  FlashParking
//
//  Created by 薄号 on 16/6/15.
//  Copyright © 2016年 LettingTechnology. All rights reserved.
//

#import "BaseViewController.h"

//左右TableView
typedef enum : NSUInteger {
    UnfinishedTableView = 2000,
    FinishedTableView,
} LTOrderTableView;
//切换订单按钮
typedef enum : NSUInteger {
    UnfinishedOrder = 1600,
    FinishedOrder,
} LTOrderBtn;

@interface DingDanGuanLiVC : BaseViewController

@end
