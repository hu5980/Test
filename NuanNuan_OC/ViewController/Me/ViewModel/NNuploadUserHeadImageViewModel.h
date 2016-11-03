//
//  NNuploadUserHeadImageViewModel.h
//  NuanNuan_OC
//
//  Created by 忘、 on 16/11/3.
//  Copyright © 2016年 NuanNuan. All rights reserved.
//

#import "NNBaseViewModel.h"

@interface NNuploadUserHeadImageViewModel : NNBaseViewModel

- (void)upLoadUserheadImageWithToken:(NSString *)token andHeadImagedata:(NSData *)data;

@end
