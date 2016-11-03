//
//  NNLoginViewModel.m
//  NuanNuan_OC
//
//  Created by 忘、 on 16/11/2.
//  Copyright © 2016年 NuanNuan. All rights reserved.
//

#import "NNLoginViewModel.h"

@implementation NNLoginViewModel

- (void)loginWithUserName:(NSString *)userName andpassword:(NSString *)password andLoginType:(NSInteger)type{
    NSDictionary *parames = @{@"username":userName,@"password":password,@"type":[NSNumber numberWithInteger:type]};
    
    [NNNetRequestClass NetRequestGETWithRequestURL:[NSString stringWithFormat:@"%@/?c=api_user&a=login",NNBaseUrl] withParameter:parames withReturnValueBlock:^(id returnValue) {
        NSLog(@"%@",returnValue);
        self.returnBlock(returnValue);
    } withErrorCodeBlock:^(id errorCode) {
        self.errorBlock(errorCode);
    } withFailureBlock:^(id failureBlock) {
        self.failureBlock(failureBlock);
    } withProgress:^(id Progress) {
        
    }];
}

@end
