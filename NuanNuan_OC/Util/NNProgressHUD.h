//
//  NNProgressHUD.h
//  NuanNuan_OC
//
//  Created by 忘、 on 16/11/3.
//  Copyright © 2016年 NuanNuan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MBProgressHUD.h"
@interface NNProgressHUD : NSObject

@property (readonly) MBProgressHUD *progressHud;

+ (instancetype)instance;

+ (void)showHudAotoHideAddToView:(UIView *)view withMessage:(NSString *)meaasge;

- (void)showHudToView:(UIView *)view withMessage:(NSString *)meaasge;

- (void)showHudToView:(UIView *)view;

- (void)hideHud;

@end
