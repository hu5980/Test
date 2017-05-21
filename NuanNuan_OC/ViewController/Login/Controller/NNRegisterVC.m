//
//  NNRegisterVC.m
//  NuanNuan_OC
//
//  Created by 胡光耀 on 2017/5/20.
//  Copyright © 2017年 NuanNuan. All rights reserved.
//

#import "NNRegisterVC.h"
#import "NNRegistionViewModel.h"
#import <SMS_SDK/SMSSDK.h>

@interface NNRegisterVC (){
     NSTimer *timer;
}

@end

@implementation NNRegisterVC

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"注册";
    
    _sendAuthCodeButton.layer.cornerRadius = 8;
    _sendAuthCodeButton.layer.masksToBounds = YES;
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)sendAuthCodeAction:(UIButton *)sender {
    
    if (_userNameTextField.text == nil || _userNameTextField.text.length != 11) {
        [NNProgressHUD showHudAotoHideAddToView:self.view withMessage:@"手机号码错误"];
        return;
    }
    
    if (!timer.valid) {
        [timer setFireDate:[NSDate date]];
    }
    
   
        [sender setTitle:@"59" forState:UIControlStateNormal];

        if (timer == nil) {
            timer = [NSTimer scheduledTimerWithTimeInterval:1
                                                     target:self
                                                   selector:@selector(timerSelector)
                                                   userInfo:nil
                                                    repeats:YES];
        }
        
        [SMSSDK getVerificationCodeByMethod:SMSGetCodeMethodSMS
                                phoneNumber:_userNameTextField.text
                                       zone:@"86"
                           customIdentifier:nil
                                     result:^(NSError *error){
                                         [sender setTitle:@"发送验证码" forState:UIControlStateNormal];
                                         [timer setFireDate:[NSDate distantFuture]];
                                         if (!error) {
                                         } else {
                                             [NNProgressHUD showHudAotoHideAddToView:self.view withMessage:[error.userInfo objectForKey:@"getVerificationCode"]];
                                         }
                                     }];
    

    
}
- (IBAction)registerAction:(UIButton *)sender {
    __weak NNRegisterVC *weakSelf = self;
    
    if (_userNameTextField.text.length == 0) {
        [NNProgressHUD showHudAotoHideAddToView:self.view withMessage:@"请输入用户名"];
    }
    
    if (_authCodeTextField.text.length == 0) {
        [NNProgressHUD showHudAotoHideAddToView:self.view withMessage:@"请输入验证码"];
    }
    
    if (_passWordTextField.text.length ==0) {
        [NNProgressHUD showHudAotoHideAddToView:self.view withMessage:@"请输入注册密码"];
    }
    NNRegistionViewModel *registerViewModel = [[NNRegistionViewModel alloc] init];
    [registerViewModel setBlockWithReturnBlock:^(id returnValue) {
        [weakSelf dismissViewControllerAnimated:YES completion:nil];
    } WithErrorBlock:^(id errorCode) {
        [NNProgressHUD showHudAotoHideAddToView:self.view withMessage:errorCode];
    } WithFailureBlock:^(id failureBlock) {
        [NNProgressHUD showHudAotoHideAddToView:self.view withMessage:@"注册失败"];
    }];
    [registerViewModel registerUserWithUsername:_userNameTextField.text andverify:_authCodeTextField.text andPassword:_passWordTextField.text];
}

- (void)timerSelector {
    if ([_sendAuthCodeButton.titleLabel.text isEqualToString:@"0"]) {
        [timer setFireDate:[NSDate distantFuture]];
        [_sendAuthCodeButton setTitle:@"发送验证码" forState:UIControlStateNormal];
    }else{
        NSLog(@"%@",_sendAuthCodeButton.titleLabel.text);
        
        [_sendAuthCodeButton setTitle:[NSString stringWithFormat:@"%ld",[_sendAuthCodeButton.titleLabel.text integerValue] -1] forState:UIControlStateNormal];
    }
}


- (IBAction)priviteAction:(UIButton *)sender {
    
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
