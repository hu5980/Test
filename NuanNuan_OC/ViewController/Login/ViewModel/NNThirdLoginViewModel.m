//
//  NNThirdLoginViewModel.m
//  NuanNuan_OC
//
//  Created by 胡光耀 on 16/11/26.
//  Copyright © 2016年 NuanNuan. All rights reserved.
//

#import "NNThirdLoginViewModel.h"
#import "OpenUDID.h"
#import "NNUserInfoModel.h"

@implementation NNThirdLoginViewModel

- (void)loginWithLoginType:(NSString *)loginType andAccessToken:(NSString *)accessToken andOpenId:(NSString *)openid {
    
   
    NSString *devicetoken = [[NSUserDefaults standardUserDefaults] objectForKey:@"DEVICETOKEN"];
    NSMutableDictionary * parames =  [NSMutableDictionary dictionaryWithDictionary:@{ @"access_token":accessToken,
                                                                                     @"login_type":loginType,
                                                                                      @"channel":@"ios",
                                                                                      @"device": [OpenUDID value]}];
    
    if (openid != nil) {
        [parames setValue:openid forKey:@"openid"];
    }
    
    if(devicetoken != nil){
        [parames setValue:devicetoken forKey:@"device_token"];
    }
   
    [NNNetRequestClass NetRequestPOSTWithRequestURL:[NSString stringWithFormat:@"%@/?c=api_user&a=thirdLogin",NNBaseUrl] withParameter:parames withReturnValueBlock:^(id returnValue) {
        [self fetchValueSuccessWithDic:returnValue];
    } withErrorCodeBlock:^(id errorCode) {
        self.errorBlock(errorCode);
    } withFailureBlock:^(id failureBlock) {
        self.failureBlock(failureBlock);
    } withProgress:^(id Progress) {
        
    }];

   
}





- (void)fetchValueSuccessWithDic:(NSDictionary *)returnValue {
    [[NSUserDefaults standardUserDefaults] setObject:[[returnValue objectForKey:@"data"] objectForKey:@"token"] forKey:@"token"];
    
    NSDictionary *info = [[returnValue objectForKey:@"data"] objectForKey:@"info"];
    NNUserInfoModel *model = [[NNUserInfoModel alloc] init];
    model.uid = [NSString stringWithFormat:@"%@",[info objectForKey:@"uid"]] ;
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
