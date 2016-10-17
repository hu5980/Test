//
//  NNNetRequestClass.m
//  NuanNuan_OC
//
//  Created by 忘、 on 16/10/17.
//  Copyright © 2016年 NuanNuan. All rights reserved.
//

#import "NNNetRequestClass.h"
#import "AFNetworking.h"

@implementation NNNetRequestClass

+ (BOOL) networkReachabilityWithURLString:(NSString *) strUrl {
    __block BOOL netState = NO;
    
    NSURL *baseURL = [NSURL URLWithString:strUrl];
    
    AFNetworkReachabilityManager *manager  = [AFNetworkReachabilityManager sharedManager];
}

@end
