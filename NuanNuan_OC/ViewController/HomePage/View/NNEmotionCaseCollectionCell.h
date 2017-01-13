//
//  NNEmotionCaseCollectionCell.h
//  NuanNuan_OC
//
//  Created by 忘、 on 17/1/11.
//  Copyright © 2017年 NuanNuan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NNSuccessCaseModel.h"

typedef void(^entryArticleBlock)(NNSuccessCaseModel *model);

@interface NNEmotionCaseCollectionCell : UICollectionViewCell
@property (nonatomic,assign) NSInteger defaultType;
@property (nonatomic,copy) entryArticleBlock block;
@end
