//
//  NNBaseViewModel.h
//  NuanNuan_OC
//
//  Created by 忘、 on 16/10/18.
//  Copyright © 2016年 NuanNuan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Define.h"
#import "NNNetRequestClass.h"
@interface NNBaseViewModel : NSObject

@property (strong, nonatomic) ReturnValueBlock returnBlock;
@property (strong, nonatomic) ErrorCodeBlock errorBlock;
@property (strong, nonatomic) FailureBlock failureBlock;

/**
 获取网络的链接状态

 @param netConnectBlock 网络链接Block
 @param strURl           URL
 */
-(void) netWorkStateWithNetConnectBlock: (NetWorkBlock) netConnectBlock
                             WithURlStr: (NSString *) strURl;


/**
 传入交互的Block块
 @param returnBlock  网络请求成功返回数据
 @param errorBlock   网络请求错误返回数据
 @param failureBlock 网络请求失败返回数据
 */
-(void) setBlockWithReturnBlock: (ReturnValueBlock) returnBlock
                 WithErrorBlock: (ErrorCodeBlock) errorBlock
               WithFailureBlock: (FailureBlock) failureBlock;

-(void)fetchValueSuccessWithDic: (NSDictionary *) returnValue;

@end
