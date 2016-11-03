//
//  NNUnPariseViewModel.m
//  NuanNuan_OC
//
//  Created by 忘、 on 16/11/3.
//  Copyright © 2016年 NuanNuan. All rights reserved.
//

#import "NNUnPariseViewModel.h"

@implementation NNUnPariseViewModel

- (void)unParisdArticleWithToken:(NSString *)token andArticleType:(NSString *)type andArticleID:(NSString *)articleId{
    NSDictionary *parames = @{@"token":token,@"type":type,@"id":articleId};
    
    [NNNetRequestClass NetRequestPOSTWithRequestURL:[NSString stringWithFormat:@"%@/?c=api_good&a=cancelGood",NNBaseUrl] withParameter:parames withReturnValueBlock:^(id returnValue) {
        self.returnBlock([returnValue objectForKey:@"result"]);
    } withErrorCodeBlock:^(id errorCode) {
        self.errorBlock(errorCode);
    } withFailureBlock:^(id failureBlock) {
        self.failureBlock(failureBlock);
    } withProgress:^(id Progress) {
        
    }];

}

@end
