//
//  NNArticleIsLikeViewModel.m
//  NuanNuan_OC
//
//  Created by 忘、 on 16/11/25.
//  Copyright © 2016年 NuanNuan. All rights reserved.
//

#import "NNArticleIsLikeViewModel.h"

@implementation NNArticleIsLikeViewModel

- (void)getUserIsLikeTheArticleWithToken:(NSString *)token andType:(NSString *)type andArticleID:(NSString *)aid {
    NSDictionary *parames = @{@"token":token,@"type":type,@"id":aid};
    [NNNetRequestClass NetRequestPOSTWithRequestURL:[NSString stringWithFormat:@"%@/?c=api_good&a=hasPraised",NNBaseUrl] withParameter:parames withReturnValueBlock:^(id returnValue) {
        return self.returnBlock(returnValue);
    } withErrorCodeBlock:^(id errorCode) {
        return self.errorBlock(errorCode);
    } withFailureBlock:^(id failureBlock) {
        return self.failureBlock(failureBlock);
    } withProgress:^(id Progress) {
        
    }];
}

@end
