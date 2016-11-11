//
//  NNCommentViewModel.m
//  NuanNuan_OC
//
//  Created by 忘、 on 16/11/11.
//  Copyright © 2016年 NuanNuan. All rights reserved.
//

#import "NNCommentViewModel.h"
#import "NNCommentModel.h"
@implementation NNCommentViewModel

- (void)getCommentWithToken:(NSString *)token andCommentType:(NSString *)type andID:(NSString *)commentTypeID andLastID:(NSString *)lastID andPageNum:(NSString *)pageNum andIsDownReflash:(NSString *) isDown{
    if (lastID == nil) {
        lastID = @"0";
    }
    
    NSDictionary *parames = @{@"token":token,@"type":type,@"id":commentTypeID,@"last_id":lastID,@"pnum":pageNum,@"down":isDown};
    
    [NNNetRequestClass NetRequestPOSTWithRequestURL:[NSString stringWithFormat:@"%@/?c=api_comment&a=getCommentList",NNBaseUrl] withParameter:parames withReturnValueBlock:^(id returnValue) {
        if ([[returnValue objectForKey:@"result"] isEqualToString:@"success"]) {
            [self fetchValueSuccessWithDic:returnValue];
        }
    } withErrorCodeBlock:^(id errorCode) {
        
    } withFailureBlock:^(id failureBlock) {
        
    } withProgress:^(id Progress) {
        
    }];
}

- (void)fetchValueSuccessWithDic:(NSDictionary *)returnValue {
    NSArray *listArray = [returnValue objectForKey:@"data"];
    NSMutableArray *commentModelArray = [NSMutableArray arrayWithCapacity:listArray.count];
    for (int i = 0; i < listArray.count; i++) {
        NNCommentModel *model = [[NNCommentModel alloc] init];
        model.commentID = [listArray[i] objectForKey:@"c_id"];
        model.commentUID = [listArray[i] objectForKey:@"uid"];
        model.commentOID = [listArray[i] objectForKey:@"o_id"];
        model.commentType = [listArray[i] objectForKey:@"c_type"];
        model.commentContent = [listArray[i] objectForKey:@"c_content"];
        model.commentGoodsNum = [listArray[i] objectForKey:@"c_goods_num"];
        model.commentIsdel = [listArray[i] objectForKey:@"c_isdel"];
        model.commentHeaderUrl = [listArray[i] objectForKey:@"user_head"];
        model.commentNickName = [listArray[i] objectForKey:@"user_nickname"];
        model.commentCreateTime = [[listArray[i] objectForKey:@"create_time"] integerValue];
        model.commentModifyTime = [[listArray[i] objectForKey:@"modify_time"] integerValue];
        [commentModelArray addObject:model];
    }
    self.returnBlock(commentModelArray);
}

@end
