//
//  NNMoreSuccessCaseViewModel.m
//  NuanNuan_OC
//
//  Created by 忘、 on 16/10/31.
//  Copyright © 2016年 NuanNuan. All rights reserved.
//

#import "NNMoreSuccessCaseViewModel.h"
#import "NNSuccessCaseModel.h"
@implementation NNMoreSuccessCaseViewModel

- (void)getMoreSuccessCaseWithPageNum:(NSInteger) pageNum andCaseType:(NSInteger) type andCaseID:(NSInteger) caseID {
    
    NSDictionary *parames = @{@"type":[NSNumber numberWithInteger:type],@"pnum":[NSNumber numberWithInteger:pageNum],@"last_id":[NSNumber numberWithInteger:caseID]};
    
    [NNNetRequestClass NetRequestPOSTWithRequestURL:[NSString stringWithFormat:@"%@/?c=api_article&a=getArticleList",NNBaseUrl] withParameter:parames withReturnValueBlock:^(id returnValue) {
    
        [self fetchValueSuccessWithDic:returnValue];
    } withErrorCodeBlock:^(id errorCode) {
        
    } withFailureBlock:^(id failureBlock) {
        
    } withProgress:^(id Progress) {
        
    }];
    
  
}


-(void)fetchValueSuccessWithDic: (NSDictionary *) returnValue {
    NSDictionary *dic = [returnValue objectForKey:@"data"];
    NSString *basebgUrl = [dic objectForKey:@"a_bg_pic_path"];
    NSArray *listArray = [dic objectForKey:@"list"];
    NSMutableArray *caseMutableArray = [NSMutableArray arrayWithCapacity:listArray.count];
    for (int i  = 0; i < listArray.count; i++) {
        NNSuccessCaseModel *model = [[NNSuccessCaseModel alloc] init];
        model.caseTitle = [listArray[i] objectForKey:@"a_title"];
        model.caseName = [listArray[i] objectForKey:@"ac_name"];
        model.caseImageUrl = [NSString stringWithFormat:@"%@/%@",basebgUrl,[listArray[i] objectForKey:@"a_bg_pic"]] ;
        model.caseAdID = [[listArray[i] objectForKey:@"a_id"] integerValue];
        model.caseGoodsNum = [[listArray[i] objectForKey:@"a_goods_num"] integerValue];
        model.caseClickNum = [[listArray[i] objectForKey:@"a_click_num"] integerValue];
        model.caseCreateTime = [[listArray[i] objectForKey:@"create_time"] integerValue];
        [caseMutableArray addObject:model];
    }
    return self.returnBlock(caseMutableArray);
}

- (void)likeTheArticleWithUser:(NSString *)token andType:(NSInteger) type andCaseID:(NSInteger) caseID{
    NSDictionary *params = @{@"token":token,@"type":[NSNumber numberWithInteger:type],@"id":[NSNumber numberWithInteger:caseID]};
    [NNNetRequestClass NetRequestGETWithRequestURL:[NSString stringWithFormat:@"%@/?c=api_good&a=addGood",NNBaseUrl] withParameter:params withReturnValueBlock:^(id returnValue) {
        
    } withErrorCodeBlock:^(id errorCode) {
        
    } withFailureBlock:^(id failureBlock) {
        
    } withProgress:^(id Progress) {
        
    }];
}

- (void)unlikeTheArticleWithUser:(NSString *)token andType:(NSInteger) type andCaseID:(NSInteger) caseID {
    NSDictionary *params = @{@"token":token,@"type":[NSNumber numberWithInteger:type],@"id":[NSNumber numberWithInteger:caseID]};
    [NNNetRequestClass NetRequestGETWithRequestURL:[NSString stringWithFormat:@"%@/?c=api_good&a=cancelGood",NNBaseUrl] withParameter:params withReturnValueBlock:^(id returnValue) {
        
    } withErrorCodeBlock:^(id errorCode) {
        
    } withFailureBlock:^(id failureBlock) {
        
    } withProgress:^(id Progress) {
        
    }];
}

@end
