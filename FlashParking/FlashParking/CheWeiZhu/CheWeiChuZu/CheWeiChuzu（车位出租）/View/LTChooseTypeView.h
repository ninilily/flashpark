//
//  LTChooseTypeView.h
//  FlashParking
//
//  Created by 薄号 on 16/7/11.
//  Copyright © 2016年 LettingTechnology. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^MyBlock)(NSString *firstType,NSString *secondType);

@interface LTChooseTypeView : UIView

@property (nonatomic, copy) MyBlock block;

@end
