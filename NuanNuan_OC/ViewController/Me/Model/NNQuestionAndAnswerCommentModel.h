//
//  NNQuestionAndAnswerCommentModel.h
//  NuanNuan_OC
//
//  Created by 胡光耀 on 16/11/23.
//  Copyright © 2016年 NuanNuan. All rights reserved.
//

#import "NNBaseModel.h"
#import "NNQuestionAndAnswerModel.h"
@interface NNQuestionAndAnswerCommentModel : NNBaseModel
@property (nonatomic,strong) NSString *commentID;
@property (nonatomic,strong) NSString *comment;
@property (nonatomic,strong) NNQuestionAndAnswerModel *questionAndAnswerModelmodel;
@end
