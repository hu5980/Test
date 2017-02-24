//
//  NNMineCommentViewModel.m
//  NuanNuan_OC
//
//  Created by hu5980 on 16/11/23.
//  Copyright © 2016年 NuanNuan. All rights reserved.
//

#import "NNMineCommentViewModel.h"
#import "NNQuestionAndAnswerCommentModel.h"
#import "NNSpitslotCommentModel.h"
@implementation NNMineCommentViewModel

- (void)getMineCommentWithToken:(NSString *)token andCommentType:(NSString *)type andLastComentID:(NSString *)lastID
                        andDown:(NSString *)down andPageNum:(NSString *)pageNum {
    if (lastID == nil) {
        lastID = @"";
    }
    
    NSDictionary *parames = @{@"token":token,@"type":type,@"last_id":lastID,@"down":down,@"pnum":pageNum};
    [NNNetRequestClass NetRequestPOSTWithRequestURL:[NSString stringWithFormat:@"%@/?c=api_comment&a=getMyCommentList",NNBaseUrl] withParameter:parames withReturnValueBlock:^(id returnValue) {
        NNLog(@"%@",returnValue);
        [self fetchValueSuccessWithDic:returnValue withType:type];
    } withErrorCodeBlock:^(id errorCode) {
        NNLog(@"%@",errorCode);
    } withFailureBlock:^(id failureBlock) {
        NNLog(@"%@",failureBlock);
    } withProgress:^(id Progress) {
        
    }];
}

- (void)fetchValueSuccessWithDic:(NSDictionary *)returnValue withType:(NSString *)type {
    NSMutableArray * mineCommentArrays;
    NSArray *list = [[returnValue objectForKey:@"data"] objectForKey:@"list"];
    mineCommentArrays = [NSMutableArray arrayWithCapacity:list.count];
    if ([type isEqualToString:@"1"]) {
        NSString *teacherHeadUrl = [[returnValue objectForKey:@"data"] objectForKey:@"t_head_path"];
        NSString *teacherBgUrl = [[returnValue objectForKey:@"data"] objectForKey:@"t_bg_pic_path"];
        
        
        for ( int i  =0; i < list.count; i++) {
            NSDictionary *dic = [list objectAtIndex:i];
            NNQuestionAndAnswerCommentModel *model = [[NNQuestionAndAnswerCommentModel alloc] init];
            model.commentID = [dic objectForKey:@"c_id"];
            model.comment = [dic objectForKey:@"c_content"];
            NNQuestionAndAnswerModel *questionAndAnswerModelmodel = [[NNQuestionAndAnswerModel alloc] init];
            NNEmotionTeacherModel *teacherModel = [[NNEmotionTeacherModel alloc] init];
            teacherModel.teacherID = [dic objectForKey:@"t_id"];
            teacherModel.teacherHeadUrl = [NSString stringWithFormat:@"%@/%@",teacherHeadUrl,[dic objectForKey:@"t_head"]];
            teacherModel.teacherNickName = [dic objectForKey:@"t_nickname"];
            teacherModel.backgroundImageUrl = [NSString stringWithFormat:@"%@/%@",teacherBgUrl,[dic objectForKey:@"t_bg_pic"]];
            questionAndAnswerModelmodel.teacherModel = teacherModel;
            questionAndAnswerModelmodel.questionId = [dic objectForKey:@"o_id"];
            questionAndAnswerModelmodel.isGood = [[dic objectForKey:@"has_good"] boolValue];
            questionAndAnswerModelmodel.questionAnswer = [dic objectForKey:@"q_answer"];
            questionAndAnswerModelmodel.questionCommentNum = [dic objectForKey:@"q_comment_num"];
            questionAndAnswerModelmodel.questionContent = [dic objectForKey:@"q_content"];
            questionAndAnswerModelmodel.questionGoodsNum = [dic objectForKey:@"q_goods_num"];
            questionAndAnswerModelmodel.questionNickName = [dic objectForKey:@"user_nickname"];
            questionAndAnswerModelmodel.questionHeadUrl = [dic objectForKey:@"user_head"];
            model.questionAndAnswerModelmodel = questionAndAnswerModelmodel;
            [mineCommentArrays addObject:model];
        }
    }else{
        for(int i = 0; i < list.count ;i++) {
            
            NSDictionary *dic = [list objectAtIndex:i];
            NSString *basePathUrl = [[returnValue objectForKey:@"data"] objectForKey:@"th_pic_path"];
            NNSpitslotCommentModel *model = [[NNSpitslotCommentModel alloc] init];
            model.commentID = [dic objectForKey:@"c_id"];
            model.comment = [dic objectForKey:@"c_content"];
            NSString  *picString =  [dic objectForKey:@"th_pics"];
            NSData *jsonData = [picString dataUsingEncoding:NSUTF8StringEncoding];
            NSArray *picArrays = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableLeaves error:nil];
            NSMutableArray *picMutableArrays = [NSMutableArray array];
            for (int j= 0; j < picArrays.count; j++) {
                [picMutableArrays addObject:[NSString stringWithFormat:@"%@/%@",basePathUrl,[picArrays objectAtIndex:j]]];
            }
            
            NNTreeHoelModel *treeHoelModel = [[NNTreeHoelModel alloc] init];
            treeHoelModel.thID = [dic objectForKey:@"o_id"];
            treeHoelModel.isGood = [[dic objectForKey:@"has_good"] boolValue];
            treeHoelModel.uid = [dic objectForKey:@"uid"];
            treeHoelModel.thContent = [dic objectForKey:@"th_content"];
            treeHoelModel.picArrays = picMutableArrays;
            treeHoelModel.thAnonymity = [dic objectForKey:@"th_anonymity"];
            treeHoelModel.thCommentNum =[dic objectForKey:@"th_comment_num"];
            treeHoelModel.isGood = [[dic objectForKey:@"has_good"] boolValue];
            treeHoelModel.thGoodsNum =[dic objectForKey:@"th_goods_num"];
            treeHoelModel.userHeadUrl = [dic objectForKey:@"user_head"];
            treeHoelModel.userNikeName = [dic objectForKey:@"user_nickname"];
            treeHoelModel.createTime = [[dic objectForKey:@"create_time"] integerValue];
            treeHoelModel.modifyTime =[[dic objectForKey:@"modify_time"] integerValue];
            model.treeHoelModel = treeHoelModel;
            [mineCommentArrays addObject:model];
        }
    }
    self.returnBlock(mineCommentArrays);
}

@end
