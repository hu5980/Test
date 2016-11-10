//
//  NNQuestionAndAnswerViewModel.m
//  NuanNuan_OC
//
//  Created by 忘、 on 16/11/9.
//  Copyright © 2016年 NuanNuan. All rights reserved.
//

#import "NNQuestionAndAnswerViewModel.h"
#import "NNQuestionAndAnswerModel.h"

@implementation NNQuestionAndAnswerViewModel
- (void) getQuestionAndAnswerWithType:(NSString *) type andToken:(NSString *)token andTeacherID:(NSString *)tid andLastQuestionAndAnswerID:(NSString *) lastID andPageNum:(NSString *)pageNum {
    if (lastID == nil) {
        lastID = @"0";
    }
    
    NSDictionary *parames = @{@"token":token,@"t_id":tid,@"last_id":lastID,@"pnum":pageNum,@"type":type};
    
    [NNNetRequestClass NetRequestPOSTWithRequestURL:[NSString stringWithFormat:@"%@/?c=api_question&a=getQuestionList",NNBaseUrl] withParameter:parames withReturnValueBlock:^(id returnValue) {
        NNLog(@"%@",returnValue);
        [self fetchValueSuccessWithDic:returnValue];
    } withErrorCodeBlock:^(id errorCode) {
        
    } withFailureBlock:^(id failureBlock) {
        
    } withProgress:^(id Progress) {
        
    }];
}

- (void)fetchValueSuccessWithDic:(NSDictionary *)returnValue {
    
 
    NSArray *questionAndAnswerArray = [returnValue objectForKey:@"data"];
    NSMutableArray *questionAndAnswerListArray = [NSMutableArray arrayWithCapacity:questionAndAnswerArray.count];
    for (int i  = 0; i < questionAndAnswerArray.count; i++) {
        NSDictionary *questionAndAnswerDic = [questionAndAnswerArray objectAtIndex:i];
        NNQuestionAndAnswerModel *signalModel = [[NNQuestionAndAnswerModel alloc] init];
        signalModel.teacherModel = _teacherModel;
        signalModel.questionId = [questionAndAnswerDic objectForKey:@"q_id"];
        signalModel.questionContent = [questionAndAnswerDic objectForKey:@"q_content"];
        signalModel.questionCommentNum = [questionAndAnswerDic objectForKey:@"q_comment_num"];
        signalModel.questionGoodsNum = [questionAndAnswerDic objectForKey:@"q_goods_num"];
        signalModel.questionAnswer = [questionAndAnswerDic objectForKey:@"q_answer"];
        signalModel.questionCreateTime = [[questionAndAnswerDic objectForKey:@"create_time"] integerValue];
        signalModel.quentionType = [questionAndAnswerDic objectForKey:@"qc_name"];
        signalModel.questionHeadUrl = [questionAndAnswerDic objectForKey:@"user_head"];
        signalModel.questionNickName = [questionAndAnswerDic objectForKey:@"user_nickname"];
        signalModel.isGood = [[questionAndAnswerDic objectForKey:@"has_good"] boolValue];
        [questionAndAnswerListArray addObject:signalModel];
    }
   
    self.returnBlock(questionAndAnswerListArray);
}

@end
