//
//  NNNoticeServer.m
//  NuanNuan_OC
//
//  Created by 忘、 on 16/12/28.
//  Copyright © 2016年 NuanNuan. All rights reserved.
//

#import "NNNoticeServer.h"
#import "NNSpitslotDetailVC.h"
#import "NNQuestionAndAnswerDetailVC.h"


@implementation NNNoticeServer

+ (NNTreeHoelModel *)analysisTreeHoelDictoModelwithDic :(NSDictionary  *)treeHoleInfo {
    NNTreeHoelModel *treeHoelModel = [[NNTreeHoelModel alloc] init];
    treeHoelModel.thID = [treeHoleInfo objectForKey:@"th_id"];
    treeHoelModel.isGood = [[treeHoleInfo objectForKey:@"has_good"] boolValue];
    treeHoelModel.uid = [treeHoleInfo objectForKey:@"uid"];
    treeHoelModel.thContent = [treeHoleInfo objectForKey:@"th_content"];
    NSString *basePathUrl = [treeHoleInfo objectForKey:@"th_pic_path"];
    NSString  *picString =  [treeHoleInfo objectForKey:@"th_pics"];
    NSData *jsonData = [picString dataUsingEncoding:NSUTF8StringEncoding];
    NSArray *picArrays = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableLeaves error:nil];
    NSMutableArray *picMutableArrays = [NSMutableArray array];
    for (int j= 0; j < picArrays.count; j++) {
        [picMutableArrays addObject:[NSString stringWithFormat:@"%@/%@",basePathUrl,[picArrays objectAtIndex:j]]];
    }
    treeHoelModel.picArrays = picMutableArrays;
    treeHoelModel.thAnonymity = [treeHoleInfo objectForKey:@"th_anonymity"];
    treeHoelModel.thCommentNum =[treeHoleInfo objectForKey:@"th_comment_num"];
    treeHoelModel.thGoodsNum =[treeHoleInfo objectForKey:@"th_goods_num"];
    treeHoelModel.userHeadUrl = [treeHoleInfo objectForKey:@"user_head"];
    treeHoelModel.userNikeName = [treeHoleInfo objectForKey:@"user_nickname"];
    treeHoelModel.createTime = [[treeHoleInfo objectForKey:@"create_time"] integerValue];
    treeHoelModel.modifyTime = [[treeHoleInfo objectForKey:@"modify_time"] integerValue];
    
    return treeHoelModel;
}

+ (NNCommentModel *)analysiscommentModelwithDic :(NSDictionary  *)commentInfo {
    
    NNCommentModel *commentModel = [[NNCommentModel alloc] init];
    commentModel.commentID = [commentInfo objectForKey:@"c_id"];
    commentModel.commentUID = [commentInfo objectForKey:@"uid"];
    commentModel.commentOID = [commentInfo objectForKey:@"o_id"];
    commentModel.commentType = [commentInfo objectForKey:@"c_type"];
    commentModel.commentContent = [commentInfo objectForKey:@"c_content"];
    commentModel.commentGoodsNum = [commentInfo objectForKey:@"c_goods_num"];
    commentModel.commentIsdel = [commentInfo objectForKey:@"c_isdel"];
    commentModel.commentNickName = [commentInfo objectForKey:@"user_nickname"];
    commentModel.commentCreateTime = [[commentInfo objectForKey:@"create_time"] integerValue];
    commentModel.commentModifyTime = [[commentInfo objectForKey:@"modify_time"] integerValue];
    return commentModel;
}


+ (NNQuestionAndAnswerModel *)analysisQuestionAndAnswerModelwithDic:(NSDictionary  *)dic{
    NNQuestionAndAnswerModel *signalModel = [[NNQuestionAndAnswerModel alloc] init];
    NSDictionary *teacherInfo = [dic objectForKey:@"teacher_info"];
    NNEmotionTeacherModel *teacherModel = [self analysisteacherModelwithDic:teacherInfo];
    NSDictionary *questionInfo = [dic objectForKey:@"question_info"];
    signalModel.teacherModel = teacherModel;
    signalModel.questionId = [questionInfo objectForKey:@"q_id"];
    signalModel.questionContent = [questionInfo objectForKey:@"q_content"];
    signalModel.questionCommentNum = [questionInfo objectForKey:@"q_comment_num"];
    signalModel.questionGoodsNum = [questionInfo objectForKey:@"q_goods_num"];
    signalModel.questionAnswer = [questionInfo objectForKey:@"q_answer"];
    signalModel.questionCreateTime = [[questionInfo objectForKey:@"create_time"] integerValue];
    signalModel.questionHeadUrl = [questionInfo objectForKey:@"user_head"];
    signalModel.questionNickName = [questionInfo objectForKey:@"user_nickname"];
    signalModel.isGood = [[questionInfo objectForKey:@"has_good"] boolValue];
    
    return signalModel;
}

