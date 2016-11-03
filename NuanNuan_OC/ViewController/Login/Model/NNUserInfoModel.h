//
//  NNUserInfoModel.h
//  NuanNuan_OC
//
//  Created by 忘、 on 16/11/3.
//  Copyright © 2016年 NuanNuan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NNUserInfoModel : NSObject
@property (nonatomic,assign) NSInteger uid;
@property (nonatomic,strong) NSString *headImageUrl;
@property (nonatomic,strong) NSString *nickName;
@property (nonatomic,assign) NSInteger sex;
@property (nonatomic,strong) NSString *telphone;
@property (nonatomic,strong) NSString * usable;
@property (nonatomic,strong) NSString *userDescription;
@property (nonatomic,assign) NSInteger channel;
@property (nonatomic,assign) NSInteger creatTime;
@property (nonatomic,assign) NSInteger modifyTime;
@end
