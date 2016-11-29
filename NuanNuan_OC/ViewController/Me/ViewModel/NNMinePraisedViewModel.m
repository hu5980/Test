//
//  NNMinePraisedViewModel.m
//  NuanNuan_OC
//
//  Created by 忘、 on 16/11/16.
//  Copyright © 2016年 NuanNuan. All rights reserved.
//

#import "NNMinePraisedViewModel.h"
#import "NNQuestionAndAnswerModel.h"
#import "NNTreeHoelModel.h"
#import "NNTimeUtil.h"
#import "NNSuccessCaseModel.h"

@implementation NNMinePraisedViewModel {
    NSString *defaultType;
}

- (void)getMinePraisedContentWithToken:(NSString *)token andPraisedType:(NSString *) type andPraisedId:(NSString *) praisedID andpageNum:(NSString *)pageNum {
    if (praisedID == nil) {
        praisedID = @"";
    }
    defaultType = type;
    NSDictionary *parames = @{@"token":token,@"type":type,@"last_id":praisedID,@"pnum":pageNum};
    
    [NNNetRequestClass NetRequestPOSTWithRequestURL:[NSString stringWithFormat:@"%@/?c=api_good&a=myGoodList",NNBaseUrl] withParameter:parames withReturnValueBlock:^(id returnValue) {
        [self fetchValueSuccessWithDic:returnValue];
    } withErrorCodeBlock:^(id errorCode) {
        
    } withFailureBlock:^(id failureBlock) {
        
    } withProgress:^(id Progress) {
        
    }];
    
}

- (void)fetchValueSuccessWithDic:(NSDictionary *)returnValue {
 
    NSDictionary *dic = [returnValue objectForKey:@"data"];
    NSArray *arrays = [dic objectForKey:@"list"];
    NSMutableArray * praisedArrays = [NSMutableArray arrayWithCapacity:arrays.count];
    if ([defaultType isEqualToString:@"1"]) {
        
        NSString *baseTeacherHeadUrl = [dic objectForKey:@"t_head_path"];
        
        for (int i  = 0; i < arrays.count; i++) {
            NSDictionary *questionAndAnswerDic = [arrays objectAtIndex:i];
            NNQuestionAndAnswerModel *model = [[NNQuestionAndAnswerModel alloc] init];
            model.teacherModel.teacherID = [[questionAndAnswerDic objectForKey:@"teacher"] objectForKey:@"t_id"];
            model.teacherModel.teacherHeadUrl = [NSString stringWithFormat:@"%@/%@",baseTeacherHeadUrl,[[questionAndAnswerDic objectForKey:@"teacher"] objectForKey:@"t_head"]];
            model.teacherModel.teacherNickName = [[questionAndAnswerDic objectForKey:@"teacher"] objectForKey:@"t_nickname"];
            model.questionId = [questionAndAnswerDic objectForKey:@"o_id"];
            model.isGood = YES;
            model.questionHeadUrl = [questionAndAnswerDic objectForKey:@"user_head"];
            model.questionNickName =  [questionAndAnswerDic objectForKey:@"user_nickname"];
            model.questionContent = [questionAndAnswerDic objectForKey:@"user_nickname"];
            model.questionGoodsNum = [questionAndAnswerDic objectForKey:@"q_goods_num"];
            model.questionCommentNum =  [questionAndAnswerDic objectForKey:@"q_comment_num"];
            model.questionCreateTime = [[questionAndAnswerDic objectForKey:@"create_time"] integerValue];
            model.questionAnswer = [questionAndAnswerDic objectForKey:@"q_answer"];
            [praisedArrays addObject:model];
        }
    }else if ([defaultType isEqualToString:@"3"]){
        NSString *basebgUrl = [dic objectForKey:@"a_bg_pic_path"];
        for (int i  = 0; i < arrays.count; i++) {
            NNSuccessCaseModel *model = [[NNSuccessCaseModel alloc] init];
            model.caseTitle = [arrays[i] objectForKey:@"a_title"];
            model.caseName = [arrays[i] objectForKey:@"ac_name"];
            model.caseImageUrl = [NSString stringWithFormat:@"%@/%@",basebgUrl,[arrays[i] objectForKey:@"a_bg_pic"]] ;
            model.caseAdID = [[arrays[i] objectForKey:@"o_id"] integerValue];
            model.caseGoodsNum = [[arrays[i] objectForKey:@"a_goods_num"] integerValue];
            model.caseClickNum = [[arrays[i] objectForKey:@"a_click_num"] integerValue];
            model.caseCreateTime = [[arrays[i] objectForKey:@"create_time"] integerValue];
            [praisedArrays addObject:model];
        }
    }
    else{
        NSString *basePathUrl = [dic objectForKey:@"th_pic_path"];
        for (int i  = 0; i < arrays.count; i++) {
            NSDictionary *treeHoelDic = [arrays objectAtIndex:i];
            NNTreeHoelModel *model = [[NNTreeHoelModel alloc] init];
            model.isGood =  YES;// [[treeHoelDic objectForKey:@"has_good"] boolValue];
            model.thID =[treeHoelDic objectForKey:@"o_id"];
          
            model.thContent = [treeHoelDic objectForKey:@"th_content"];
            NSString  *picString =  [treeHoelDic objectForKey:@"th_pics"];
            NSData *jsonData = [picString dataUsingEncoding:NSUTF8StringEncoding];
            NSArray *picArrays = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableLeaves error:nil];
            NSMutableArray *picMutableArrays = [NSMutableArray array];
            for (int j= 0; j < picArrays.count; j++) {
                [picMutableArrays addObject:[NSString stringWithFormat:@"%@/%@",basePathUrl,[picArrays objectAtIndex:j]]];
            }
            model.picArrays = picMutableArrays;
            model.thCommentNum =[treeHoelDic objectForKey:@"th_comment_num"];
            model.thGoodsNum =[treeHoelDic objectForKey:@"th_goods_num"];
            model.userHeadUrl = [treeHoelDic objectForKey:@"user_head"];
            model.userNikeName = [treeHoelDic objectForKey:@"user_nickname"];
            model.createTime = [[treeHoelDic objectForKey:@"create_time"] integerValue];
            [praisedArrays addObject:model];
        }
    }
    
    self.returnBlock(praisedArrays);
}

@end
