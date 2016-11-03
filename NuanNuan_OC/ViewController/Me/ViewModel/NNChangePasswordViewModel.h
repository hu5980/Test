//
//  NNChangePasswordViewModel.h
//  NuanNuan_OC
//
//  Created by 忘、 on 16/11/3.
//  Copyright © 2016年 NuanNuan. All rights reserved.
//

#import "NNBaseViewModel.h"

@interface NNChangePasswordViewModel : NNBaseViewModel

- (void)changePasswordWithtToken:(NSString *)token andCode:(NSString *)code andPassword:(NSString *)newPassword andTel:(NSString *)tel;

@end
