//
//  NNAppointmentModel.h
//  NuanNuan_OC
//
//  Created by 忘、 on 16/11/18.
//  Copyright © 2016年 NuanNuan. All rights reserved.
//

#import "NNBaseModel.h"

@interface NNAppointmentModel : NNBaseModel

@property (nonatomic,strong) NSString *appointmentID;
@property (nonatomic,strong) NSString *appointmentTitle;
@property (nonatomic,strong) NSString *appointmentState;

@end
