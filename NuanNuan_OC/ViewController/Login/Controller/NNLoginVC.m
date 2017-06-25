//
//  NNLoginVC.m
//  NuanNuan_OC
//
//  Created by 胡光耀 on 2017/5/20.
//  Copyright © 2017年 NuanNuan. All rights reserved.
//

#import "NNLoginVC.h"
#import "NNLoginViewModel.h"
#import "NNRegistionViewModel.h"
#import "NNUserInfoModel.h"
#import "NNForgetPasswordVC.h"
#import <UMSocialCore/UMSocialCore.h>
#import "NNThirdLoginViewModel.h"
#import <SMS_SDK/SMSSDK.h>
#import "NNRegisterVC.h"

@interface NNLoginVC ()

@end

@implementation NNLoginVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if(_showHudText){
        [NNProgressHUD showHudAotoHideAddToView:self.view withMessage:_showHudText];
    }
    
  
    // Do any additional setup after loading the view from its nib.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if (self.isPresent) {
         [self.navigationController setNavigationBarHidden:NO];
        [self setNavigationBackButton:YES];
        self.title = @"登录";
    }
   
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)loginAction:(UIButton *)sender {
    __weak  NNLoginVC *weakSelf = self;
    NNLog(@"登录");
    if (_userNameText.text.length == 0) {
        [NNProgressHUD showHudAotoHideAddToView:self.view withMessage:@"请输入用户名"];
        return;
    }
    
    if (_passWordTextField.text.length ==0) {
        [NNProgressHUD showHudAotoHideAddToView:self.view withMessage:@"请输入登录密码"];
        return;
    }
    
    [[NNProgressHUD instance] showHudToView:self.view ];
    NNLoginViewModel *loginViewModel = [[NNLoginViewModel alloc] init];
    [loginViewModel setBlockWithReturnBlock:^(id returnValue) {
        [[NNProgressHUD instance] hideHud];
        if (self.isPresent) {
            [weakSelf dismissViewControllerAnimated:YES completion:nil];
        }else{
            [weakSelf.navigationController popViewControllerAnimated:YES];
        }
    } WithErrorBlock:^(id errorCode) {
        [[NNProgressHUD instance] hideHud];
        [NNProgressHUD  showHudAotoHideAddToView:self.view withMessage:errorCode];
    } WithFailureBlock:^(id failureBlock) {
        [[NNProgressHUD instance] hideHud];
    }];
    [loginViewModel loginWithUserName:_userNameText.text andpassword:_passWordTextField.text andLoginType:1];
    
}

- (IBAction)thridLoginAction:(UIButton *)sender {
    switch (sender.tag) {
        case 100:
            [self getUserInfoFromWechat];
            [MobClick event:@"clk_RgstWX"];
            break;
        case 101:
            [self getUserInfoFromQQ];
            [MobClick event:@"clk_RgstQQ"];
            break;
        case 102:
            [self getUserInfoFromSina];
            [MobClick event:@"clk_RgstWb"];
            break;
        default:
            break;
    }
}


- (void)popVC {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)gotoRegisterAction:(UIButton *)sender {
    NNRegisterVC *registerVC = [[NNRegisterVC alloc] initWithNibName:@"NNRegisterVC" bundle:nil];
    [self.navigationController pushViewController:registerVC animated:YES];
}

- (IBAction)forgetAction:(UIButton *)sender {
    
    NNForgetPasswordVC *forgetVC = [[NNForgetPasswordVC alloc] init];
   
    [self.navigationController pushViewController:forgetVC animated:YES];
    
}

- (void)getUserInfoFromWechat
{
    [[UMSocialManager defaultManager] getUserInfoWithPlatform:UMSocialPlatformType_WechatSession currentViewController:nil completion:^(id result, NSError *error) {
        if (error) {
            NSLog(@"WeChat Error = %@",error);
        } else {
            UMSocialUserInfoResponse *resp = result;
            
            [self loginWithLoginType:@"wx" andAccessToken:resp.accessToken andOpenId:resp.openid];
        }
    }];
}

- (void)getUserInfoFromSina
{
    [[UMSocialManager defaultManager] getUserInfoWithPlatform:UMSocialPlatformType_Sina currentViewController:nil completion:^(id result, NSError *error) {
        if (error) {
            NSLog(@"sina Error = %@",error.description);
        } else {
            UMSocialUserInfoResponse *resp = result;
            [self loginWithLoginType:@"wb" andAccessToken:resp.accessToken andOpenId:nil];
        }
    }];
}

- (void)getUserInfoFromQQ
{
    [[UMSocialManager defaultManager] getUserInfoWithPlatform:UMSocialPlatformType_QQ currentViewController:nil completion:^(id result, NSError *error) {
        if (error) {
            NSLog(@"QQ Error = %@",error);
        } else {
            UMSocialUserInfoResponse *resp = result;
            [self loginWithLoginType:@"qq" andAccessToken:resp.accessToken andOpenId:nil];
        }
    }];
}





- (void)loginWithLoginType:(NSString *)type andAccessToken:(NSString *)accessToken andOpenId:(NSString *)openid {
    [MobClick event:@"clk_RgstLogin"];
    __weak  NNLoginVC *weakSelf = self;
    [[NNProgressHUD instance] showHudToView:self.view withMessage:@"登录中..."];
    NNThirdLoginViewModel *viewModel = [[NNThirdLoginViewModel alloc] init];
    [viewModel setBlockWithReturnBlock:^(id returnValue) {
        [[NNProgressHUD instance] hideHud];
//        if (self.isPresent) {
//            [weakSelf navigationController:YES completion:nil];
//        }else{
            [weakSelf.navigationController popViewControllerAnimated:YES];
//        };
        
    } WithErrorBlock:^(id errorCode) {
        
        [NNProgressHUD showHudAotoHideAddToView:self.view withMessage:errorCode];
        [[NNProgressHUD instance] hideHud];
    } WithFailureBlock:^(id failureBlock) {
        
    }];
    [viewModel loginWithLoginType:type andAccessToken:accessToken andOpenId:openid];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
