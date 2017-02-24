//
//  NNMineTreeHoelViewModel.h
//  NuanNuan_OC
//
//  Created by 忘、 on 17/1/17.
//  Copyright © 2017年 NuanNuan. All rights reserved.
//

#import "NNBaseViewModel.h"

@interface NNMineTreeHoelViewModel : NNBaseViewModel

- (void)getMineTreeHoelWithToken:(NSString *)token andlastID:(NSString *)lastId andPageNum:(NSString *)pageNum ;


- (void)deleteTreeHoelWithToken:(NSString *)token andTreeHoelID:(NSString *)treeHoelID;

@end
