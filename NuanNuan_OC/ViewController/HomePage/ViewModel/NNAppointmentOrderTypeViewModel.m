//
//  NNAppointmentOrderTypeViewModel.m
//  NuanNuan_OC
//
//  Created by 胡光耀 on 2017/6/4.
//  Copyright © 2017年 NuanNuan. All rights reserved.
//

#import "NNAppointmentOrderTypeViewModel.h"
#import "NNOrderServerModel.h"
@implementation NNAppointmentOrderTypeViewModel

- (void)getAppointmentOrderType {
    [NNNetRequestClass NetRequestGETWithRequestURL:[NSString stringWithFormat:@"%@/?c=api_goods&a=getGoodsList",NNBaseUrl] withParameter:nil withReturnValueBlock:^(id returnValue) {
        [self fetchValueSuccessWithDic:returnValue];
    } withErrorCodeBlock:^(id errorCode) {
        self.errorBlock(errorCode);
    } withFailureBlock:^(id failureBlock) {
        self.failureBlock(failureBlock);
    } withProgress:^(id Progress) {
        
    }];
}

- (void)fetchValueSuccessWithDic:(NSDictionary *)returnValue {
    NSArray *list = [returnValue objectForKey:@"data"];
    NSMutableArray *orderArray = [NSMutableArray arrayWithCapacity:[list count]];
    for (int i = 0; i < list.count; i++) {
        NSDictionary *dic = [list objectAtIndex:i];
        NNOrderServerModel *model = [[NNOrderServerModel alloc] init];
        model.orderServerId = [dic objectForKey:@"g_id"];
        model.orderTitle = [dic objectForKey:@"g_name"];
        model.orderAttach = [dic objectForKey:@"g_attach"];
        model.orderUmon = [dic objectForKey:@"g_umon"];
        model.orderPrice = [dic objectForKey:@"g_price"];
        model.orderDiscountPrice = [dic objectForKey:@"g_discount_price"];
        model.orderDiscountPrice = [dic objectForKey:@"g_discription"];
        model.orderOnLine = [dic objectForKey:@"g_isonline"];
        model.orderIsDel = [dic objectForKey:@"g_isdel"];
        [orderArray addObject:model];
    }
    self.returnBlock(orderArray);
}

@end
