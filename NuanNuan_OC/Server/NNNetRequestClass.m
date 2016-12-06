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
                        withProgress:(ProgressBlock) progressBlock
{
    NSMutableDictionary *mutableParameter  = [NSMutableDictionary dictionaryWithDictionary:parameter];
    NSString *ver = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    [mutableParameter setObject:ver forKey:@"ver"];
    [mutableParameter setObject:@"appstore" forKey:@"channel"];
    NSString *cerPath = [[NSBundle mainBundle] pathForResource:@"server" ofType:@"cer"];
    NSData * certData =[NSData dataWithContentsOfFile:cerPath];
    NSSet * certSet = [[NSSet alloc] initWithObjects:certData, nil];
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeCertificate];
    // 是否允许,NO-- 不允许无效的证书
    [securityPolicy setAllowInvalidCertificates:YES];
     securityPolicy.validatesDomainName = NO;
    // 设置证书
    [securityPolicy setPinnedCertificates:certSet];
    
    AFHTTPSessionManager *sessionManager = [[AFHTTPSessionManager alloc] init];
    sessionManager.securityPolicy = securityPolicy;
    sessionManager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    [sessionManager GET:requestURLString parameters:mutableParameter progress:^(NSProgress * _Nonnull downloadProgress) {
         progressBlock(downloadProgress);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if ([[responseObject objectForKey:@"result"] isEqualToString:@"fail"]) {
            errorBlock([responseObject objectForKey:@"msg"]);
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
                        withProgress:(ProgressBlock) progressBlock
{
    NSMutableDictionary *mutableParameter  = [NSMutableDictionary dictionaryWithDictionary:parameter];
    NSString *ver = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    [mutableParameter setObject:ver forKey:@"ver"];
    [mutableParameter setObject:@"appstore" forKey:@"device_channel"];
    
    NSString *cerPath = [[NSBundle mainBundle] pathForResource:@"server" ofType:@"cer"];
    NSData * certData =[NSData dataWithContentsOfFile:cerPath];
    NSSet * certSet = [[NSSet alloc] initWithObjects:certData, nil];
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeCertificate];
    // 是否允许,NO-- 不允许无效的证书
    [securityPolicy setAllowInvalidCertificates:YES];
    securityPolicy.validatesDomainName = NO;
    // 设置证书
    [securityPolicy setPinnedCertificates:certSet];

    
    AFHTTPSessionManager *sessionManager = [[AFHTTPSessionManager alloc] init];
    sessionManager.securityPolicy = securityPolicy;
    sessionManager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
  
    [sessionManager POST:requestURLString parameters:mutableParameter progress:^(NSProgress * _Nonnull uploadProgress) {
        progressBlock(uploadProgress);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if ([[responseObject objectForKey:@"result"] isEqualToString:@"fail"]) {
            errorBlock([responseObject objectForKey:@"msg"]);
        }else{
            returnBlock(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failureBlock(error.description);
    }];
}

+ (void) NetRequestPOSTFileWithRequestURL:(NSString *) requestURLString
                        withParameter:(NSDictionary *)parameter
                                 withName:(NSString *)name
                             withFileData:(NSData *)data
                             withFileName:(NSString *)fileName
                 withReturnValueBlock:(ReturnValueBlock) returnBlock
                   withErrorCodeBlock:(ErrorCodeBlock) errorBlock
                     withFailureBlock:(FailureBlock)failureBlock
                             withProgress:(ProgressBlock) progressBlock {
    
    NSString *cerPath = [[NSBundle mainBundle] pathForResource:@"server" ofType:@"cer"];
    NSData * certData =[NSData dataWithContentsOfFile:cerPath];
    NSSet * certSet = [[NSSet alloc] initWithObjects:certData, nil];
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeCertificate];
    // 是否允许,NO-- 不允许无效的证书
    [securityPolicy setAllowInvalidCertificates:YES];
     securityPolicy.validatesDomainName = NO;
    // 设置证书
    [securityPolicy setPinnedCertificates:certSet];
    
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] init];
    manager.securityPolicy = securityPolicy;
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    [manager POST:requestURLString parameters:parameter constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        [formData appendPartWithFileData:data name:name fileName:fileName mimeType:@"image/jpg"];
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        progressBlock(uploadProgress);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if ([[responseObject objectForKey:@"result"] isEqualToString:@"fail"]) {
            errorBlock([responseObject objectForKey:@"msg"]);
        }else{
            returnBlock(responseObject);
        }

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
         failureBlock(error);
    }];

}




@end
