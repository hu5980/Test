//
//  NNMineCommentViewModel.h
//  NuanNuan_OC
//
//  Created by 胡光耀 on 16/11/23.
//  Copyright © 2016年 NuanNuan. All rights reserved.
//

#import "NNBaseViewModel.h"

@interface NNMineCommentViewModel : NNBaseViewModel
- (void)getMineCommentWithToken:(NSString *)token andCommentType:(NSString *)type andLastComentID:(NSString *)lastID
                        andDown:(NSString *)down andPageNum:(NSString *)pageNum;
@end
