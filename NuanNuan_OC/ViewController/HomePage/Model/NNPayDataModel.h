//
//  NNPayDataModel.h
//  NuanNuan_OC
//
//  Created by 胡光耀 on 2017/6/11.
//  Copyright © 2017年 NuanNuan. All rights reserved.
//

#import "NNBaseModel.h"

@interface NNPayDataModel : NNBaseModel

@property (nonatomic,strong) NSString *appid;
@property (nonatomic,strong) NSString *mhtOrderNo;
@property (nonatomic,strong) NSString *mhtOrderName;
@property (nonatomic,strong) NSString *mhtOrderAmt;
@property (nonatomic,strong) NSString *mhtOrderDetail;
@property (nonatomic,strong) NSString *mhtOrderStartTime;
@property (nonatomic,strong) NSString *mhtReserved;
@property (nonatomic,strong) NSString *mhtNotifyUrl;
@property (nonatomic,strong) NSString *mhtOrderType;
@property (nonatomic,strong) NSString *mhtCurrentType;
@property (nonatomic,strong) NSString *mhtOrderTimeOut;
@property (nonatomic,strong) NSString *mhtCharset;
@property (nonatomic,strong) NSString *mhtSignature;
@end
