//
//  NNNoticeModel.h
//  NuanNuan_OC
//
//  Created by 忘、 on 16/12/13.
//  Copyright © 2016年 NuanNuan. All rights reserved.
//

#import <Realm/Realm.h>

@interface NNNoticeModel : RLMObject

@property (nonatomic,strong) NSString *noticeId;
@property (nonatomic,strong) NSString *noticeType;
@property (nonatomic,strong) NSString *noticeMsg;
@property (nonatomic,strong) NSString *uid;
@property (nonatomic,strong) NSString *time;
@property (nonatomic,strong) NSString *isRead;
@property (nonatomic,strong) NSString *noticeData;
@end
