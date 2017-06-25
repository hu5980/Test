//
//  NNOrderViewModel.m
//  NuanNuan_OC
//
//  Created by 忘、 on 16/11/15.
//  Copyright © 2016年 NuanNuan. All rights reserved.
//

#import "NNOrderViewModel.h"
#import "NNOrderModel.h"
#import "NNTimeUtil.h"
@implementation NNOrderViewModel
- (void)getMineOrderInfoWithToken:(NSString *)token andOrderID:(NSString *)orderID andPageNum:(NSString *)pageNum {
    if (orderID == nil) {
        orderID = @"";
    }
    
    NSDictionary *parames = @{@"token":token,@"last_id":orderID,@"pnum":pageNum};
    
    [NNNetRequestClass NetRequestPOSTWithRequestURL:[NSString stringWithFormat:@"%@/?c=api_order&a=myOrderList",NNBaseUrl] withParameter:parames withReturnValueBlock:^(id returnValue) {
        [self fetchValueSuccessWithDic:returnValue];
    } withErrorCodeBlock:^(id errorCode) {
        
    } withFailureBlock:^(id failureBlock) {
        
    } withProgress:^(id Progress) {
        
    }];
}

- (void)fetchValueSuccessWithDic:(NSDictionary *)returnValue {

    NSArray *orderArray = [[returnValue objectForKey:@"data"] objectForKey:@"list"];
    NSMutableArray *orderMutableArray = [NSMutableArray arrayWithCapacity:orderArray.count];
    for (int i  = 0; i < orderArray.count; i++) {
        NSDictionary *orderDic = [orderArray objectAtIndex:i];
        NNOrderModel *orderModel = [[NNOrderModel alloc] init];
        orderModel.orderID = [orderDic objectForKey:@"o_code"];
        if([[orderDic objectForKey:@"b_name"] isKindOfClass:[NSNull class]]){
            orderModel.orderUserName = @"";
        }else{
            orderModel.orderUserName = [orderDic objectForKey:@"b_name"];
        }
        orderModel.orderTelephone = [orderDic objectForKey:@"b_tel"];
        orderModel.orderSex = [[orderDic objectForKey:@"b_sex"] isEqualToString:@"1"] ? @"男":@"女" ;
        orderModel.merry = [[orderDic objectForKey:@"b_married"] isEqualToString:@"1"] ? @"未婚":@"已婚";
        orderModel.wechat = [orderDic objectForKey:@"b_weixin"] ;
        orderModel.age = [orderDic objectForKey:@"b_age"];
        orderModel.orderTime = [NNTimeUtil timeDealWithFormat:@"yyyy-MM-dd hh:mm:ss" andTime:[[orderDic objectForKey:@"create_time"] integerValue]];
//        if([[orderDic objectForKey:@"bc_name"] isKindOfClass:[NSNull class]]){
//            orderModel.orderType = @"";
//        }else{
//            orderModel.orderType = [orderDic objectForKey:@"bc_name"];
//        }
        
        NSDictionary *goodDic = [orderDic objectForKey:@"goodsList"][0];
        
        orderModel.orderContent = [goodDic objectForKey:@"g_name"];
        [orderMutableArray addObject:orderModel];
    }
    self.returnBlock(orderMutableArray);
}

@end
