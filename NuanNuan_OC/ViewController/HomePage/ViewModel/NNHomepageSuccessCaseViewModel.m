//
//  NNHomepageSuccessCaseViewModel.m
//  NuanNuan_OC
//
//  Created by 忘、 on 16/10/31.
//  Copyright © 2016年 NuanNuan. All rights reserved.
//

#import "NNHomepageSuccessCaseViewModel.h"
#import "NNSuccessCaseModel.h"
#import "NNHomepageSuccessCaseModel.h"
@implementation NNHomepageSuccessCaseViewModel

- (void) getHomepageSuccessCase {
    [NNNetRequestClass NetRequestPOSTWithRequestURL:[NSString stringWithFormat:@"%@/%@",NNBaseUrl,@"?c=api_article&a=getSuccessArticleList"]
                                     withParameter:nil
                              withReturnValueBlock:^(id returnValue) {
                                  NNLog(@"%@",returnValue);
                                  [self fetchValueSuccessWithDic:returnValue];
                              } withErrorCodeBlock:^(id errorCode) {
                                  NNLog(@"%@",errorCode);
                              } withFailureBlock:^(id failureBlock) {
                                   NNLog(@"%@",failureBlock);
                              } withProgress:^(id Progress) {
                                  NNLog(@"%@",Progress);

                              }];
}


-(void)fetchValueSuccessWithDic: (NSDictionary *) returnValue {
    NSDictionary *dic = [returnValue objectForKey:@"data"];
    NSString *basebgUrl = [dic objectForKey:@"a_bg_pic_path"];
    NSArray *loveStoryArray = [dic objectForKey:@"hl"];
    NSArray *improvementArray = [dic objectForKey:@"ts"];
    NSArray *redeemStoryArray = [dic objectForKey:@"wh"];
    
    NSMutableArray *loveStoryMutableArray = [NSMutableArray arrayWithCapacity:loveStoryArray.count];
    NSMutableArray *improvementMutableArray = [NSMutableArray arrayWithCapacity:improvementArray.count];
    NSMutableArray *redeemStoryMutableArray = [NSMutableArray arrayWithCapacity:redeemStoryArray.count];
    
    for (int i  = 0; i < loveStoryArray.count; i++) {
        NNSuccessCaseModel *model = [[NNSuccessCaseModel alloc] init];
        model.caseTitle = [loveStoryArray[i] objectForKey:@"a_title"];
        model.caseName = [loveStoryArray[i] objectForKey:@"ac_name"];
        model.caseImageUrl = [NSString stringWithFormat:@"%@/%@",basebgUrl,[loveStoryArray[i] objectForKey:@"a_bg_pic"]] ;
        model.caseAdID = [[loveStoryArray[i] objectForKey:@"a_id"] integerValue];
        model.caseGoodsNum = [[loveStoryArray[i] objectForKey:@"a_goods_num"] integerValue];
        model.caseClickNum = [[loveStoryArray[i] objectForKey:@"a_click_num"] integerValue];
        model.caseCreateTime = [[loveStoryArray[i] objectForKey:@"create_time"] integerValue];
        [loveStoryMutableArray addObject:model];
    }
    
    for (int i  = 0; i < improvementArray.count; i++) {
        NNSuccessCaseModel *model = [[NNSuccessCaseModel alloc] init];
        model.caseTitle = [loveStoryArray[i] objectForKey:@"a_title"];
        model.caseName = [loveStoryArray[i] objectForKey:@"ac_name"];
        model.caseImageUrl = [NSString stringWithFormat:@"%@/%@",basebgUrl,[loveStoryArray[i] objectForKey:@"a_bg_pic"]] ;
        model.caseAdID = [[loveStoryArray[i] objectForKey:@"a_id"] integerValue];
        model.caseGoodsNum = [[loveStoryArray[i] objectForKey:@"a_goods_num"] integerValue];
        model.caseClickNum = [[loveStoryArray[i] objectForKey:@"a_click_num"] integerValue];
        model.caseCreateTime = [[loveStoryArray[i] objectForKey:@"create_time"] integerValue];
        [improvementMutableArray addObject:model];
    }
    
    for (int i  = 0; i < redeemStoryArray.count; i++) {
        NNSuccessCaseModel *model = [[NNSuccessCaseModel alloc] init];
        model.caseTitle = [loveStoryArray[i] objectForKey:@"a_title"];
        model.caseName = [loveStoryArray[i] objectForKey:@"ac_name"];
        model.caseImageUrl = [NSString stringWithFormat:@"%@/%@",basebgUrl,[loveStoryArray[i] objectForKey:@"a_bg_pic"]] ;
        model.caseAdID = [[loveStoryArray[i] objectForKey:@"a_id"] integerValue];
        model.caseGoodsNum = [[loveStoryArray[i] objectForKey:@"a_goods_num"] integerValue];
        model.caseClickNum = [[loveStoryArray[i] objectForKey:@"a_click_num"] integerValue];
        model.caseCreateTime = [[loveStoryArray[i] objectForKey:@"create_time"] integerValue];
        [redeemStoryMutableArray addObject:model];
    }
    
    NNHomepageSuccessCaseModel *model = [[NNHomepageSuccessCaseModel alloc] init];
    model.loveStoryArray = loveStoryMutableArray;
    model.improvementArray = improvementMutableArray;
    model.redeemStoryArray = redeemStoryMutableArray;
    
    self.returnBlock(model);
}

@end
