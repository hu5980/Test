//
//  NNMineCommentViewModel.m
//  NuanNuan_OC
//
//  Created by 胡光耀 on 16/11/23.
//  Copyright © 2016年 NuanNuan. All rights reserved.
//

#import "NNMineCommentViewModel.h"

@implementation NNMineCommentViewModel

- (void)getMineCommentWithToken:(NSString *)token andCommentType:(NSString *)type andLastComentID:(NSString *)lastID
                        andDown:(NSString *)down andPageNum:(NSString *)pageNum {
    if (lastID == nil) {
        lastID = @"";
    }
    NSDictionary *parames = @{@"token":token,@"type":type,@"last_id":lastID,@"down":down,@"pnum":pageNum};
    [NNNetRequestClass NetRequestPOSTWithRequestURL:[NSString stringWithFormat:@"%@/?c=api_comment&a=getMyCommentList",NNBaseUrl] withParameter:parames withReturnValueBlock:^(id returnValue) {
        NNLog(@"%@",returnValue);
    } withErrorCodeBlock:^(id errorCode) {
        NNLog(@"%@",errorCode);
    } withFailureBlock:^(id failureBlock) {
        NNLog(@"%@",failureBlock);
    } withProgress:^(id Progress) {
        
    }];
}

- (void)fetchValueSuccessWithDic:(NSDictionary *)returnValue {


}

@end
