//
//  CheWeiGuanLiVC.h
//  FlashParking
//
//  Created by 薄号 on 16/6/15.
//  Copyright © 2016年 LettingTechnology. All rights reserved.
//

#import "BaseViewController.h"

//左右TableView
typedef enum : NSUInteger {
    InformationTableView = 2000,
    PublishStateTableView,
} LTCarportManagerTableView;
//车位信息、发布状态按钮
typedef enum : NSUInteger {
    CarprotInformation = 1500,
    PublishState,
} LTCarManagerTopBtn;

@interface CheWeiGuanLiVC : BaseViewController

@end
