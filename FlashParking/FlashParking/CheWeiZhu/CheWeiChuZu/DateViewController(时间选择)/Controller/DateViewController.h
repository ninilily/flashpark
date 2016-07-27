//
//  DateViewController.h
//  FlashParking
//
//  Created by 张弛 on 16/6/21.
//  Copyright © 2016年 LettingTechnology. All rights reserved.
//

#import "BaseViewController.h"
@protocol timeDelegate <NSObject>

- (void)sendStartTime:(NSString *)Starttimestring;

- (void)sendEndTime:(NSString *)endTime;

- (void)sendWeek:(NSString *)week;

- (void)sendMystr:(NSString *)Mystr;

@end

@interface DateViewController : BaseViewController
@property(nonatomic,strong)id <timeDelegate >timedelegate;




@end
