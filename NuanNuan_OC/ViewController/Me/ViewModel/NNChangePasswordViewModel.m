//
//  NNChangePasswordViewModel.m
//  NuanNuan_OC
//
//  Created by 忘、 on 16/11/3.
//  Copyright © 2016年 NuanNuan. All rights reserved.
//

#import "NNChangePasswordViewModel.h"

@implementation NNChangePasswordViewModel

- (void)changePasswordWithtToken:(NSString *)token andCode:(NSString *)code andPassword:(NSString *)newPassword andTel:(NSString *)tel {
    NSDictionary *parames = @{@"token":token,@"tel":tel,@"code":code,@"password":newPassword};
    [NNNetRequestClass NetRequestPOSTWithRequestURL:[NSString stringWithFormat:@"%@/?c=api_member&a=changePw",NNBaseUrl] withParameter:parames withReturnValueBlock:^(id returnValue) {
        self.returnBlock([returnValue objectForKey:@"result"]);
    } withErrorCodeBlock:^(id errorCode) {
        self.errorBlock(errorCode);
    } withFailureBlock:^(id failureBlock) {
        self.failureBlock(failureBlock);
    } withProgress:^(id Progress) {
        
    }];
}

@end
