//
//  NNTreeHoelModel.h
//  NuanNuan_OC
//
//  Created by 忘、 on 16/11/7.
//  Copyright © 2016年 NuanNuan. All rights reserved.
//

#import "NNBaseModel.h"

@interface NNTreeHoelModel : NNBaseModel

@property (nonatomic,strong) NSString *thID;
@property (nonatomic,strong) NSString *uid;
@property (nonatomic,strong) NSString *thContent;
@property (nonatomic,strong) NSString *thAnonymity;
@property (nonatomic,strong) NSString *thCommentNum;
@property (nonatomic,strong) NSString *thGoodsNum;
@property (nonatomic,strong) NSString *thIsdel;
@property (nonatomic,strong) NSString *userHeadUrl;
@property (nonatomic,strong) NSString *userNikeName;
@property (nonatomic,assign) NSInteger createTime;
@property (nonatomic,assign) NSInteger modifyTime;
@property (nonatomic,strong) NSArray *picArrays;

@property (nonatomic,assign) BOOL isGood;
@end
