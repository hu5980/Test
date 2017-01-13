//
//  NNRegistionViewModel.m
//  NuanNuan_OC
//
//  Created by 忘、 on 16/11/2.
//  Copyright © 2016年 NuanNuan. All rights reserved.
//

#import "NNRegistionViewModel.h"
#import "OpenUDID.h"
#import "NNUserInfoModel.h"

@implementation NNRegistionViewModel

- (void)registerUserWithUsername:(NSString *)userName andverify:(NSString *)verify andPassword:(NSString *)password {
     NSString *devicetoken = [[NSUserDefaults standardUserDefaults] objectForKey:@"DEVICETOKEN"];
    NSDictionary *parames = @{@"tel":userName,
                              @"zone":@"86",
                              @"code":verify,
                              @"password":password,
                              @"channel":@"ios",
                              @"appkey":@"19979a0c7b7d0"};
    NSMutableDictionary *mutableParames = [NSMutableDictionary dictionaryWithDictionary:parames];
    if(devicetoken == nil){
        [mutableParames setValue:devicetoken forKey:@"device_token"];
    }
   
    
    [NNNetRequestClass NetRequestPOSTWithRequestURL:[NSString stringWithFormat:@"%@/?c=api_user&a=SDKSMSRegist",NNBaseUrl] withParameter:parames withReturnValueBlock:^(id returnValue) {
      
        [self fetchValueSuccessWithDic:returnValue];
    } withErrorCodeBlock:^(id errorCode) {
        self.errorBlock(errorCode);
    } withFailureBlock:^(id failureBlock) {
         NSLog(@"%@",failureBlock);
    } withProgress:^(id Progress) {
        
    }];
}

- (void)fetchValueSuccessWithDic:(NSDictionary *)returnValue {
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
