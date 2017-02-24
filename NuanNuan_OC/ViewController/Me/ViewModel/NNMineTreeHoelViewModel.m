//
//  NNMineTreeHoelViewModel.m
//  NuanNuan_OC
//
//  Created by 忘、 on 17/1/17.
//  Copyright © 2017年 NuanNuan. All rights reserved.
//

#import "NNMineTreeHoelViewModel.h"
#import "NNTreeHoelModel.h"

@implementation NNMineTreeHoelViewModel

- (void)getMineTreeHoelWithToken:(NSString *)token andlastID:(NSString *)lastId andPageNum:(NSString *)pageNum  {
    
    if (lastId == nil) {
        lastId = @"";
    }
    
    NSDictionary *parames = @{@"token":token,@"last_id":lastId,@"pnum":pageNum};
    
    [NNNetRequestClass NetRequestPOSTWithRequestURL:[NSString stringWithFormat:@"%@/%@",NNBaseUrl,@"/?c=api_treehole&a=getMyTreeholeList"] withParameter:parames withReturnValueBlock:^(id returnValue) {
        [self fetchValueSuccessWithDic:returnValue];
    } withErrorCodeBlock:^(id errorCode) {
        self.errorBlock(errorCode);
    } withFailureBlock:^(id failureBlock) {
        self.failureBlock(failureBlock);
    } withProgress:^(id Progress) {
        
    }];

}

- (void)fetchValueSuccessWithDic:(NSDictionary *)returnValue {
    NSDictionary *dic = [returnValue objectForKey:@"data"];
    NSString *basePathUrl = [dic objectForKey:@"th_pic_path"];
    NSArray *treeHoelArray = [dic objectForKey:@"list"];
    NSMutableArray *treeHoelModelArray = [NSMutableArray arrayWithCapacity:treeHoelArray.count];
    for (int i = 0 ; i < treeHoelArray.count; i++) {
        NSDictionary *treeHoelDic = [treeHoelArray objectAtIndex:i];
        NNTreeHoelModel *model = [[NNTreeHoelModel alloc] init];
        model.isGood = [[treeHoelDic objectForKey:@"has_good"] boolValue];
        model.thID =[treeHoelDic objectForKey:@"th_id"];
        model.uid = [treeHoelDic objectForKey:@"uid"];
        model.thContent = [treeHoelDic objectForKey:@"th_content"];
        NSString  *picString =  [treeHoelDic objectForKey:@"th_pics"];
        NSData *jsonData = [picString dataUsingEncoding:NSUTF8StringEncoding];
        NSArray *picArrays = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableLeaves error:nil];
        NSMutableArray *picMutableArrays = [NSMutableArray array];
        for (int j= 0; j < picArrays.count; j++) {
            [picMutableArrays addObject:[NSString stringWithFormat:@"%@/%@",basePathUrl,[picArrays objectAtIndex:j]]];
        }
        
        model.picArrays = picMutableArrays;
        model.thAnonymity = [treeHoelDic objectForKey:@"th_anonymity"];
        model.thCommentNum =[treeHoelDic objectForKey:@"th_comment_num"];
        model.thGoodsNum =[treeHoelDic objectForKey:@"th_goods_num"];
        model.thIsdel = [treeHoelDic objectForKey:@"th_isdel"];
        model.userHeadUrl = [treeHoelDic objectForKey:@"user_head"];
        model.userNikeName = [treeHoelDic objectForKey:@"user_nickname"];
        model.createTime = [[treeHoelDic objectForKey:@"create_time"] integerValue];
        model.modifyTime =[[treeHoelDic objectForKey:@"modify_time"] integerValue];
        [treeHoelModelArray addObject:model];
    }
    
    self.returnBlock(treeHoelModelArray);
}

- (void)deleteTreeHoelWithToken:(NSString *)token andTreeHoelID:(NSString *)treeHoelID {
    NSDictionary *parames = @{@"token":token,@"th_id":treeHoelID};
    
    [NNNetRequestClass NetRequestPOSTWithRequestURL:[NSString stringWithFormat:@"%@/%@",NNBaseUrl,@"/?c=api_treehole&a=delTreehole"] withParameter:parames withReturnValueBlock:^(id returnValue) {
        return self.returnBlock([returnValue objectForKey:@"result"]);
    } withErrorCodeBlock:^(id errorCode) {
        return self.errorBlock(errorCode);
    } withFailureBlock:^(id failureBlock) {
        return self.failureBlock(failureBlock);
    } withProgress:^(id Progress) {
        
    }];

    
}


@end
