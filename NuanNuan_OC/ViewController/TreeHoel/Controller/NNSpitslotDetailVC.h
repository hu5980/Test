//
//  NNSpitslotDetailVC.h
//  NuanNuan_OC
//
//  Created by hu5980 on 16/10/23.
//  Copyright © 2016年 NuanNuan. All rights reserved.
//

#import "NNBaseVC.h"
#import "NNTreeHoelModel.h"
@interface NNSpitslotDetailVC : NNBaseVC

@property (nonatomic,strong) NNTreeHoelModel *model;
@property (nonatomic,strong) NSMutableArray *commentMutableArray;

@property (nonatomic,assign) BOOL isFromNotice;
@property (assign,nonatomic) BOOL isComment;

@end
