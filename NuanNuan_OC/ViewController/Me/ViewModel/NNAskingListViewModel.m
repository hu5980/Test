//
//  NNAskingViewModel.m
//  NuanNuan_OC
//
//  Created by 忘、 on 16/12/13.
//  Copyright © 2016年 NuanNuan. All rights reserved.
//

#import "NNAskingListViewModel.h"
#import "NNQuestionAndAnswerModel.h"
#import "NNEmotionTeacherModel.h"
@implementation NNAskingListViewModel
- (void)getAnswerListWithToken:(NSString *)token andHasAnswer:(NSString *)hadAnswer andLastId:(NSString *)lastID andpageNum:(NSString *)pageNum {
    NSDictionary *parames = @{@"token":token,@"has_answer":hadAnswer,@"last_id":lastID,@"pnum":pageNum};
    
    [NNNetRequestClass NetRequestPOSTWithRequestURL:[NSString stringWithFormat:@"%@/?c=api_question&a=getMyQuestionList",NNBaseUrl] withParameter:parames withReturnValueBlock:^(id returnValue) {
        NSLog(@"%@",returnValue);
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
        NNEmotionTeacherModel *teacherModel = [[NNEmotionTeacherModel alloc] init];

        teacherModel.teacherHeadUrl = [NSString stringWithFormat:@"%@/%@",[questionAndAnswerDic objectForKey:@"t_head_path"],[questionAndAnswerDic objectForKey:@"t_head"]];
        teacherModel.backgroundImageUrl = [NSString stringWithFormat:@"%@/%@",[questionAndAnswerDic objectForKey:@"t_bg_pic_path"],[questionAndAnswerDic objectForKey:@"t_bg_pic"]];
        teacherModel.teacherTypeName = [questionAndAnswerDic objectForKey:@"t_good_at"];
        teacherModel.teacherNickName = [questionAndAnswerDic objectForKey:@"t_nickname"];
        signalModel.teacherModel = teacherModel;
        signalModel.questionId = [questionAndAnswerDic objectForKey:@"q_id"];
        signalModel.questionContent = [questionAndAnswerDic objectForKey:@"q_content"];
        signalModel.questionCommentNum = [questionAndAnswerDic objectForKey:@"q_comment_num"];
        signalModel.questionGoodsNum = [questionAndAnswerDic objectForKey:@"q_goods_num"];
        signalModel.questionAnswer = [questionAndAnswerDic objectForKey:@"q_answer"];
        signalModel.questionCreateTime = [[questionAndAnswerDic objectForKey:@"create_time"] integerValue];
        signalModel.questionHeadUrl = [questionAndAnswerDic objectForKey:@"user_head"];
        signalModel.questionNickName = [questionAndAnswerDic objectForKey:@"user_nickname"];
        signalModel.isGood = [[questionAndAnswerDic objectForKey:@"has_good"] boolValue];
        [questionAndAnswerListArray addObject:signalModel];
    }
    
    self.returnBlock(questionAndAnswerListArray);
}

@end
