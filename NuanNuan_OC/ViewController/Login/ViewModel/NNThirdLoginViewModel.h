//
//  NNThirdLoginViewModel.h
//  NuanNuan_OC
//
//  Created by hu5980 on 16/11/26.
//  Copyright © 2016年 NuanNuan. All rights reserved.
//

#import "NNBaseViewModel.h"

@interface NNThirdLoginViewModel : NNBaseViewModel

- (void)loginWithLoginType:(NSString *)loginType andAccessToken:(NSString *)accessToken andOpenId:(NSString *)openid;



@end
