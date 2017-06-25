//
//  NNPayDataViewModel.h
//  NuanNuan_OC
//
//  Created by 胡光耀 on 2017/6/11.
//  Copyright © 2017年 NuanNuan. All rights reserved.
//

#import "NNBaseViewModel.h"

@interface NNPayDataViewModel : NNBaseViewModel

- (void)getPayData:(NSString *) token PayType:(NSString *)payType andOrderID:(NSString *)o_id;

- (void)payResult:(NSString *)token OrderId:(NSString *)o_id mhtOrderNo:(NSString *)mhtOrderNo paystatus:(NSString *)pay_status;

@end