+ (NNEmotionTeacherModel *)analysisteacherModelwithDic :(NSDictionary *)teacherInfo {
    NNEmotionTeacherModel *teacherModel = [[NNEmotionTeacherModel alloc] init];
    teacherModel.teacherHeadUrl = [NSString stringWithFormat:@"%@/%@",[teacherInfo objectForKey:@"t_head_path"],[teacherInfo objectForKey:@"t_head"]];
    teacherModel.backgroundImageUrl = [NSString stringWithFormat:@"%@/%@",[teacherInfo objectForKey:@"t_bg_pic_path"],[teacherInfo objectForKey:@"t_bg_pic"]];
    teacherModel.teacherTypeName = [teacherInfo objectForKey:@"t_good_at"];
    teacherModel.teacherNickName = [teacherInfo objectForKey:@"t_nickname"];
    return teacherModel;
}


+ (void)dealWithDictionary:(NSDictionary *)dicInfo andNoticeType:(NSString *)noticeType andisPresent:(BOOL)isPresent andViewController:(UIViewController *)vc {

    if ([noticeType isEqualToString:@"3"]) {
        NSDictionary *commentInfo = [dicInfo  objectForKey:@"comment_info"];
        NSDictionary *treeHoleInfo = [dicInfo objectForKey:@"treehole_info"];
        NSDictionary *userInfo = [dicInfo objectForKey:@"user_info"];
        NNTreeHoelModel *treeHoelModel  = [NNNoticeServer analysisTreeHoelDictoModelwithDic:treeHoleInfo];
        NNCommentModel *commentModel = [NNNoticeServer analysiscommentModelwithDic:commentInfo];
        commentModel.commentHeaderUrl = [userInfo objectForKey:@"head"];
        
        NNSpitslotDetailVC *spitslotDetailVC = [[NNSpitslotDetailVC alloc] init];
        spitslotDetailVC.model = treeHoelModel;
        spitslotDetailVC.isFromNotice = YES;
        spitslotDetailVC.commentMutableArray = [NSMutableArray arrayWithObject:commentModel];
        spitslotDetailVC.isPresent = isPresent;
        
        if (isPresent) {
            UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:spitslotDetailVC];
            [vc presentViewController:nav animated:YES completion:nil];
        }else{
            [vc.navigationController pushViewController:spitslotDetailVC animated:YES];
        }
    }else if ([noticeType isEqualToString:@"5"]){
        
        NSDictionary *treeHoleInfo = [dicInfo objectForKey:@"treehole_info"];
        NNTreeHoelModel *treeHoelModel  = [NNNoticeServer analysisTreeHoelDictoModelwithDic:treeHoleInfo];
        NNSpitslotDetailVC *spitslotDetailVC = [[NNSpitslotDetailVC alloc] init];
        spitslotDetailVC.model = treeHoelModel;
        spitslotDetailVC.isFromNotice = YES;
        spitslotDetailVC.commentMutableArray = nil;
        spitslotDetailVC.isPresent = isPresent;
        if (isPresent) {
             UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:spitslotDetailVC];
            [vc presentViewController:nav animated:YES completion:nil];
        }else{
            [vc.navigationController pushViewController:spitslotDetailVC animated:YES];
        }
    }else if ([noticeType isEqualToString:@"1"]){
        NNQuestionAndAnswerDetailVC *questionAndAnswerVC = [[NNQuestionAndAnswerDetailVC alloc] init];
        questionAndAnswerVC.isFromNotice = YES;
        questionAndAnswerVC.signModel = [NNNoticeServer analysisQuestionAndAnswerModelwithDic:dicInfo];
        questionAndAnswerVC.isPresent = isPresent;
        if (isPresent) {
            UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:questionAndAnswerVC];
            [vc presentViewController:nav animated:YES completion:nil];
        }else{
            [vc.navigationController pushViewController:questionAndAnswerVC animated:YES];
        }
    }else if ([noticeType isEqualToString:@"2"]){
        NSDictionary *commentInfo = [dicInfo  objectForKey:@"comment_info"];
        NNCommentModel *commentModel = [NNNoticeServer analysiscommentModelwithDic:commentInfo];
        NNQuestionAndAnswerDetailVC *questionAndAnswerVC = [[NNQuestionAndAnswerDetailVC alloc] init];
        questionAndAnswerVC.isFromNotice = YES;
        questionAndAnswerVC.commentMutableArray = [NSMutableArray arrayWithObject:commentModel];
        questionAndAnswerVC.signModel = [NNNoticeServer analysisQuestionAndAnswerModelwithDic:dicInfo];
        questionAndAnswerVC.isPresent = isPresent;
        if (isPresent) {
             UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:questionAndAnswerVC];
            [vc presentViewController:nav animated:YES completion:nil];
            
        }else{
            [vc.navigationController pushViewController:questionAndAnswerVC animated:YES];
        }

        
    }

}


@end
