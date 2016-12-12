//
//  NNLoginVC.m
//  NuanNuan_OC
//
//  Created by 忘、 on 16/10/25.
//  Copyright © 2016年 NuanNuan. All rights reserved.
//

#import "NNLoginAndRegisterVC.h"
#import "NNLoginViewModel.h"
#import "NNRegistionViewModel.h"
#import "NNUserInfoModel.h"
#import "NNForgetPasswordVC.h"
#import <UMSocialCore/UMSocialCore.h>
#import "NNThirdLoginViewModel.h"
#import <SMS_SDK/SMSSDK.h>

@interface NNLoginAndRegisterVC (){
    UIButton *defaultButton;
}
@property (weak, nonatomic) IBOutlet UIView *registerView;
@property (weak, nonatomic) IBOutlet UIView *loginView;
@property (weak, nonatomic) IBOutlet UITextField *loginUserNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *loginPassWordTextField;
@property (weak, nonatomic) IBOutlet UITextField *registerUserNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *registerCaptchatextField;
@property (weak, nonatomic) IBOutlet UITextField *registerPassWordTextField;
@property (weak, nonatomic) IBOutlet UIButton *captchButton;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *loginOrRegisterButtonConstraint;
@property (weak, nonatomic) IBOutlet UIView *loginSelectView;
@property (weak, nonatomic) IBOutlet UIView *registerSelectView;
@property (weak, nonatomic) IBOutlet UIButton *loginOrRegisterButton;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;
@property (weak, nonatomic) IBOutlet UIButton *registerButton;
@property (strong, nonatomic) IBOutlet UIButton *forgetPasswordButton;
@end

@implementation NNLoginAndRegisterVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createUI];
    // Do any additional setup after loading the view from its nib.
}

- (void)createUI {
    _registerSelectView.hidden = YES;
    _registerView.hidden = YES;
    _loginOrRegisterButtonConstraint.constant = 126;
    _loginPassWordTextField.secureTextEntry = YES;
    _registerView.layer.masksToBounds = YES;
    _registerView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.5];
    _registerView.layer.cornerRadius = 5;
    _registerPassWordTextField.secureTextEntry = YES;
    _loginView.layer.masksToBounds = YES;
    _loginView.layer.cornerRadius = 5;
    _loginView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.5];
    _captchButton.layer.masksToBounds = YES;
    _captchButton.layer.cornerRadius = 5;
    _loginOrRegisterButton.layer.masksToBounds = YES;
    _loginOrRegisterButton.layer.cornerRadius = 5;

    defaultButton = _loginButton;
}

- (IBAction)thirdlyLoginAction:(UIButton *)sender {
    switch (sender.tag) {
        case 500:
            [self getUserInfoFromWechat];
            break;
        case 501:
            [self getUserInfoFromQQ];
            break;
        case 502:
            [self getUserInfoFromSina];
            break;
        default:
            break;
    }
}

