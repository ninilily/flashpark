//
//  LTDingDanModel.h
//  FlashParking
//
//  Created by 薄号 on 16/6/30.
//  Copyright © 2016年 LettingTechnology. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LTDingDanModel : NSObject

@property (nonatomic, copy) NSString *carPlate;
@property (nonatomic, copy) NSString *enterTime;
@property (nonatomic, copy) NSString *orderId;
@property (nonatomic, copy) NSString *orderName;
@property (nonatomic, copy) NSString *orderStatus;
@property (nonatomic, copy) NSString *price;

+ (instancetype)sharedLTDingDanModel:(NSDictionary *)dictionary;

@end
