//
//  NNchangeUserInfoViewModel.m
//  NuanNuan_OC
//
//  Created by 忘、 on 16/11/3.
//  Copyright © 2016年 NuanNuan. All rights reserved.
//

#import "NNchangeUserInfoViewModel.h"
#import "NNUserInfoModel.h"

@implementation NNchangeUserInfoViewModel

- (void)changeUserInfoWithNewUserInfo:(NSDictionary *)parames {
    [NNNetRequestClass NetRequestPOSTWithRequestURL:[NSString stringWithFormat:@"%@/?c=api_member&a=changeUserInfo",NNBaseUrl] withParameter:parames withReturnValueBlock:^(id returnValue) {
        self.returnBlock([returnValue objectForKey:@"result"]);
        RLMRealm *realm = [RLMRealm defaultRealm];
        [realm transactionWithBlock:^{
            RLMResults *results = [NNUserInfoModel objectsWhere:@"uid = %@",USERID];
            NNUserInfoModel *userInfoModel = [results lastObject];
            userInfoModel.nickName = [parames objectForKey:@"nickname"];
            userInfoModel.sex = [[parames objectForKey:@"sex"] isEqualToString:@"1"] ?@"男":@"女";
            [realm commitWriteTransaction];
        }];
    } withErrorCodeBlock:^(id errorCode) {
        self.errorBlock(errorCode);
    } withFailureBlock:^(id failureBlock) {
        self.failureBlock(failureBlock);
    } withProgress:^(id Progress) {
        
    }];
}

@end
