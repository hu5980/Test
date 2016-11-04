//
//  NNReplyViewModel.h
//  NuanNuan_OC
//
//  Created by 忘、 on 16/11/4.
//  Copyright © 2016年 NuanNuan. All rights reserved.
//

#import "NNBaseViewModel.h"

@interface NNReplyViewModel : NNBaseViewModel

- (void)replyAnswerOrTreeHoelWithToken:(NSString *)token andReplyType:(NSString *)type andTargetID:(NSString *) targetID andConnent:(NSString *) content;

@end
