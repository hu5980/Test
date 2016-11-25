//
//  NNHomePageFocusModel.h
//  NuanNuan_OC
//
//  Created by 忘、 on 16/10/18.
//  Copyright © 2016年 NuanNuan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NNSuccessCaseModel : NSObject
@property (nonatomic,strong) NSString *caseTitle;
@property (nonatomic,strong) NSString *caseImageUrl;
@property (nonatomic,strong) NSString *caseName;
@property (nonatomic,assign) NSInteger caseAdID;
@property (nonatomic,assign) NSInteger caseClickNum;
@property (nonatomic,assign) NSInteger caseGoodsNum;
@property (nonatomic,assign) NSInteger caseCreateTime;
@property (nonatomic,assign) BOOL isShowAppointment;
@end
