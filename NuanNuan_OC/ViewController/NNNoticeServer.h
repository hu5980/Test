//
//  NNNoticeServer.h
//  NuanNuan_OC
//
//  Created by 忘、 on 16/12/28.
//  Copyright © 2016年 NuanNuan. All rights reserved.
//

#import "NNBaseViewModel.h"
#import "NNTreeHoelModel.h"
#import "NNCommentModel.h"
#import "NNEmotionTeacherModel.h"
#import "NNQuestionAndAnswerModel.h"

@interface NNNoticeServer : NNBaseViewModel
+ (void)dealWithDictionary:(NSDictionary *)dicInfo andNoticeType:(NSString *)noticeType andisPresent:(BOOL)isPresent andViewController:(UIViewController *)vc;
//+ (NNTreeHoelModel *)analysisTreeHoelDictoModelwithDic :(NSDictionary  *)treeHoleInfo;
//+ (NNCommentModel *)analysiscommentModelwithDic :(NSDictionary  *)commentInfo;
//+ (NNQuestionAndAnswerModel *)analysisQuestionAndAnswerModelwithDic:(NSDictionary  *)dic;
//+ (NNEmotionTeacherModel *)analysisteacherModelwithDic :(NSDictionary *)teacherInfo;

@end
