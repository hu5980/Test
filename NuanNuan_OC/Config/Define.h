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


#define NNHOMEPAGEURL  @"http://mobile.umeng.com/social"

//用的 熙康的数据  到时候再换
#define UMKEY @"57b432afe0f55a9832001a0a"

#define WEIXIN_APPKEY @"wxdc1e388c3822c80b"
#define WEIXIN_SECRET @"3baf1193c85774b3fd9d18447d76cab0"

#define QQ_APPKEY @"100735359"
#define QQ_APPSECRET  @"1a0b23a764c82f6add6a77347e1d39ba"

#define WEIBO_APPKEY @"3921700954"
#define WEIBO_APPSECRET @"04b48b094faeb16683c32669824ebdad"

#define msgAppKey   @"7a1f10938d60"
#define msgAppSecret    @"b42e890fa5487379ca087c6673c26b1a"



#define TEST_TOKEN  [[NSUserDefaults standardUserDefaults] objectForKey:@"token"]
#endif /* Define_h */
