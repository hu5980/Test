//
//  NNAppointmentOrderViewModel.m
//  NuanNuan_OC
//
//  Created by 胡光耀 on 2017/6/4.
//  Copyright © 2017年 NuanNuan. All rights reserved.
//

#import "NNAppointmentOrderViewModel.h"

@implementation NNAppointmentOrderViewModel

- (void)submitOrderWithToken:(NSString *)token userName:(NSString *)name phono:(NSString *)phono sex:(NSString *)sex description:(NSString *)description married:(NSString *)married wechat:(NSString *)wechat age:(NSString *)age serviceId:(NSString *)g_id appointmentTypeId:(NSString *)appointmentId {
     NSDictionary *parames = @{@"token":token,
                               @"b_name":name,
                               @"b_tel":phono,
                               @"b_sex":sex,
                               @"b_weixin":wechat,
                               @"b_age":age,
                               @"g_id":g_id,
                               @"b_description":description,
                               @"bc_id":appointmentId,
                               @"b_married":married};
}
@end
