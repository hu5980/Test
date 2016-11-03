//
//  NNuploadUserHeadImageViewModel.m
//  NuanNuan_OC
//
//  Created by 忘、 on 16/11/3.
//  Copyright © 2016年 NuanNuan. All rights reserved.
//

#import "NNuploadUserHeadImageViewModel.h"

@implementation NNuploadUserHeadImageViewModel

- (void)upLoadUserheadImageWithToken:(NSString *)token andHeadImagedata:(NSData *)data {
    NSDictionary *parames = @{@"token":token,@"head":data};
    [NNNetRequestClass NetRequestPOSTWithRequestURL:[NSString stringWithFormat:@"%@/?c=api_member&a=updateHead",NNBaseUrl] withParameter:parames withReturnValueBlock:^(id returnValue) {
        self.returnBlock([returnValue objectForKey:@"result"]);
    } withErrorCodeBlock:^(id errorCode) {
        self.errorBlock(errorCode);
    } withFailureBlock:^(id failureBlock) {
        self.failureBlock(failureBlock);
    } withProgress:^(id Progress) {
        
    }];
}

@end
