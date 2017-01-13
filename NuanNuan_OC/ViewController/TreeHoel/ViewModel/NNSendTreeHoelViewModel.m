//
//  NNSendTreeHoelViewModel.m
//  NuanNuan_OC
//
//  Created by 忘、 on 16/11/23.
//  Copyright © 2016年 NuanNuan. All rights reserved.
//

#import "NNSendTreeHoelViewModel.h"

@implementation NNSendTreeHoelViewModel

- (void)sendTreeHoelWithToken:(NSString *)token andContent:(NSString *)content andPics:(NSString *)pics andanonymity:(NSString *) anonymity {
    NSDictionary *parames = @{@"token":token,
                              @"th_content":content,
                              @"th_pics":pics,
                              @"th_anonymity":anonymity};
    [NNNetRequestClass NetRequestPOSTWithRequestURL:[NSString stringWithFormat:@"%@/?c=api_treehole&a=addTreehole",NNBaseUrl] withParameter:parames withReturnValueBlock:^(id returnValue) {
        self.returnBlock([returnValue objectForKey:@"result"]);
    } withErrorCodeBlock:^(id errorCode) {
        self.errorBlock(errorCode);
    } withFailureBlock:^(id failureBlock) {
        self.failureBlock(failureBlock);
    } withProgress:^(id Progress) {
        
    }];
}

@end
