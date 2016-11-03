//
//  NNPariseViewModel.m
//  NuanNuan_OC
//
//  Created by 忘、 on 16/11/3.
//  Copyright © 2016年 NuanNuan. All rights reserved.
//

#import "NNPariseViewModel.h"

@implementation NNPariseViewModel

- (void)parisdArticleWithToken:(NSString *)token andArticleType:(NSString *)type andArticleID:(NSString *)articleId {
    
    NSDictionary *parames = @{@"token":token,@"type":type,@"id":articleId};
    
    [NNNetRequestClass NetRequestPOSTWithRequestURL:[NSString stringWithFormat:@"%@/?c=api_good&a=addGood",NNBaseUrl] withParameter:parames withReturnValueBlock:^(id returnValue) {
        self.returnBlock([returnValue objectForKey:@"result"]);
    } withErrorCodeBlock:^(id errorCode) {
        self.errorBlock(errorCode);
    } withFailureBlock:^(id failureBlock) {
        self.failureBlock(failureBlock);
    } withProgress:^(id Progress) {
        
    }];
}

@end
