//
//  NNAskingViewModel.h
//  NuanNuan_OC
//
//  Created by 忘、 on 16/11/4.
//  Copyright © 2016年 NuanNuan. All rights reserved.
//

#import "NNBaseViewModel.h"

@interface NNAskingViewModel : NNBaseViewModel

- (void)askingQuestionWithToken:(NSString *)token andTeacherID:(NSString *)teacherID andQuestionType:(NSString *)questionType andQuestionContent:(NSString *)content;

@end
