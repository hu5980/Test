//
//  NNArticleDetailVC.h
//  NuanNuan_OC
//
//  Created by 忘、 on 16/10/26.
//  Copyright © 2016年 NuanNuan. All rights reserved.
//

#import "NNBaseVC.h"

@interface NNArticleDetailVC : NNBaseVC

@property (assign) NSInteger articleID;

@property (strong,nonatomic) NSString *artileTitle;

@property (strong,nonatomic) NSString *imageUrl;


@property (assign) BOOL isShowAppointment;


@property (assign) BOOL isFromServe;

@end
