//
//  NNNoticeViewModel.h
//  NuanNuan_OC
//
//  Created by 忘、 on 16/12/12.
//  Copyright © 2016年 NuanNuan. All rights reserved.
//

#import "NNBaseViewModel.h"

@interface NNNoticeViewModel : NNBaseViewModel

- (void) getNoticeWithToken:(NSString *)token andLastID:(NSString *)lastID andPageNum:(NSString *)pageNum;


+ (NSInteger) getUnreadNoticeWithUserID:(NSString *)uid;


+ (RLMResults *) getNoticeListWithUserID:(NSString *)uid;

@end
