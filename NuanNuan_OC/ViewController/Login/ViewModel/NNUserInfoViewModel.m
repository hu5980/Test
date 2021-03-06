//
//  NNLoginAndRegisterViewModel.m
//  NuanNuan_OC
//
//  Created by 忘、 on 16/11/1.
//  Copyright © 2016年 NuanNuan. All rights reserved.
//

#import "NNUserInfoViewModel.h"
#import "NNUserInfoModel.h"
@implementation NNUserInfoViewModel

- (void)getUserInfoWithToken:(NSString *)token
{
    NSDictionary *parames = @{@"token":token};
    
    [NNNetRequestClass NetRequestPOSTWithRequestURL:[NSString stringWithFormat:@"%@/?c=api_member&a=getUserInfo",NNBaseUrl] withParameter:parames withReturnValueBlock:^(id returnValue) {
        [self fetchValueSuccessWithDic:returnValue];
        self.returnBlock(returnValue);
    } withErrorCodeBlock:^(id errorCode) {
        self.errorBlock(errorCode);
    } withFailureBlock:^(id failureBlock) {
        self.failureBlock(failureBlock);
    } withProgress:^(id Progress) {
        
    }];
}

-(void)fetchValueSuccessWithDic: (NSDictionary *) returnValue {
    NSDictionary *info = [[returnValue objectForKey:@"data"] objectForKey:@"info"];
    NNUserInfoModel *model = [[NNUserInfoModel alloc] init];
    model.uid = [info objectForKey:@"uid"] ;
    model.headImageUrl = [info objectForKey:@"head"];
    model.sex = [[info objectForKey:@"sex"] integerValue] == 1 ? @"男":@"女" ;
    model.telphone = [info objectForKey:@"tel"];
    model.nickName = [info objectForKey:@"nickname"];
    model.usable = [info objectForKey:@"usable"];
    model.userDescription = [info objectForKey:@"description"];
    model.channel = [info objectForKey:@"channel"];
    model.creatTime =[[info objectForKey:@"create_time"] integerValue];
    model.modifyTime = [[info objectForKey:@"modify_time"] integerValue];
    RLMRealm *realm = [RLMRealm defaultRealm];
    [realm transactionWithBlock:^{
        [realm addObject:model];
    }];
    [[NSUserDefaults standardUserDefaults] setObject:model.uid forKey:@"currentUserID"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    self.returnBlock(model);
}

@end
