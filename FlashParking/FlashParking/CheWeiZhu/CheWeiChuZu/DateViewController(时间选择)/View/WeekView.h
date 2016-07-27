//
//  WeekView.h
//  FlashParking
//
//  Created by 张弛 on 16/7/20.
//  Copyright © 2016年 LettingTechnology. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^MyBlock)(NSString *Week,NSString *myStr);

@interface WeekView : UIView

@property (nonatomic, copy) MyBlock block;



@end
