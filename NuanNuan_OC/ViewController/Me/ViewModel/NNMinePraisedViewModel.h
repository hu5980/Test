//
//  NNMinePraisedViewModel.h
//  NuanNuan_OC
//
//  Created by 忘、 on 16/11/16.
//  Copyright © 2016年 NuanNuan. All rights reserved.
//

#import "NNBaseViewModel.h"

@interface NNMinePraisedViewModel : NNBaseViewModel

- (void)getMinePraisedContentWithToken:(NSString *)token andPraisedType:(NSString *) type andPraisedId:(NSString *) praisedID andpageNum:(NSString *)pageNum;

@end
