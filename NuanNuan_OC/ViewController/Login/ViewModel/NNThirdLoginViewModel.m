//
//  NNThirdLoginViewModel.m
//  NuanNuan_OC
//
//  Created by 胡光耀 on 16/11/26.
//  Copyright © 2016年 NuanNuan. All rights reserved.
//

#import "NNThirdLoginViewModel.h"
#import "OpenUDID.h"

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
        NSLog(@"%@",returnValue);
        self.returnBlock(returnValue);
    } withErrorCodeBlock:^(id errorCode) {
        self.errorBlock(errorCode);
    } withFailureBlock:^(id failureBlock) {
        self.failureBlock(failureBlock);
    } withProgress:^(id Progress) {
        
    }];

   
}

@end
