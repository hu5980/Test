//
//  NNLoginAndRegisterViewModel.h
//  NuanNuan_OC
//
//  Created by 忘、 on 16/11/1.
//  Copyright © 2016年 NuanNuan. All rights reserved.
//

#import "NNBaseViewModel.h"

@interface NNLoginAndRegisterViewModel : NNBaseViewModel

- (void)registerUserWithUsername:(NSString *)userName andverify:(NSString *)verify andPassword:(NSString *)password;

- (void)loginWithUserName:(NSString *)userName andpassword:(NSString *)password andLoginType:(NSInteger)type;

- (void)getUserInfoWithToken:(NSString *)token;

@end
