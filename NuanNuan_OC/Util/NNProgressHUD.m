//
//  NNProgressHUD.m
//  NuanNuan_OC
//
//  Created by 忘、 on 16/11/3.
//  Copyright © 2016年 NuanNuan. All rights reserved.
//

#import "NNProgressHUD.h"

@implementation NNProgressHUD

static NNProgressHUD *instance;

+ (instancetype)instance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[NNProgressHUD alloc] init];
    });
    return instance;
}

+ (void) showHudAotoHideAddToView:(UIView *)view withMessage:(NSString *)meaasge {
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.labelText = meaasge;
    hud.mode = MBProgressHUDModeText;
    [hud hide:YES afterDelay:2];
}


- (void)showHudToView:(UIView *)view withMessage:(NSString *)meaasge{
    _progressHud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    _progressHud.labelText = meaasge;
    _progressHud.mode = MBProgressHUDModeText;
    [_progressHud show:YES];
}

- (void)showHudToView:(UIView *)view{
    _progressHud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    _progressHud.mode = MBProgressHUDModeIndeterminate;
    [_progressHud show:YES];
}

- (void)hideHud {
    [_progressHud hide:YES];
}

@end
