//
//  AddressViewController.h
//  FlashParking
//
//  Created by 张弛 on 16/7/25.
//  Copyright © 2016年 LettingTechnology. All rights reserved.
//

#import "BaseViewController.h"



@interface AddressViewController : BaseViewController


@property (nonatomic, copy)void(^sendValueBlock)(NSString *address);


@end
