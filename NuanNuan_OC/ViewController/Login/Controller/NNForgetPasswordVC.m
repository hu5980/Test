//
//  NNForgetPasswordVC.m
//  NuanNuan_OC
//
//  Created by hu5980 on 16/11/20.
//  Copyright © 2016年 NuanNuan. All rights reserved.
//

#import "NNForgetPasswordVC.h"

@interface NNForgetPasswordVC ()
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

}
- (IBAction)changePasswordAction:(UIButton *)sender {
}
- (IBAction)getAuthCodeAction:(UIButton *)sender {
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
