//
//  DescribeViewController.h
//  FlashParking
//
//  Created by 张弛 on 16/6/23.
//  Copyright © 2016年 LettingTechnology. All rights reserved.
//

#import "BaseViewController.h"
@protocol sencondelegate <NSObject>

- (void)sendDescribeLabel:(UITextField *)label;


@end

@interface DescribeViewController : BaseViewController

@property(nonatomic,strong)id <sencondelegate >sencondelegate;

@property(nonatomic,strong)NSString *describeString;

@end
