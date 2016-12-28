//
//  NNNoticeHadReadViewModel.m
//  NuanNuan_OC
//
//  Created by 忘、 on 16/12/28.
//  Copyright © 2016年 NuanNuan. All rights reserved.
//

#import "NNNoticeHadReadViewModel.h"

@implementation NNNoticeHadReadViewModel

- (void)hadReadNoticeWithToken:(NSString *) token andNoticeID:(NSString *)noticeID {
    NSDictionary *parames = @{@"token":token,@"n_id":noticeID};
    
    [NNNetRequestClass NetRequestPOSTWithRequestURL:[NSString stringWithFormat:@"%@/%@",NNBaseUrl,@"/?c=api_notice&a=setNoticeToRead"] withParameter:parames withReturnValueBlock:^(id returnValue) {
        return self.returnBlock([returnValue objectForKey:@"result"]);
    } withErrorCodeBlock:^(id errorCode) {
        return self.errorBlock(errorCode);
    } withFailureBlock:^(id failureBlock) {
        return self.failureBlock(failureBlock);
    } withProgress:^(id Progress) {
        
    }];
    
    
}

@end
