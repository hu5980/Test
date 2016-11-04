//
//  NNAskingViewModel.m
//  NuanNuan_OC
//
//  Created by 忘、 on 16/11/4.
//  Copyright © 2016年 NuanNuan. All rights reserved.
//

#import "NNAskingViewModel.h"

@implementation NNAskingViewModel

- (void)askingQuestionWithToken:(NSString *)token andTeacherID:(NSString *)teacherID andQuestionType:(NSString *)questionType andQuestionContent:(NSString *)content {
    NSDictionary *parames = @{@"token":token,@"t_id":teacherID,@"qc_id":questionType,@"q_content":content};
    
    [NNNetRequestClass NetRequestPOSTWithRequestURL:[NSString stringWithFormat:@"%@/?c=api_question&a=addQuestion",NNBaseUrl] withParameter:parames withReturnValueBlock:^(id returnValue) {
        NSLog(@"%@",returnValue);
        self.returnBlock([returnValue objectForKey:@"result"]);
    } withErrorCodeBlock:^(id errorCode) {
        self.errorBlock(errorCode);
    } withFailureBlock:^(id failureBlock) {
        self.failureBlock(failureBlock);
    } withProgress:^(id Progress) {
        
    }];
}

@end
