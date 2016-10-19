//
//  NNHomePageFocusModel.h
//  NuanNuan_OC
//
//  Created by 忘、 on 16/10/18.
//  Copyright © 2016年 NuanNuan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NNSuccessCaseModel : NSObject
@property (nonatomic,strong) NSString *focusTitle;
@property (nonatomic,strong) NSString *focusImageUrl;
@property (nonatomic,strong) NSString *focusName;
@property (nonatomic,assign) NSInteger focusAdID;
@property (nonatomic,assign) NSInteger focusClickNum;
@property (nonatomic,assign) NSInteger focusGoodsNum;
@property (nonatomic,assign) NSInteger focusCreateTime;
@end
