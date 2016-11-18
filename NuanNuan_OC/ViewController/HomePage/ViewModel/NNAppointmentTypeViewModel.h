//
//  NNAppointmentTypeViewModel.h
//  NuanNuan_OC
//
//  Created by 忘、 on 16/11/18.
//  Copyright © 2016年 NuanNuan. All rights reserved.
//

#import "NNBaseViewModel.h"
#import "NNAppointmentModel.h"
@interface NNAppointmentTypeViewModel : NNBaseViewModel
- (void)getAllAppointTypeWithToken:(NSString *)token;
@end
