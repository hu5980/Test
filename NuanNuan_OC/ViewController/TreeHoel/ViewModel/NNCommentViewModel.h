//
//  NNCommentViewModel.h
//  NuanNuan_OC
//
//  Created by 忘、 on 16/11/11.
//  Copyright © 2016年 NuanNuan. All rights reserved.
//

#import "NNBaseViewModel.h"

@interface NNCommentViewModel : NNBaseViewModel

- (void)getCommentWithToken:(NSString *)token andCommentType:(NSString *)type andID:(NSString *)commentTypeID andLastID:(NSString *)lastID andPageNum:(NSString *)pageNum andIsDownReflash:(NSString *) isDown ;

@end
