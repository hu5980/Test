//
//  NNNoticeViewModel.m
//  NuanNuan_OC
//
//  Created by 忘、 on 16/12/12.
//  Copyright © 2016年 NuanNuan. All rights reserved.
//

#import "NNNoticeViewModel.h"

@implementation NNNoticeViewModel
- (void) getNoticeWithToken:(NSString *)token andLastID:(NSString *)lastID andPageNum:(NSString *)pageNum {
    NSDictionary *parames =@{@"token":token,@"last_id":lastID,@"pnum":pageNum};
    
    [NNNetRequestClass NetRequestPOSTWithRequestURL:[NSString stringWithFormat:@"%@/?c=api_notice&a=myNoticeList",NNBaseUrl] withParameter:parames withReturnValueBlock:^(id returnValue) {
        
    } withErrorCodeBlock:^(id errorCode) {
        
    } withFailureBlock:^(id failureBlock) {
        
    } withProgress:^(id Progress) {
        
    }];
    
}

- (void)fetchValueSuccessWithDic:(NSDictionary *)returnValue {

}

@end
