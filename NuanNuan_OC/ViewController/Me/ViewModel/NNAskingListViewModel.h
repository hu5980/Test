//
//  NNAskingViewModel.h
//  NuanNuan_OC
//
//  Created by 忘、 on 16/12/13.
//  Copyright © 2016年 NuanNuan. All rights reserved.
//

#import "NNBaseViewModel.h"

@interface NNAskingListViewModel : NNBaseViewModel

- (void)getAnswerListWithToken:(NSString *)token andHasAnswer:(NSString *)hadAnswer andLastId:(NSString *)lastID andpageNum:(NSString *)pageNum;

@end
