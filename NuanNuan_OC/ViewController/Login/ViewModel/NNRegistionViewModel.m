//
//  NNRegistionViewModel.m
//  NuanNuan_OC
//
//  Created by 忘、 on 16/11/2.
//  Copyright © 2016年 NuanNuan. All rights reserved.
//

#import "NNRegistionViewModel.h"
#import "OpenUDID.h"
@implementation NNRegistionViewModel

- (void)registerUserWithUsername:(NSString *)userName andverify:(NSString *)verify andPassword:(NSString *)password {
    
    NSDictionary *parames = @{@"tel":userName,
                              @"zone":@"86",
                              @"code":verify,
                              @"password":password,
                              @"channel":@"ios",
                              @"device": [OpenUDID value]};
    
    [NNNetRequestClass NetRequestPOSTWithRequestURL:[NSString stringWithFormat:@"%@/?c=api_user&a=SDKSMSRegist",NNBaseUrl] withParameter:parames withReturnValueBlock:^(id returnValue) {
        
    } withErrorCodeBlock:^(id errorCode) {
        
    } withFailureBlock:^(id failureBlock) {
        
    } withProgress:^(id Progress) {
        
    }];
    
}

@end