- (IBAction)sendCaptchAction:(id)sender {
    [SMSSDK getVerificationCodeByMethod:SMSGetCodeMethodSMS phoneNumber:@"18684599240"
                                   zone:@"86"
                       customIdentifier:nil
                                 result:^(NSError *error){
                                     if (!error) {
                                         NSLog(@"获取验证码成功");
                                     } else {
                                         NSLog(@"错误信息：%@",error);
                                        }
                                     }];
    
    
}
- (IBAction)loginOrRegisterSelectAction:(UIButton *)sender {
    defaultButton .selected = NO;
    defaultButton = sender;
    defaultButton.selected = YES;
    if (sender.tag == 100) {
        _registerSelectView.hidden = YES;
        _registerView.hidden = YES;
        _loginOrRegisterButtonConstraint.constant = 126;
        _loginView.hidden = NO;
        _loginSelectView.hidden = NO;
        _forgetPasswordButton.hidden = NO;
        [_loginOrRegisterButton setTitle:@"登录" forState:UIControlStateNormal];
        
    }else{
        _forgetPasswordButton.hidden = YES;
        _registerSelectView.hidden = NO;
        _registerView.hidden = NO;
        _loginOrRegisterButtonConstraint.constant = 170;
        _loginView.hidden = YES;
        _loginSelectView.hidden = YES;
        [_loginOrRegisterButton setTitle:@"注册" forState:UIControlStateNormal];
    }
}
- (IBAction)loginOrRegisterAction:(UIButton *)sender {
    __weak  NNLoginAndRegisterVC *weakSelf = self;
    if (defaultButton.tag == 100) {
        NNLog(@"登录");
        [[NNProgressHUD instance] showHudToView:self.view ];
        
        if (_loginUserNameTextField.text.length == 0) {
           [NNProgressHUD showHudAotoHideAddToView:self.view withMessage:@"请输入用户名"];
            return;
        }
        
        if (_loginPassWordTextField.text.length ==0) {
            [NNProgressHUD showHudAotoHideAddToView:self.view withMessage:@"请输入登录密码"];
             return;
        }
      
        NNLoginViewModel *loginViewModel = [[NNLoginViewModel alloc] init];
        [loginViewModel setBlockWithReturnBlock:^(id returnValue) {
            [[NNProgressHUD instance] hideHud];
            if (_isPresent) {
                [weakSelf dismissViewControllerAnimated:YES completion:nil];
            }else{
                [weakSelf.navigationController popViewControllerAnimated:YES];
            }
        } WithErrorBlock:^(id errorCode) {
            [NNProgressHUD  showHudAotoHideAddToView:self.view withMessage:errorCode];
        } WithFailureBlock:^(id failureBlock) {
            
        }];
        [loginViewModel loginWithUserName:_loginUserNameTextField.text andpassword:_loginPassWordTextField.text andLoginType:1];
        
    }else{
        
        if (_registerUserNameTextField.text.length == 0) {
            [NNProgressHUD showHudAotoHideAddToView:self.view withMessage:@"请输入用户名"];
        }
        
        if (_registerCaptchatextField.text.length == 0) {
            [NNProgressHUD showHudAotoHideAddToView:self.view withMessage:@"请输入验证码"];
        }
        
        if (_registerPassWordTextField.text.length ==0) {
             [NNProgressHUD showHudAotoHideAddToView:self.view withMessage:@"请输入注册密码"];
        }
        
        NNRegistionViewModel *registerViewModel = [[NNRegistionViewModel alloc] init];
        
        
        [registerViewModel setBlockWithReturnBlock:^(id returnValue) {
            [weakSelf dismissViewControllerAnimated:YES completion:nil];
        } WithErrorBlock:^(id errorCode) {
            
        } WithFailureBlock:^(id failureBlock) {
            
        }];
        [registerViewModel registerUserWithUsername:_registerUserNameTextField.text andverify:_registerCaptchatextField.text andPassword:_registerPassWordTextField.text];
    }
    
  
}

- (IBAction)forgetPasswordAction:(UIButton *)sender {
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
      __weak  NNLoginAndRegisterVC *weakSelf = self;
    [[NNProgressHUD instance] showHudToView:self.view withMessage:@"登录中..."];
    NNThirdLoginViewModel *viewModel = [[NNThirdLoginViewModel alloc] init];
    [viewModel setBlockWithReturnBlock:^(id returnValue) {
        [[NNProgressHUD instance] hideHud];
        if (_isPresent) {
            [weakSelf dismissViewControllerAnimated:YES completion:nil];
        }else{
            [weakSelf.navigationController popViewControllerAnimated:YES];
        };

    } WithErrorBlock:^(id errorCode) {
        
        [NNProgressHUD showHudAotoHideAddToView:self.view withMessage:errorCode];
         [[NNProgressHUD instance] hideHud];
    } WithFailureBlock:^(id failureBlock) {
        
    }];
    [viewModel loginWithLoginType:type andAccessToken:accessToken andOpenId:openid];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
