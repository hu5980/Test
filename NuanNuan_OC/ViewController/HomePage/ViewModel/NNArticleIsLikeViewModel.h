//
//  NNArticleIsLikeViewModel.h
//  NuanNuan_OC
//
//  Created by 忘、 on 16/11/25.
//  Copyright © 2016年 NuanNuan. All rights reserved.
//

#import "NNBaseViewModel.h"

@interface NNArticleIsLikeViewModel : NNBaseViewModel

- (void)getUserIsLikeTheArticleWithToken:(NSString *)token andType:(NSString *)type andArticleID:(NSString *)aid;

@end
