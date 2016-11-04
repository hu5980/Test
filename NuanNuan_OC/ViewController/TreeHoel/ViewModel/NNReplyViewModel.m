//
//  NNReplyViewModel.m
//  NuanNuan_OC
//
//  Created by 忘、 on 16/11/4.
//  Copyright © 2016年 NuanNuan. All rights reserved.
//

#import "NNReplyViewModel.h"

@implementation NNReplyViewModel

- (void)replyAnswerOrTreeHoelWithToken:(NSString *)token andReplyType:(NSString *)type andTargetID:(NSString *) targetID andConnent:(NSString *) content {
    NSDictionary *parames = @{@"token":token,@"type":type,@"id":targetID,@"content":content};
    
    [NNNetRequestClass NetRequestPOSTWithRequestURL:[NSString stringWithFormat:@"%@/?c=api_comment&a=addComment",NNBaseUrl] withParameter:parames withReturnValueBlock:^(id returnValue) {
        NNLog(@"%@",returnValue);
        self.returnBlock([returnValue objectForKey:@"result"]);
    } withErrorCodeBlock:^(id errorCode) {
        self.returnBlock(errorCode);
    } withFailureBlock:^(id failureBlock) {
        self.failureBlock(failureBlock);
    } withProgress:^(id Progress) {
        
    }];
    
}

@end
