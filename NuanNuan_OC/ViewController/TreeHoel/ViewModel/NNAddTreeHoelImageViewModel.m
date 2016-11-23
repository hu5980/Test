//
//  NNAddTreeHoelImageViewModel.m
//  NuanNuan_OC
//
//  Created by 忘、 on 16/11/23.
//  Copyright © 2016年 NuanNuan. All rights reserved.
//

#import "NNAddTreeHoelImageViewModel.h"


@implementation NNAddTreeHoelImageViewModel


- (void)addTreeImageWithToken:(NSString *)token andImages:(NSArray *)images {
    dispatch_queue_t queue = dispatch_queue_create("ted.queue.next", DISPATCH_QUEUE_CONCURRENT);;
    dispatch_group_t group = dispatch_group_create();
    
    for (NSInteger i  = 0; i < images.count; i++) {
        dispatch_group_async(group, queue, ^{
            UIImage *image = [images objectAtIndex:i];
            NSDictionary *parames = @{@"token":token,@"order":[NSNumber numberWithInteger:i]};
            NSData *imageData = UIImageJPEGRepresentation(image, 0.5);
            
            [NNNetRequestClass NetRequestPOSTFileWithRequestURL:[NSString stringWithFormat:@"%@/?c=api_treehole&a=uploadTreeholePic",NNBaseUrl] withParameter:parames withName:@"th_pic" withFileData:imageData withFileName:@"pic.png" withReturnValueBlock:^(id returnValue) {
                NSLog(@"%@",returnValue);
            } withErrorCodeBlock:^(id errorCode) {
                NSLog(@"%@",errorCode);
                
            } withFailureBlock:^(id failureBlock) {
                NSLog(@"%@",failureBlock);
                
            } withProgress:^(id Progress) {
                
            }];
        });
    }
    
    //dispatch_group_wait(group, DISPATCH_TIME_FOREVER);
    
//    dispatch_group_notify(group, dispatch_get_main_queue(), ^(){
//        NSLog(@"end");
//    });
    
    
}




@end
