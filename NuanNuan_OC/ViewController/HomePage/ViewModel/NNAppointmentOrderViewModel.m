//
//  NNAppointmentOrderViewModel.m
//  NuanNuan_OC
//
//  Created by 胡光耀 on 2017/6/4.
//  Copyright © 2017年 NuanNuan. All rights reserved.
//

#import "NNAppointmentOrderViewModel.h"

@implementation NNAppointmentOrderViewModel

- (void)submitOrderWithToken:(NSString *)token userName:(NSString *)name  sex:(NSString *)sex wechat:(NSString *)wechat age:(NSString *)age serviceId:(NSString *)g_id {
     NSDictionary *parames = @{@"token":token,
                               @"b_name":name,
                             
                               @"b_sex":sex,
                               @"b_weixin":wechat,
                               @"b_age":age,
                               @"g_id":g_id,

                               };
    
    [NNNetRequestClass NetRequestPOSTWithRequestURL:[NSString stringWithFormat:@"%@/?c=api_order&a=addorder",NNBaseUrl] withParameter:parames withReturnValueBlock:^(id returnValue) {
        NSLog(@"%@",returnValue);
        [self fetchValueSuccessWithDic:returnValue];
    } withErrorCodeBlock:^(id errorCode) {
        self.errorBlock(errorCode);
    } withFailureBlock:^(id failureBlock) {
        self.failureBlock(failureBlock);
    } withProgress:^(id Progress) {
        
    } ];
}

- (void)fetchValueSuccessWithDic:(NSDictionary *)returnValue {
    self.returnBlock(returnValue);
}

@end
