//
//  NNEmotionTeacherViewModel.h
//  NuanNuan_OC
//
//  Created by 忘、 on 16/10/26.
//  Copyright © 2016年 NuanNuan. All rights reserved.
//

#import "NNBaseViewModel.h"

@interface NNEmotionTeacherViewModel : NNBaseViewModel

- (void)getEmotionTeacherListContentWithLastTeacherID:(NSString *)teacherID andUpdatePageNum:(NSString *)pageNUm  ;

@end
