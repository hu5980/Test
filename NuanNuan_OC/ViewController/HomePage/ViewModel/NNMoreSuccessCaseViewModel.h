//
//  NNMoreSuccessCaseViewModel.h
//  NuanNuan_OC
//
//  Created by 忘、 on 16/10/31.
//  Copyright © 2016年 NuanNuan. All rights reserved.
//

#import "NNBaseViewModel.h"

@interface NNMoreSuccessCaseViewModel : NNBaseViewModel

- (void)getMoreSuccessCaseWithPageNum:(NSInteger) pageNum andCaseType:(NSInteger) type andCaseID:(NSInteger) caseID andToken:(NSString *)token;

- (void)likeTheArticleWithUser:(NSString *)token andType:(NSInteger) type andCaseID:(NSInteger) caseID;


- (void)unlikeTheArticleWithUser:(NSString *)token andType:(NSInteger) type andCaseID:(NSInteger) caseID;

@end
