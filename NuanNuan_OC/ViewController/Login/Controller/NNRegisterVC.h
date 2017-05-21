//
//  NNRegisterVC.h
//  NuanNuan_OC
//
//  Created by 胡光耀 on 2017/5/20.
//  Copyright © 2017年 NuanNuan. All rights reserved.
//

#import "NNBaseVC.h"

@interface NNRegisterVC : NNBaseVC
@property (weak, nonatomic) IBOutlet UIButton *sendAuthCodeButton;
@property (weak, nonatomic) IBOutlet UITextField *userNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *authCodeTextField;
@property (weak, nonatomic) IBOutlet UITextField *passWordTextField;

@end
