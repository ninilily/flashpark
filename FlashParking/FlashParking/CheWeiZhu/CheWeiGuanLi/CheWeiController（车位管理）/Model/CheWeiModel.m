
//
//  CheWeiModel.m
//  FlashParking
//
//  Created by 张弛 on 16/7/19.
//  Copyright © 2016年 LettingTechnology. All rights reserved.
//

#import "CheWeiModel.h"

@implementation CheWeiModel
- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    if (self) {
        
    }
    return self;
}

+ (instancetype)sharedLTDingDanModel:(NSDictionary *)dictionary {
    return [[self alloc] initWithDictionary:dictionary];
}

@end
