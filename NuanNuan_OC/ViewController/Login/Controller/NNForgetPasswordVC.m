//
//  NNForgetPasswordVC.m
//  NuanNuan_OC
//
//  Created by hu5980 on 16/11/20.
//  Copyright © 2016年 NuanNuan. All rights reserved.
//

#import "NNForgetPasswordVC.h"
#import <SMS_SDK/SMSSDK.h>
#import "NNLoginVC.h"

#import "NNChangePasswordViewModel.h"
@interface NNForgetPasswordVC ()
{
     NSTimer *timer;
}
@property (strong, nonatomic) IBOutlet UIButton *authCodeButton;
@property (strong, nonatomic) IBOutlet UIButton *sendButton;
@property (strong, nonatomic) IBOutlet UITextField *userNameTextField;

@property (strong, nonatomic) IBOutlet UITextField *authCodeTextField;

@property (strong, nonatomic) IBOutlet UITextField *authNewPasswordTextField;

@end

@implementation NNForgetPasswordVC

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
    
   

}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self initUI];
    // Do any additional setup after loading the view from its nib.
}

- (void)initUI {
    self.navTitle = @"忘记密码";
    [self setNavigationBackButton:YES];
    
    _authCodeButton.layer.masksToBounds = YES;
    _authCodeButton.layer.cornerRadius = 5;
    
    _sendButton.layer.masksToBounds = YES;
    _sendButton.layer.cornerRadius = 5;
    
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(closeKeyboard)];
    
    [self.view addGestureRecognizer:tapGestureRecognizer];

}
- (IBAction)changePasswordAction:(UIButton *)sender {
    if (_userNameTextField.text.length == 0 ) {
        [NNProgressHUD showHudAotoHideAddToView:self.view withMessage:@"请输入手机号码"];
        return;
    }
    
    if (_authCodeTextField.text.length == 0 ) {
        [NNProgressHUD showHudAotoHideAddToView:self.view withMessage:@"请输入验证码"];
        return;
    }
    
    if (_authNewPasswordTextField.text.length <= 5 ) {
        [NNProgressHUD showHudAotoHideAddToView:self.view withMessage:@"请输入正确的新密码"];
        return;
    }
    
    
    NNChangePasswordViewModel *changePasswordViewModel = [[NNChangePasswordViewModel alloc] init];
    
    [changePasswordViewModel setBlockWithReturnBlock:^(id returnValue) {
        if ([returnValue isEqualToString:@"success"]) {
            [NNProgressHUD showHudAotoHideAddToView:self.view withMessage:@"修改成功"];
        }
    } WithErrorBlock:^(id errorCode) {
        [NNProgressHUD showHudAotoHideAddToView:self.view withMessage:errorCode];

    } WithFailureBlock:^(id failureBlock) {
        
    }];
    
    [changePasswordViewModel changePasswordWithtTel:_userNameTextField.text andCode:_authCodeTextField.text andPassword:_authNewPasswordTextField.text ];
    
}
- (IBAction)getAuthCodeAction:(UIButton *)sender {

    if (_userNameTextField.text == nil || _userNameTextField.text.length != 11) {
        [NNProgressHUD showHudAotoHideAddToView:self.view withMessage:@"手机号码错误"];
        return;
    }
    if (timer != nil) {
        [timer setFireDate:[NSDate date]];
    }
    
    
    if (timer == nil) {
        timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timerSelector) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:timer forMode:UITrackingRunLoopMode];
        
    }
    [sender setTitle:@"59" forState:UIControlStateNormal];
    [SMSSDK getVerificationCodeByMethod:SMSGetCodeMethodSMS
                            phoneNumber:_userNameTextField.text
                                   zone:@"86"
                       customIdentifier:nil
                                 result:^(NSError *error){
                                     //                                         [sender setTitle:@"发送验证码" forState:UIControlStateNormal];
                                     //                                         [timer setFireDate:[NSDate distantFuture]];
                                     if (!error) {
                                     } else {
                                         [NNProgressHUD showHudAotoHideAddToView:self.view withMessage:[error.userInfo objectForKey:@"getVerificationCode"]];
                                     }
                                 }];

}

- (void)timerSelector {
    if ([_authCodeButton.titleLabel.text isEqualToString:@"0"]) {
        [timer setFireDate:[NSDate distantFuture]];
        [_authCodeButton setTitle:@"发送验证码" forState:UIControlStateNormal];
    }else{
        NSLog(@"%@",_authCodeButton.titleLabel.text);
        
        [_authCodeButton setTitle:[NSString stringWithFormat:@"%ld",[_authCodeButton.titleLabel.text integerValue] -1] forState:UIControlStateNormal];
    }
}

- (void)closeKeyboard {
    if ([_userNameTextField isFirstResponder]) {
        [_userNameTextField resignFirstResponder];
    }
    
    if ([_authCodeTextField isFirstResponder]) {
        [_authCodeTextField resignFirstResponder];
    }
    
    if ([_authNewPasswordTextField isFirstResponder]) {
        [_authNewPasswordTextField resignFirstResponder];
    }
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
