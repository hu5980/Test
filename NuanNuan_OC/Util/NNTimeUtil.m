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

@end
