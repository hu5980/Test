//
//  NNCommentModel.h
//  NuanNuan_OC
//
//  Created by 忘、 on 16/11/11.
//  Copyright © 2016年 NuanNuan. All rights reserved.
//

#import "NNBaseModel.h"

@interface NNCommentModel : NNBaseModel

@property (nonatomic,strong) NSString *commentID;
@property (nonatomic,strong) NSString *commentUID;
@property (nonatomic,strong) NSString *commentOID;
@property (nonatomic,strong) NSString *commentType;
@property (nonatomic,strong) NSString *commentContent;
@property (nonatomic,strong) NSString *commentGoodsNum;
@property (nonatomic,strong) NSString *commentIsdel;
@property (nonatomic,strong) NSString *commentHeaderUrl;
@property (nonatomic,strong) NSString *commentNickName;
@property (nonatomic,assign) NSInteger commentCreateTime;
@property (nonatomic,assign) NSInteger commentModifyTime;

@property (nonatomic,assign) BOOL  commentHasGood;
@end
