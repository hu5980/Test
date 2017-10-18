//
//  NNAppointmentOrderViewModel.h
//  NuanNuan_OC
//
//  Created by 胡光耀 on 2017/6/4.
//  Copyright © 2017年 NuanNuan. All rights reserved.
//

#import "NNBaseViewModel.h"

@interface NNAppointmentOrderViewModel : NNBaseViewModel

- (void)submitOrderWithToken:(NSString *)token userName:(NSString *)name  sex:(NSString *)sex wechat:(NSString *)wechat age:(NSString *)age serviceId:(NSString *)g_id ;

@end
