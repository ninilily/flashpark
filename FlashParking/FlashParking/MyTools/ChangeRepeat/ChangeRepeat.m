//
//  ChangeRepeat.m
//  CallWake
//
//  Created by yl-mac1 on 16/2/26.
//  Copyright © 2016年  陆晴. All rights reserved.
//

#import "ChangeRepeat.h"

@implementation ChangeRepeat
+(NSString *)changeRepeat:(NSMutableArray *)repeatArray{
    if ([repeatArray containsObject:@"1"]
        &&[repeatArray containsObject:@"2"]
        &&[repeatArray containsObject:@"3"]
        &&[repeatArray containsObject:@"4"]
        &&[repeatArray containsObject:@"5"]
        &&repeatArray.count == 5) {
        return @"工作日";
    }else if([repeatArray containsObject:@"6"]
             &&[repeatArray containsObject:@"7"]
             &&repeatArray.count == 2){
        return @"周末";
    }else if (repeatArray.count == 7
              &&[repeatArray containsObject:@"1"]
              &&[repeatArray containsObject:@"2"]
              &&[repeatArray containsObject:@"3"]
              &&[repeatArray containsObject:@"4"]
              &&[repeatArray containsObject:@"5"]
              &&[repeatArray containsObject:@"6"]
              &&[repeatArray containsObject:@"7"] ){
        return @"每天";
        
    }
    else{
        NSString * str = [[NSString alloc]init];
        for (int i = 0; i<repeatArray.count; i++) {
            for (int j = 0; j<repeatArray.count-1; j++) {
                if ([repeatArray[j] integerValue]>[repeatArray[j+1] integerValue]) {
                    [repeatArray exchangeObjectAtIndex:j withObjectAtIndex:j+1];
                }
            }
        }
        
        NSLog(@"repeatArray:%@",repeatArray);
        NSString *dayStr = [[NSString alloc]init];
        if ([repeatArray containsObject:@"1"]) {
            dayStr = @"周一";
            str = [str stringByAppendingString:[NSString stringWithFormat:@" %@",dayStr]];

        }
        if ([repeatArray containsObject:@"2"]){
            dayStr = @"周二";
            str = [str stringByAppendingString:[NSString stringWithFormat:@" %@",dayStr]];

        }
        if ([repeatArray containsObject:@"3"]){
            dayStr = @"周三";
            str = [str stringByAppendingString:[NSString stringWithFormat:@" %@",dayStr]];

        }
        if ([repeatArray containsObject:@"4"]){
            dayStr = @"周四";
            str = [str stringByAppendingString:[NSString stringWithFormat:@" %@",dayStr]];

        }
        if ([repeatArray containsObject:@"5"]){
            dayStr = @"周五";
            str = [str stringByAppendingString:[NSString stringWithFormat:@" %@",dayStr]];

        }
        if ([repeatArray containsObject:@"6"]){
            dayStr = @"周六";
            str = [str stringByAppendingString:[NSString stringWithFormat:@" %@",dayStr]];

        }
        if ([repeatArray containsObject:@"7"]){
            dayStr = @"周日";
            str = [str stringByAppendingString:[NSString stringWithFormat:@" %@",dayStr]];

        }
        
       // str= [repeatArray componentsJoinedByString:@","];
        

        return  str;
    }
}
@end
