//
//  Define.h
//  NuanNuan_OC
//
//  Created by 忘、 on 16/9/21.
//  Copyright © 2016年 NuanNuan. All rights reserved.
//

#ifndef Define_h
#define Define_h
#import "UIColor+Helper.h"
#import "UIViewExt.h"

//定义返回请求数据的block类型
typedef void (^ReturnValueBlock) (id returnValue);
typedef void (^ErrorCodeBlock) (id errorCode);
typedef void (^FailureBlock)();
typedef void (^NetWorkBlock)(BOOL netConnetState);
typedef void (^ProgressBlock)(id Progress);

//BaseURL
#define NNBaseUrl                       @"http://120.24.57.204"

//定义屏幕尺寸
#define NNScreenBounds                  [[UIScreen mainScreen] bounds]
#define NNScreenFrame                   [[UIScreen mainScreen] applicationFrame]
#define NNAppWidth                      [[UIScreen mainScreen] bounds].size.width
#define NNAppHeight                     [[UIScreen mainScreen] bounds].size.height

//加载.xib
#define LOAD_VIEW_FROM_BUNDLE(x) [[NSBundle mainBundle] loadNibNamed:x owner:self options:nil][0]

#ifdef DEBUG
#import <Foundation/Foundation.h>
#define NNLog(...) NSLog(__VA_ARGS__)
#else
#define NNLog(...)
#endif


#define NN_BACKGROUND_COLOR [UIColor colorFromHexString:@"#F4F4F4"]
#define NN_MAIN_COLOR [UIColor colorFromHexString:@"#FF8833"]
#define NN_TEXT666666_COLOR [UIColor colorFromHexString:@"#666666"]
#define NN_TEXT333333_COLOR [UIColor colorFromHexString:@"#333333"]
#define NN_TEXT999999_COLOR [UIColor colorFromHexString:@"#999999"]
#define NN_ASSIST_LINE_COLOR [UIColor colorFromHexString:@"#E0E0E0"]


#endif /* Define_h */
