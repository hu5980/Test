//
//  NNEmotionTeacherModel.h
//  NuanNuan_OC
//
//  Created by 忘、 on 16/10/26.
//  Copyright © 2016年 NuanNuan. All rights reserved.
//

#import "NNBaseModel.h"

@interface NNEmotionTeacherModel : NNBaseModel

@property (nonatomic,strong) NSString *teacherID;
@property (nonatomic,strong) NSString *teacherHeadUrl;
@property (nonatomic,strong) NSString *backgroundImageUrl;
@property (nonatomic,strong) NSString *teacherNickName;
@property (nonatomic,strong) NSString *teacherDescription;
@property (nonatomic,strong) NSString *teacherQuestionNum;
@property (nonatomic,strong) NSString *teacherTypeName;
@end
