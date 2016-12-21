//
//  NNQuestionAndAnswerDetailVC.h
//  NuanNuan_OC
//
//  Created by 忘、 on 16/10/12.
//  Copyright © 2016年 NuanNuan. All rights reserved.
//

#import "NNBaseVC.h"
#import "NNQuestionAndAnswerModel.h"
@interface NNQuestionAndAnswerDetailVC : NNBaseVC

@property (nonatomic,strong) NNQuestionAndAnswerModel *signModel;
@property (nonatomic,strong) NSMutableArray *commentMutableArray;
@property (nonatomic,assign) BOOL isFromNotice;

@property (nonatomic,assign) BOOL isComment;

@end
