//
//  NNTreeHoelViewModel.h
//  NuanNuan_OC
//
//  Created by 忘、 on 16/11/7.
//  Copyright © 2016年 NuanNuan. All rights reserved.
//

#import "NNBaseViewModel.h"

@interface NNTreeHoelViewModel : NNBaseViewModel

- (void) getTreeHoelListContentWithToken:(NSString *)token andLastTreeHoelId:(NSString *)treeHoelId andUpdatePageNum:(NSString *)pageNum;

@end
