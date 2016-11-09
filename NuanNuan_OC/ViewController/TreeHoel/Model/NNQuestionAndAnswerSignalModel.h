//
//  NNQuestionAndAnswerSignalModel.h
//  NuanNuan_OC
//
//  Created by 忘、 on 16/11/9.
//  Copyright © 2016年 NuanNuan. All rights reserved.
//

#import "NNBaseModel.h"
#import "NNEmotionTeacherModel.h"
@interface NNQuestionAndAnswerSignalModel : NNBaseModel

@property (nonatomic,strong) NNEmotionTeacherModel *teacherModel;
@property (nonatomic,strong) NSString *questionId;
@property (nonatomic,strong) NSString *questionContent;
@property (nonatomic,strong) NSString *questionCommentNum;
@property (nonatomic,strong) NSString *questionGoodsNum;
@property (nonatomic,strong) NSString *quentionType;
@property (nonatomic,strong) NSString *questionHeadUrl;
@property (nonatomic,strong) NSString *questionNickName;
@property (nonatomic,strong) NSString *questionAnswer;
@property (nonatomic,assign) NSInteger questionCreateTime;


@end
