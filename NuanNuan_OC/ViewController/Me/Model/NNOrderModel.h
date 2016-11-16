//
//  NNOrderModel.h
//  NuanNuan_OC
//
//  Created by 忘、 on 16/11/15.
//  Copyright © 2016年 NuanNuan. All rights reserved.
//

#import "NNBaseModel.h"

@interface NNOrderModel : NNBaseModel
@property (nonatomic,strong) NSString * orderID;
@property (nonatomic,strong) NSString *orderUserName;
@property (nonatomic,strong) NSString * orderSex;
@property (nonatomic,strong) NSString *orderTelephone;
@property (nonatomic,strong) NSString * orderTime;
@property (nonatomic,strong) NSString *orderType;
@property (nonatomic,strong) NSString * orderContent;


@end
