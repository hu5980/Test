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
typedef void (^ReturnValueBlock) (id returnValue );
typedef void (^ErrorCodeBlock) (id errorCode);
typedef void (^FailureBlock)(id failureBlock);
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

#define DEBUG    1

#ifdef DEBUG
#import <Foundation/Foundation.h>
#define NNLog(...)  NSLog(__VA_ARGS__)
#else
#define NNLog(...)
#endif


#define NN_BACKGROUND_COLOR [UIColor colorFromHexString:@"#F4F4F4"]
#define NN_MAIN_COLOR [UIColor colorFromHexString:@"#333333"]
#define NN_TEXT666666_COLOR [UIColor colorFromHexString:@"#666666"]
#define NN_TEXT333333_COLOR [UIColor colorFromHexString:@"#333333"]
#define NN_TEXT999999_COLOR [UIColor colorFromHexString:@"#999999"]
#define NN_ASSIST_LINE_COLOR [UIColor colorFromHexString:@"#E0E0E0"]

#define NN_SECOND_COLOR [UIColor colorWithRed:242 / 255.0 green:153/255.0 blue:158 / 255.0 alpha:1]

#define USERID  [[NSUserDefaults standardUserDefaults] objectForKey:@"currentUserID"]

#define NNHOMEPAGEURL  @"http://www.mynuannuan.com"

//用的 熙康的数据  到时候再换
#define UMKEY @"583827c15312dd68090014c7"
#define UM_SECRET @"l6ulybdiix7muiirxw5hzdctzcocnwio"

#define WEIXIN_APPKEY @"wx4011a699aa70dc35"
#define WEIXIN_SECRET @"3351830c4abf3b0925870edd08e1ad2f"

#define QQ_APPKEY @"1105876553"
#define QQ_APPSECRET  @"Pjj2IHnHSIZTyTRv"

#define WEIBO_APPKEY @"3807471758"
#define WEIBO_APPSECRET @"cf8e95a52dfc1c1921b4abab6c1c368e"

#define msgAppKey   @"19979a0c7b7d0"
#define msgAppSecret    @"5cffdc3e72435bda648f78ffa8df3856"

#define ALIFEEDBACK_APPKEY @"23542027"
#define ALIFEEDBACK_APPSECRET @"075c5d32aa682d7f57c65e2382badf9b"

#define JSPATCHKEY  @"e7989a31d332357f"

#define TEST_TOKEN  [[NSUserDefaults standardUserDefaults] objectForKey:@"token"]

#define USERID  [[NSUserDefaults standardUserDefaults] objectForKey:@"currentUserID"]
#endif /* Define_h */
