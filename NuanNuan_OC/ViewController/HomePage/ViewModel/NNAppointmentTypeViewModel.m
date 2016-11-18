//
//  NNAppointmentTypeViewModel.m
//  NuanNuan_OC
//
//  Created by 忘、 on 16/11/18.
//  Copyright © 2016年 NuanNuan. All rights reserved.
//

#import "NNAppointmentTypeViewModel.h"

@implementation NNAppointmentTypeViewModel

- (void)getAllAppointTypeWithToken:(NSString *)token {
    NSDictionary *parames = @{@"token":token};
    [NNNetRequestClass NetRequestPOSTWithRequestURL:[NSString stringWithFormat:@"%@/?c=api_booking&a=getAllBc",NNBaseUrl] withParameter:parames withReturnValueBlock:^(id returnValue) {
        [self fetchValueSuccessWithDic:returnValue];
    } withErrorCodeBlock:^(id errorCode) {
        
    } withFailureBlock:^(id failureBlock) {
        
    } withProgress:^(id Progress) {
        
    }];
}


- (void)fetchValueSuccessWithDic:(NSDictionary *)returnValue {
    NSArray *arrays = [returnValue objectForKey:@"data"];
    NSMutableArray *appointmentArrays = [NSMutableArray arrayWithCapacity:arrays.count];
    for (int i =0; i < arrays.count; i++) {
        NNAppointmentModel *model = [[NNAppointmentModel alloc] init];
        model.appointmentID = [[arrays objectAtIndex:i] objectForKey:@"bc_id"];
        model.appointmentTitle = [[arrays objectAtIndex:i] objectForKey:@"bc_name"];
        model.appointmentState = [[arrays objectAtIndex:i] objectForKey:@"bc_status"];
        [appointmentArrays addObject:model];
    }
    return self.returnBlock(appointmentArrays);
}

@end
