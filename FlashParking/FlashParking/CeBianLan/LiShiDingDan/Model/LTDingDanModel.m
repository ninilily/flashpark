//
//  LTDingDanModel.m
//  FlashParking
//
//  Created by 薄号 on 16/6/30.
//  Copyright © 2016年 LettingTechnology. All rights reserved.
//

#import "LTDingDanModel.h"

@implementation LTDingDanModel

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
