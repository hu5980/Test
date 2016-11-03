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

- (IBAction)sendCaptchAction:(id)sender {
   
    
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
        
        [_loginOrRegisterButton setTitle:@"登录" forState:UIControlStateNormal];
        
    }else{
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
            [weakSelf dismissViewControllerAnimated:YES completion:nil];
        } WithErrorBlock:^(id errorCode) {
            
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
