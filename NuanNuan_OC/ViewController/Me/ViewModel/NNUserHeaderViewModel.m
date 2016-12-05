//
//  NNUserHeaderViewModel.m
//  NuanNuan_OC
//
//  Created by 忘、 on 16/11/17.
//  Copyright © 2016年 NuanNuan. All rights reserved.
//

#import "NNUserHeaderViewModel.h"
#import "NNUserInfoModel.h"

@implementation NNUserHeaderViewModel

- (void)upLoadHeaderImageViewWithToken:(NSString *)token andImage:(UIImage *)imagedata {
    NSDictionary *parames = @{@"token":token};
    NSData *data = UIImageJPEGRepresentation(imagedata, 0.5);
    [NNNetRequestClass NetRequestPOSTFileWithRequestURL:[NSString stringWithFormat:@"%@/?c=api_member&a=updateHead",NNBaseUrl] withParameter:parames withName:@"head" withFileData: data withFileName:@"head.png" withReturnValueBlock:^(id returnValue) {
        RLMRealm *realm = [RLMRealm defaultRealm];
        [realm transactionWithBlock:^{
            RLMResults *results = [NNUserInfoModel objectsWhere:@"uid = %@",USERID];
            NNUserInfoModel *userInfoModel = [results lastObject];
            userInfoModel.headImageUrl = [[returnValue objectForKey:@"data"] objectForKey:@"head"];
            [realm commitWriteTransaction];
        }];
        self.returnBlock([[returnValue objectForKey:@"data"] objectForKey:@"head"]);
    } withErrorCodeBlock:^(id errorCode) {
        self.returnBlock(errorCode);
    } withFailureBlock:^(id failureBlock) {
        self.returnBlock(failureBlock);
    } withProgress:^(id Progress) {
    }];
}












@end
