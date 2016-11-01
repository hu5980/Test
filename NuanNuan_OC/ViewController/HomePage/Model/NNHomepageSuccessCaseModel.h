//
//  NNHomepageSuccessCaseModel.h
//  NuanNuan_OC
//
//  Created by 忘、 on 16/10/18.
//  Copyright © 2016年 NuanNuan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NNSuccessCaseModel.h"
@interface NNHomepageSuccessCaseModel : NSObject

@property (nonatomic,strong) NSArray <NNSuccessCaseModel *> *loveStoryArray;

@property (nonatomic,strong) NSArray <NNSuccessCaseModel *> *redeemStoryArray;

@property (nonatomic,strong) NSArray <NNSuccessCaseModel *> *improvementArray;

@end
