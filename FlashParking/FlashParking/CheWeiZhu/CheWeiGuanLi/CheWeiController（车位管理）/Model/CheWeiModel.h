//
//  CheWeiModel.h
//  FlashParking
//
//  Created by 张弛 on 16/7/19.
//  Copyright © 2016年 LettingTechnology. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CheWeiModel : NSObject
/**
 * 
 address = 111111;
 beginTime = 19700101001106;
 endTime = 19700101002106;
 parkId = 01fa7878f0461f4557000045;
 price = 8;
 status = V;
 trust = 0;
 userId = u14569636925300528FN;
 
 */
@property (nonatomic, copy) NSString *address;
@property (nonatomic, copy) NSString *beginTime;
@property (nonatomic, copy) NSString *endTime;
@property (nonatomic, copy) NSString *parkId;
@property (nonatomic, copy) NSString *price;
@property (nonatomic, copy) NSString *status;
@property (nonatomic, copy) NSString *trust;
@property (nonatomic, copy) NSString *userId;

+ (instancetype)sharedLTDingDanModel:(NSDictionary *)dictionary;
@end
