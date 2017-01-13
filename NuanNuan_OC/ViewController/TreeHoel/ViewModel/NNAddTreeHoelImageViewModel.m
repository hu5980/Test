//
//  NNAddTreeHoelImageViewModel.m
//  NuanNuan_OC
//
//  Created by 忘、 on 16/11/23.
//  Copyright © 2016年 NuanNuan. All rights reserved.
//

#import "NNAddTreeHoelImageViewModel.h"


@implementation NNAddTreeHoelImageViewModel {

    NSMutableArray *imageArrays;
}


- (void)addTreeImageWithToken:(NSString *)token andImages:(NSArray *)images {

    if (images.count == 0) {
        self.returnBlock([NSArray array]);
    }else{
        for (NSInteger i  = 0; i < images.count; i++) {
            dispatch_group_t group = dispatch_group_create();
            dispatch_group_enter(group);
            
            UIImage *image = [images objectAtIndex:i];
            NSDictionary *parames = @{@"token":token,@"order":[NSNumber numberWithInteger:i]};
            NSData *imageData = UIImageJPEGRepresentation(image, 0.5);
            
            [NNNetRequestClass NetRequestPOSTFileWithRequestURL:[NSString stringWithFormat:@"%@/?c=api_treehole&a=uploadTreeholePic",NNBaseUrl] withParameter:parames withName:@"th_pic" withFileData:imageData withFileName:@"pic.png" withReturnValueBlock:^(id returnValue) {
                NSLog(@"%@",returnValue);
                if (imageArrays == nil) {
                    imageArrays = [NSMutableArray arrayWithCapacity:images.count];
                }
                NSString *imageUrl = [[returnValue objectForKey:@"data"] objectForKey:@"url"];
                NSString *imageName = [[imageUrl componentsSeparatedByString:@"/"] lastObject];
                [imageArrays addObject:imageName];
                dispatch_group_leave(group);
            } withErrorCodeBlock:^(id errorCode) {
                NSLog(@"%@",errorCode);
                dispatch_group_leave(group);
                
            } withFailureBlock:^(id failureBlock) {
                NSLog(@"%@",failureBlock);
                dispatch_group_leave(group);
                
            } withProgress:^(id Progress) {
            }];
            
            dispatch_group_notify(group, dispatch_get_main_queue(), ^(){
                NSLog(@"end");
                
                self.returnBlock(imageArrays);
            });

        }
    }
    
    
}




@end
