//
//  NNLoginViewModel.m
//  NuanNuan_OC
//
//  Created by 忘、 on 16/11/2.
//  Copyright © 2016年 NuanNuan. All rights reserved.
//

#import "NNLoginViewModel.h"
#import "NNUserInfoModel.h"
@implementation NNLoginViewModel

- (void)loginWithUserName:(NSString *)userName andpassword:(NSString *)password andLoginType:(NSInteger)type{
    NSDictionary *parames = @{@"username":userName,@"password":password,@"type":[NSNumber numberWithInteger:type]};
    
    [NNNetRequestClass NetRequestPOSTWithRequestURL:[NSString stringWithFormat:@"%@/?c=api_user&a=login",NNBaseUrl] withParameter:parames withReturnValueBlock:^(id returnValue) {
        [self fetchValueSuccessWithDic:returnValue];
    } withErrorCodeBlock:^(id errorCode) {
        self.errorBlock(errorCode);
    } withFailureBlock:^(id failureBlock) {
        self.failureBlock(failureBlock);
    } withProgress:^(id Progress) {
        
    }];
}

-(void)fetchValueSuccessWithDic: (NSDictionary *) returnValue {
    
    [[NSUserDefaults standardUserDefaults] setObject:[[returnValue objectForKey:@"data"] objectForKey:@"token"] forKey:@"token"];
    
    NSDictionary *info = [[returnValue objectForKey:@"data"] objectForKey:@"info"];
    NNUserInfoModel *model = [[NNUserInfoModel alloc] init];
    model.uid = [info objectForKey:@"uid"] ;
    model.headImageUrl = [info objectForKey:@"head"];
    model.sex = [[info objectForKey:@"sex"] integerValue] == 1 ? @"男":@"女";
    model.telphone = [info objectForKey:@"tel"];
    model.nickName = [info objectForKey:@"nickname"];
    model.usable = [info objectForKey:@"usable"];
    model.userDescription = [info objectForKey:@"description"];
    model.channel = [info objectForKey:@"channel"];
    model.creatTime =[[info objectForKey:@"create_time"] integerValue];
    model.modifyTime = [[info objectForKey:@"modify_time"] integerValue];
    RLMRealm *realm = [RLMRealm defaultRealm];
    [realm transactionWithBlock:^{
        [realm addOrUpdateObject:model];
    }];
    [[NSUserDefaults standardUserDefaults] setObject:model.uid forKey:@"currentUserID"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    
    self.returnBlock(model);
}


@end
