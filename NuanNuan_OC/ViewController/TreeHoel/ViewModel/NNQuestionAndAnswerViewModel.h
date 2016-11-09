//
//  NNQuestionAndAnswerViewModel.h
//  NuanNuan_OC
//
//  Created by 忘、 on 16/11/9.
//  Copyright © 2016年 NuanNuan. All rights reserved.
//

#import "NNBaseViewModel.h"
#import "NNEmotionTeacherModel.h"
@interface NNQuestionAndAnswerViewModel : NNBaseViewModel
@property (nonatomic,strong) NNEmotionTeacherModel *teacherModel;

- (void) getQuestionAndAnswerWithType:(NSString *) type andToken:(NSString *)token andTeacherID:(NSString *)tid andLastQuestionAndAnswerID:(NSString *) lastID andPageNum:(NSString *)pageNum;

@end
