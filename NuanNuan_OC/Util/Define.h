//
//  Define.h
//  NuanNuan_OC
//
//  Created by 忘、 on 16/9/21.
//  Copyright © 2016年 NuanNuan. All rights reserved.
//

#ifndef Define_h
#define Define_h

#import "UIViewExt.h"
//定义屏幕尺寸
#define NNScreenBounds                  [[UIScreen mainScreen] bounds]
#define NNScreenFrame                   [[UIScreen mainScreen] applicationFrame]
#define NNAppWidth                      [[UIScreen mainScreen] bounds].size.width
#define NNAppHeight                     [[UIScreen mainScreen] bounds].size.height

#ifdef DEBUG
#import <Foundation/Foundation.h>
#define NNLog(...) NSLog(__VA_ARGS__)
#else
#define NNLog(...)
#endif


#endif /* Define_h */
