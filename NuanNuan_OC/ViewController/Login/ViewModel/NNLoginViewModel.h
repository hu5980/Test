//
//  NNLoginViewModel.h
//  NuanNuan_OC
//
//  Created by 忘、 on 16/11/2.
//  Copyright © 2016年 NuanNuan. All rights reserved.
//

#import "NNBaseViewModel.h"

@interface NNLoginViewModel : NNBaseViewModel
- (void)loginWithUserName:(NSString *)userName andpassword:(NSString *)password andLoginType:(NSInteger)type;


- (void)loginWithAccount:(NSString *)account password:(NSString *)password needLong:(BOOL)needLong;

@end
