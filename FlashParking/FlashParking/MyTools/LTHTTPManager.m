//
//  LTHTTPManager.m
//  FlashParking
//
//  Created by 薄号 on 16/6/20.
//  Copyright © 2016年 LettingTechnology. All rights reserved.
//

#import "LTHTTPManager.h"

@interface LTHTTPManager () {
    
}

@end

@implementation LTHTTPManager


+ (void)postRequestWithURL:(NSString *)urlStr withParameter:(NSDictionary *)parameter getData:(void(^)(NSMutableDictionary *dictionary,NSError *error))block {
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"NetworkState"] isEqualToString:@"NO"]) {
        LTWLTS(@"请检查网络")
        return;
    }
    
      
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager POST:urlStr parameters:parameter progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (block) {
            block(responseObject,nil);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (block) {
            block(nil,error);
        }
    }];
}

@end
