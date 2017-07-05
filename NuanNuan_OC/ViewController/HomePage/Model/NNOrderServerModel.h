//
//  NNOrderModel.h
//  NuanNuan_OC
//
//  Created by 胡光耀 on 2017/6/4.
//  Copyright © 2017年 NuanNuan. All rights reserved.
//

#import "NNBaseModel.h"

@interface NNOrderServerModel : NNBaseModel
@property (nonatomic,strong) NSString *orderServerId;
@property (nonatomic,strong) NSString *orderTitle;
@property (nonatomic,strong) NSString *g_discount_price;
@property (nonatomic,strong) NSString *orderAttach;
@property (nonatomic,strong) NSString *orderUmon;
@property (nonatomic,strong) NSString *orderPrice;
@property (nonatomic,strong) NSString *orderDiscountPrice;
@property (nonatomic,strong) NSString *orderDiscribution;
@property (nonatomic,strong) NSString *orderOnLine;
@property (nonatomic,strong) NSString *orderIsDel;
@end
