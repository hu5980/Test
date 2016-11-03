//
//  NNLoginAndRegisterViewModel.h
//  NuanNuan_OC
//
//  Created by 忘、 on 16/11/1.
//  Copyright © 2016年 NuanNuan. All rights reserved.
//

#import "NNBaseViewModel.h"

@interface NNUserInfoViewModel : NNBaseViewModel

- (void)getUserInfoWithToken:(NSString *)token;

@end
