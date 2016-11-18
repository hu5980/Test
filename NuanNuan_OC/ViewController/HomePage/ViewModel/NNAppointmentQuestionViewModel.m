//
//  NNAppointmentQuestionViewModel.m
//  NuanNuan_OC
//
//  Created by 忘、 on 16/11/18.
//  Copyright © 2016年 NuanNuan. All rights reserved.
//

#import "NNAppointmentQuestionViewModel.h"

@implementation NNAppointmentQuestionViewModel

- (void)consultQuestionWithToken:(NSString *)token andUseName:(NSString *)userName andTelphone:(NSString *) tel andSex:(NSString *)sex andQuestion:(NSString *)question andQuestionType:(NSString *)type
{
    NSDictionary *parames = @{@"token":token,@"b_name":userName,@"b_tel":tel,@"b_sex":sex,@"b_description":question,@"bc_id":type};
    
    [NNNetRequestClass NetRequestPOSTWithRequestURL:[NSString stringWithFormat:@"%@/?c=api_booking&a=addBooking",NNBaseUrl] withParameter:parames withReturnValueBlock:^(id returnValue) {
        return self.returnBlock([returnValue objectForKey:@"result"]);
    } withErrorCodeBlock:^(id errorCode) {
        
    } withFailureBlock:^(id failureBlock) {
        
    } withProgress:^(id Progress) {
        
    }];
}
                                                                            

@end
