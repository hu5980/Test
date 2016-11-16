//
//  NNOrderViewModel.h
//  NuanNuan_OC
//
//  Created by 忘、 on 16/11/15.
//  Copyright © 2016年 NuanNuan. All rights reserved.
//

#import "NNBaseViewModel.h"

@interface NNOrderViewModel : NNBaseViewModel

- (void)getMineOrderInfoWithToken:(NSString *)token andOrderID:(NSString *)orderID andPageNum:(NSString *)pageNum;

@end
