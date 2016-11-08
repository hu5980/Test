//
//  NNProgressHUD.m
//  NuanNuan_OC
//
//  Created by 忘、 on 16/11/3.
//  Copyright © 2016年 NuanNuan. All rights reserved.
//

#import "NNProgressHUD.h"

@implementation NNProgressHUD

+ (void) showHudAotoHideAddToView:(UIView *)view withMessage:(NSString *)meaasge {
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.labelText = meaasge;
    hud.mode = MBProgressHUDModeText;
    [hud hide:YES afterDelay:2];
}

@end
