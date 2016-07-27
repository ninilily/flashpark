//
//  LTHTTPManager.h
//  FlashParking
//
//  Created by 薄号 on 16/6/20.
//  Copyright © 2016年 LettingTechnology. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LTHTTPManager : NSObject

+ (void)postRequestWithURL:(NSString *)urlStr withParameter:(NSDictionary *)parameter getData:(void(^)(NSMutableDictionary *dictionary,NSError *error))block;

@end
