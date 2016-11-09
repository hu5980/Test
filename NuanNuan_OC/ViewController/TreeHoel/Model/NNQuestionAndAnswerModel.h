//
//  NNQuestionAndAnswerModel.h
//  NuanNuan_OC
//
//  Created by 忘、 on 16/11/9.
//  Copyright © 2016年 NuanNuan. All rights reserved.
//

#import "NNBaseModel.h"
#import "NNEmotionTeacherModel.h"
#import "NNQuestionAndAnswerSignalModel.h"

@interface NNQuestionAndAnswerModel : NNBaseModel

@property (nonatomic,strong) NSString *questionNum;
@property (nonatomic,strong) NSString *answerNum;
@property (nonatomic,strong) NSMutableArray <NNQuestionAndAnswerSignalModel *> *questionAndAnswerListArray;

@end
