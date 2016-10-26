//
//  NNRingImageViewModel.m
//  NuanNuan_OC
//
//  Created by 忘、 on 16/10/26.
//  Copyright © 2016年 NuanNuan. All rights reserved.
//

#import "NNRingImageViewModel.h"
#import "NNRingImageModel.h"
@implementation NNRingImageViewModel


- (void) getRingFocueAreaContent {
    [NNNetRequestClass NetRequestGETWithRequestURL:[NSString stringWithFormat:@"%@/%@",NNBaseUrl,@"?c=api_article&a=getAllfocus"] withParameter:nil withReturnValueBlock:^(id returnValue) {
        [self fetchValueSuccessWithDic:returnValue];
        
    } withErrorCodeBlock:^(id errorCode) {
        NNLog(@"%@",errorCode);
    } withFailureBlock:^(id failureBlock){
        NNLog(@"%@",failureBlock);
    } withProgress:^(id Progress) {
      
    }];
  }

-(void)fetchValueSuccessWithDic: (NSDictionary *) returnValue {
    NSMutableArray *array = [NSMutableArray array];
    NSDictionary *dic = [returnValue objectForKey:@"data"];
    NSString *imageBaseUrl = [dic objectForKey:@"a_bg_pic_path"];
    NSArray *ringArrays = [dic objectForKey:@"list"];
    for (int i  = 0; i < ringArrays.count; i++) {
        NNRingImageModel *model = [[NNRingImageModel alloc] init];
        model.imageUrl = [NSString stringWithFormat:@"%@%@",imageBaseUrl,[ringArrays[i] objectForKey:@"a_bg_pic"]];
        model.clickNum = [[ringArrays[i] objectForKey:@"a_click_num"] integerValue];
        model.goodsNum = [[ringArrays[i] objectForKey:@"a_goods_num"] integerValue];
        model.ringId = [[ringArrays[i] objectForKey:@"a_id"] integerValue];
        model.title = [ringArrays[i] objectForKey:@"a_title"];
        model.createTime = [[ringArrays[i] objectForKey:@"create_time"] integerValue];
        [array addObject:model];
    }
    self.returnBlock(array);
}

@end
