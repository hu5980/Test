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
#pragma 检测网络的可链接性
+ (BOOL) networkReachabilityWithURLString:(NSString *) strUrl {
    __block BOOL netState = NO;
   
    AFNetworkReachabilityManager *manager  = [AFNetworkReachabilityManager managerForDomain:strUrl];
    __block AFNetworkReachabilityManager *weakManager = manager;
    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case AFNetworkReachabilityStatusReachableViaWWAN:
            case AFNetworkReachabilityStatusReachableViaWiFi:
                [weakManager stopMonitoring];
                netState = YES;
                break;
            case AFNetworkReachabilityStatusNotReachable:
                netState = NO;
            default:
                [weakManager stopMonitoring];
                break;
        }
    }];
    [manager startMonitoring];
    return netState;
}



+ (void) NetRequestGETWithRequestURL:(NSString *) requestURLString
                       withParameter:(NSDictionary *)parameter
                withReturnValueBlock:(ReturnValueBlock) returnBlock
                  withErrorCodeBlock:(ErrorCodeBlock) errorBlock
                    withFailureBlock:(FailureBlock)failureBlock
                        withPergress:(ProgressBlock) progressBlock
{
    AFHTTPSessionManager *sessionManager = [[AFHTTPSessionManager alloc] init];
    sessionManager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    [sessionManager GET:requestURLString parameters:returnBlock progress:^(NSProgress * _Nonnull downloadProgress) {
         progressBlock(downloadProgress);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if ([responseObject objectForKey:@"errorCode"]) {
            errorBlock([responseObject objectForKey:@"errorCode"]);
        }else{
            returnBlock(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failureBlock(error);
    }];

}

+ (void) NetRequestPOSTWithRequestURL:(NSString *) requestURLString
                       withParameter:(NSDictionary *)parameter
                withReturnValueBlock:(ReturnValueBlock) returnBlock
                  withErrorCodeBlock:(ErrorCodeBlock) errorBlock
                    withFailureBlock:(FailureBlock)failureBlock
                        withPergress:(ProgressBlock) progressBlock
{
    AFHTTPSessionManager *sessionManager = [[AFHTTPSessionManager alloc] init];
    sessionManager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    [sessionManager POST:requestURLString parameters:parameter progress:^(NSProgress * _Nonnull uploadProgress) {
        progressBlock(uploadProgress);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if ([responseObject objectForKey:@"errorCode"]) {
            errorBlock([responseObject objectForKey:@"errorCode"]);
        }else{
            returnBlock(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failureBlock(error);
    }];
}



@end
