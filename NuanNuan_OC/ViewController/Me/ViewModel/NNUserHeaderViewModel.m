//
//  NNUserHeaderViewModel.m
//  NuanNuan_OC
//
//  Created by 忘、 on 16/11/17.
//  Copyright © 2016年 NuanNuan. All rights reserved.
//

#import "NNUserHeaderViewModel.h"

@implementation NNUserHeaderViewModel

- (void)upLoadHeaderImageViewWithToken:(NSString *)token andImage:(UIImage *)imagedata {
    NSDictionary *parames = @{@"token":token};
    NSData *data = UIImageJPEGRepresentation(imagedata, 0.5);
    [NNNetRequestClass NetRequestPOSTFileWithRequestURL:[NSString stringWithFormat:@"%@/?c=api_member&a=updateHead",NNBaseUrl] withParameter:parames withFileData: data withFileName:@"headimage.png" withReturnValueBlock:^(id returnValue) {
        NSLog(@"%@",returnValue);
        
        self.returnBlock([[returnValue objectForKey:@"data"] objectForKey:@"head"]);
    } withErrorCodeBlock:^(id errorCode) {
        
    } withFailureBlock:^(id failureBlock) {
        
    } withProgress:^(id Progress) {
        
    }];
     
     
     
}












@end
