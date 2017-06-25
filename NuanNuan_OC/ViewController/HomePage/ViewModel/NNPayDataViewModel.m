//
//  NNPayDataViewModel.m
//  NuanNuan_OC
//
//  Created by 胡光耀 on 2017/6/11.
//  Copyright © 2017年 NuanNuan. All rights reserved.
//

#import "NNPayDataViewModel.h"
#import "NNPayDataModel.h"
@implementation NNPayDataViewModel

- (void)getPayData:(NSString *) token PayType:(NSString *)payType andOrderID:(NSString *)o_id {
    NSDictionary *parames = @{@"token":token,@"o_id":o_id,@"pay_type":payType};
    
    [NNNetRequestClass NetRequestPOSTWithRequestURL:[NSString stringWithFormat:@"%@/?c=api_pay&a=getPayData",NNBaseUrl] withParameter:parames withReturnValueBlock:^(id returnValue) {
        [self fetchValueSuccessWithDic:returnValue];
    } withErrorCodeBlock:^(id errorCode) {
        self.errorBlock(errorCode);
    } withFailureBlock:^(id failureBlock) {
        self.failureBlock(failureBlock);
    } withProgress:^(id Progress) {
        
    }];
}

- (void)fetchValueSuccessWithDic:(NSDictionary *)returnValue {
    NSDictionary *dic = [[returnValue objectForKey:@"data"] objectForKey:@"pay_data"];
    NNPayDataModel *model = [[NNPayDataModel alloc] init];
    model.appid = [dic objectForKey:@"appId"];
     model.mhtOrderNo = [dic objectForKey:@"mhtOrderNo"];
     model.mhtOrderName = [dic objectForKey:@"mhtOrderName"];
     model.mhtOrderAmt = [dic objectForKey:@"mhtOrderAmt"];
     model.mhtOrderDetail = [dic objectForKey:@"mhtOrderDetail"];
     model.mhtOrderStartTime = [dic objectForKey:@"mhtOrderStartTime"];
     model.mhtReserved = [dic objectForKey:@"mhtReserved"];
     model.mhtNotifyUrl = [dic objectForKey:@"notifyUrl"];
     model.mhtOrderType = [dic objectForKey:@"mhtOrderType"];
     model.mhtCurrentType = [dic objectForKey:@"mhtCurrencyType"];
     model.mhtOrderTimeOut = [dic objectForKey:@"mhtOrderTimeOut"];
     model.mhtCharset = [dic objectForKey:@"mhtCharset"];
     model.mhtSignature = [dic objectForKey:@"mhtSignature"];
    
    self.returnBlock(model);
}


- (void)payResult:(NSString *)token OrderId:(NSString *)o_id mhtOrderNo:(NSString *)mhtOrderNo paystatus:(NSString *)pay_status {
    NSDictionary *parames = @{@"token":token,@"o_id":o_id,@"pay_status":pay_status,@"mhtOrderNo":mhtOrderNo};
    [NNNetRequestClass NetRequestPOSTWithRequestURL:[NSString stringWithFormat:@"%@/?c=api_pay&a=returnResult",NNBaseUrl] withParameter:parames withReturnValueBlock:^(id returnValue) {
        self.returnBlock([returnValue objectForKey:@"result"]);
    } withErrorCodeBlock:^(id errorCode) {
        self.errorBlock(errorCode);
    } withFailureBlock:^(id failureBlock) {
        self.failureBlock(failureBlock);
    } withProgress:^(id Progress) {
        
    }];
    

}


@end
