//
//  NNRingImageModel.h
//  NuanNuan_OC
//
//  Created by 忘、 on 16/10/26.
//  Copyright © 2016年 NuanNuan. All rights reserved.
//

#import "NNBaseModel.h"

@interface NNRingImageModel : NNBaseModel

@property (nonatomic,strong) NSString *imageUrl ;
@property (assign) NSInteger clickNum;
@property (assign) NSInteger goodsNum;
@property (assign) NSInteger ringId;
@property (nonatomic,strong) NSString *title;
@property (assign) NSInteger createTime;

@end
