//
//  NNTimeUtil.h
//  NuanNuan_OC
//
//  Created by 忘、 on 16/11/8.
//  Copyright © 2016年 NuanNuan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NNTimeUtil : NSObject

+ (NSString *)timeDealWithFormat:(NSString *)format andTime:(NSInteger)time;

+ (NSString *)timeDealWithTimeFromNow:(NSInteger )time;

@end
