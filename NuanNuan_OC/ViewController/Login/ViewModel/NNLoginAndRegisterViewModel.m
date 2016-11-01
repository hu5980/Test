//
//  NNLoginAndRegisterViewModel.m
//  NuanNuan_OC
//
//  Created by 忘、 on 16/11/1.
//  Copyright © 2016年 NuanNuan. All rights reserved.
//

#import "NNLoginAndRegisterViewModel.h"

@implementation NNLoginAndRegisterViewModel

- (void)registerUserWithUsername:(NSString *)userName andverify:(NSString *)verify andPassword:(NSString *)password {
   
}

- (void)loginWithUserName:(NSString *)userName andpassword:(NSString *)password andLoginType:(NSInteger)type{
    NSDictionary *parames = @{@"username":userName,@"password":password,@"type":[NSNumber numberWithInteger:type]};
    
    [NNNetRequestClass NetRequestGETWithRequestURL:[NSString stringWithFormat:@"%@/?c=api_user&a=login",NNBaseUrl] withParameter:parames withReturnValueBlock:^(id returnValue) {
        
    } withErrorCodeBlock:^(id errorCode) {
        
    } withFailureBlock:^(id failureBlock) {
        
    } withProgress:^(id Progress) {
        
    }];
}

@end
