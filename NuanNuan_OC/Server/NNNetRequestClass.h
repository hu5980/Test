//
//  NNNetRequestClass.h
//  NuanNuan_OC
//
//  Created by 忘、 on 16/10/17.
//  Copyright © 2016年 NuanNuan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Define.h"
@interface NNNetRequestClass : NSObject

/**
 获取网络状态

 @param strUrl 测试的URL

 @return (有网络:YES  无网络:NO)
 */
+ (BOOL) networkReachabilityWithURLString:(NSString *) strUrl;


/**
 GET 网络请求

 @param requestURLString 网络请求URL
 @param parameter        参数
 @param returnBlock      请求成功返回Value
 @param errorBlock       错误Value
 @param failureBlock     请求失败返回Value
 @param progressBlock    进度条Value
 */
+ (void) NetRequestPOSTWithRequestURL:(NSString *) requestURLString
                        withParameter:(NSDictionary *)parameter
                 withReturnValueBlock:(ReturnValueBlock) returnBlock
                   withErrorCodeBlock:(ErrorCodeBlock) errorBlock
                     withFailureBlock:(FailureBlock)failureBlock
                         withProgress:(ProgressBlock) progressBlock;



/**
 POST 网络请求

 @param requestURLString 网络请求URL
 @param parameter        参数
 @param returnBlock      请求成功返回Value
 @param errorBlock       错误Value
 @param failureBlock     请求失败返回Value
 @param progressBlock    进度条Value
 */
+ (void) NetRequestGETWithRequestURL:(NSString *) requestURLString
                       withParameter:(NSDictionary *)parameter
                withReturnValueBlock:(ReturnValueBlock) returnBlock
                  withErrorCodeBlock:(ErrorCodeBlock) errorBlock
                    withFailureBlock:(FailureBlock)failureBlock
                        withProgress:(ProgressBlock) progressBlock;



+ (void) NetRequestPOSTFileWithRequestURL:(NSString *) requestURLString
                            withParameter:(NSDictionary *)parameter
                             withFileData:(NSData *)data
                             withFileName:(NSString *)fileName
                     withReturnValueBlock:(ReturnValueBlock) returnBlock
                       withErrorCodeBlock:(ErrorCodeBlock) errorBlock
                         withFailureBlock:(FailureBlock)failureBlock
                             withProgress:(ProgressBlock) progressBlock;

@end
