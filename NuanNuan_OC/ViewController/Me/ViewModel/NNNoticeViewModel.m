//
//  NNNoticeViewModel.m
//  NuanNuan_OC
//
//  Created by 忘、 on 16/12/12.
//  Copyright © 2016年 NuanNuan. All rights reserved.
//

#import "NNNoticeViewModel.h"
#import "NNNoticeModel.h"
@implementation NNNoticeViewModel
- (void) getNoticeWithToken:(NSString *)token andLastID:(NSString *)lastID andPageNum:(NSString *)pageNum {
    NSDictionary *parames =@{@"token":token,@"last_id":lastID,@"pnum":pageNum};
    
    [NNNetRequestClass NetRequestPOSTWithRequestURL:[NSString stringWithFormat:@"%@/?c=api_notice&a=myNoticeList",NNBaseUrl] withParameter:parames withReturnValueBlock:^(id returnValue) {
        [self fetchValueSuccessWithDic:returnValue];
    } withErrorCodeBlock:^(id errorCode) {
        self.errorBlock(errorCode);
    } withFailureBlock:^(id failureBlock) {
        self.failureBlock(failureBlock);
    } withProgress:^(id Progress) {
        
    }];
    
}

- (void)fetchValueSuccessWithDic:(NSDictionary *)returnValue {
    NSArray *list = [[returnValue objectForKey:@"data"] objectForKey:@"list"];
    for (int i  =0; i < list.count; i++) {
        NSDictionary *notice = [list objectAtIndex:i];
        NNNoticeModel *model = [[NNNoticeModel alloc] init];
        model.time = [notice objectForKey:@"create_time"];
        model.noticeData = [notice objectForKey:@"n_data"];
        model.noticeId = [notice objectForKey:@"n_id"];
        model.noticeMsg = [notice objectForKey:@"n_msg"];
        model.noticeType = [notice objectForKey:@"n_type"];
        model.uid = [notice objectForKey:@"uid"];
        model.isRead = @"0";
        RLMRealm *realm = [RLMRealm defaultRealm];
        
        RLMResults *noticeResult = [NNNoticeModel objectsWhere:@"noticeId = %@",[notice objectForKey:@"n_id"]];
        if (noticeResult.count == 0) {
            [realm transactionWithBlock:^{
                [realm addObject:model];
            }];
        }
    }
    self.returnBlock(@"获取成功");
}

+ (NSInteger) getUnreadNoticeWithUserID:(NSString *)uid {
    RLMResults *noticeResult = [NNNoticeModel objectsWhere:@"uid = %@ AND isRead = '0'  ",uid];
    return noticeResult.count;
}

+ (RLMResults *) getNoticeListWithUserID:(NSString *)uid {
    RLMResults *noticeResult = [NNNoticeModel objectsWhere:@"uid = %@ ",uid];
   
    for (int i = 0; i <noticeResult.count ; i++) {
        NNNoticeModel *noticeModel = [noticeResult objectAtIndex:i];
         NSLog(@"数据库中是否已读 %@  ID %@",noticeModel.isRead,noticeModel.noticeId);
    }
    return noticeResult;
}

+ (void) changeNoticeReadState:(NSString *)noticeId {
    
    RLMRealm *realm = [RLMRealm defaultRealm];
    [realm transactionWithBlock:^{
        RLMResults *results = [NNNoticeModel objectsWhere:@"noticeId = %@",noticeId];
        NNNoticeModel *noticeModel = [results lastObject];
        NSLog(@"%@  %@",noticeModel.isRead,noticeModel.noticeId);
        noticeModel.isRead =@"1";
        [realm commitWriteTransaction];
    }];
}

@end
