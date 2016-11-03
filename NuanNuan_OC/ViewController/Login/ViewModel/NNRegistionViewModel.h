//
//  NNRegistionViewModel.h
//  NuanNuan_OC
//
//  Created by 忘、 on 16/11/2.
//  Copyright © 2016年 NuanNuan. All rights reserved.
//

#import "NNBaseViewModel.h"

@interface NNRegistionViewModel : NNBaseViewModel

- (void)registerUserWithUsername:(NSString *)userName andverify:(NSString *)verify andPassword:(NSString *)password;

@end
