//
//  NNSpitslotCommentViewModel.h
//  NuanNuan_OC
//
//  Created by hu5980 on 16/11/23.
//  Copyright © 2016年 NuanNuan. All rights reserved.
//

#import "NNBaseModel.h"
#import "NNTreeHoelModel.h"
@interface NNSpitslotCommentModel : NNBaseModel
@property (nonatomic,strong) NSString *commentID;
@property (nonatomic,strong) NSString * comment;
@property (nonatomic,strong) NNTreeHoelModel *treeHoelModel;
@end
