//
//  NNTimeUtil.m
//  NuanNuan_OC
//
//  Created by 忘、 on 16/11/8.
//  Copyright © 2016年 NuanNuan. All rights reserved.
//

#import "NNTimeUtil.h"

@implementation NNTimeUtil

+ (NSString *)timeDealWithFormat:(NSString *)format andTime:(NSInteger)time{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:format];
    NSDate *date =   [NSDate dateWithTimeIntervalSince1970:time];
    return  [formatter stringFromDate:date];
}

+ (NSString *)timeDealWithTimeFromNow:(NSInteger )time {
    NSTimeInterval nowTime = [[NSDate date] timeIntervalSince1970];
    
    if ((nowTime - time) / 3600 > 24 ) {
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"MM-dd HH:mm"];
        NSDate *date =   [NSDate dateWithTimeIntervalSince1970:time];
        return  [formatter stringFromDate:date];
    }else{
        return [NSString stringWithFormat:@"%d分前",(int)(nowTime - time)/60];
    }
    
}

@end
