//
//  NNAppointmentQuestionViewModel.h
//  NuanNuan_OC
//
//  Created by 忘、 on 16/11/18.
//  Copyright © 2016年 NuanNuan. All rights reserved.
//

#import "NNBaseViewModel.h"

@interface NNAppointmentQuestionViewModel : NNBaseViewModel
- (void)consultQuestionWithToken:(NSString *)token andUseName:(NSString *)userName andTelphone:(NSString *) tel andSex:(NSString *)sex andQuestion:(NSString *)question andQuestionType:(NSString *)type;
@end
