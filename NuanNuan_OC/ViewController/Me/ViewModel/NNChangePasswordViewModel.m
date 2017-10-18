//
//  NNChangePasswordViewModel.m
//  NuanNuan_OC
//
//  Created by 忘、 on 16/11/3.
//  Copyright © 2016年 NuanNuan. All rights reserved.
//

#import "NNChangePasswordViewModel.h"

@implementation NNChangePasswordViewModel

- (void)changePasswordWithtTel:(NSString *)telphone andCode:(NSString *)code andPassword:(NSString *)password  {
    NSDictionary *parames = @{@"tel":telphone,@"code":code,@"password":password,@"zone":@"+86",@"appkey":@"19979a0c7b7d0"};
    [NNNetRequestClass NetRequestPOSTWithRequestURL:[NSString stringWithFormat:@"%@/?c=api_user&a=resetPw",NNBaseUrl] withParameter:parames withReturnValueBlock:^(id returnValue) {
        self.returnBlock([returnValue objectForKey:@"result"]);
    } withErrorCodeBlock:^(id errorCode) {
        self.errorBlock(errorCode);
    } withFailureBlock:^(id failureBlock) {
        self.failureBlock(failureBlock);
    } withProgress:^(id Progress) {
        
    }];
}

@end
