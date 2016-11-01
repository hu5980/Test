//
//  NNEmotionTeacherViewModel.m
//  NuanNuan_OC
//
//  Created by 忘、 on 16/10/26.
//  Copyright © 2016年 NuanNuan. All rights reserved.
//

#import "NNEmotionTeacherViewModel.h"
#import "NNEmotionTeacherModel.h"
@implementation NNEmotionTeacherViewModel

- (void)getEmotionTeacherListContentWithLastTeacherID:(NSString *)teacherID andUpdatePageNum:(NSString *)pageNum {
    NSDictionary *parames;
    if (teacherID == nil) {
        parames = @{@"last_id":@"0",@"pnum":pageNum};
    }else{
        parames = @{@"last_id":teacherID,@"pnum":pageNum};
    }
    
    
    
    [NNNetRequestClass NetRequestGETWithRequestURL:[NSString stringWithFormat:@"%@/?c=api_teacher&a=getTeacherList",NNBaseUrl] withParameter:parames withReturnValueBlock:^(id returnValue) {
        NNLog(@"%@",returnValue);
        [self fetchValueSuccessWithDic:returnValue];
    } withErrorCodeBlock:^(id errorCode) {
        
    } withFailureBlock:^(id failureBlock) {
        
    } withProgress:^(id Progress) {
        
    }];
}

-(void)fetchValueSuccessWithDic: (NSDictionary *) returnValue {
    NSMutableArray *mutableArrays = [NSMutableArray array];
    NSDictionary *dic = [returnValue objectForKey:@"data"];
    NSString *headBaseUrl = [dic objectForKey:@"t_head_path"];
    NSString *backgroundBaseUrl = [dic objectForKey:@"t_bg_pic_path"];
    
    NSArray *listArray = [dic objectForKey:@"list"];
    for (int i = 0; i < listArray.count; i++) {
        NNEmotionTeacherModel *model = [[NNEmotionTeacherModel alloc] init];
        model.teacherID = [listArray[i] objectForKey:@"t_id"] ;
        model.teacherHeadUrl = [NSString stringWithFormat:@"%@/%@",headBaseUrl,[listArray[i] objectForKey:@"t_head"]] ;
        model.backgroundImageUrl =  [NSString stringWithFormat:@"%@/%@",backgroundBaseUrl,[listArray[i] objectForKey:@"t_bg_pic"]] ;
        model.teacherDescription = [listArray[i] objectForKey:@"t_description"] ;
        model.teacherQuestionNum = [listArray[i] objectForKey:@"t_question_num"] ;
        model.teacherTypeName = [listArray[i] objectForKey:@"qc_name"] ;
        model.teacherNickName =  [listArray[i] objectForKey:@"t_nickname"] ;
        model.teacherQualifications =  [listArray[i] objectForKey:@"t_qualifications"] ;
        [mutableArrays addObject:model];
    }
    self.returnBlock(mutableArrays);
}

@end
