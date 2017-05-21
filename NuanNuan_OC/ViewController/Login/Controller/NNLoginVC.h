//
//  NNLoginVC.h
//  NuanNuan_OC
//
//  Created by 胡光耀 on 2017/5/20.
//  Copyright © 2017年 NuanNuan. All rights reserved.
//

#import "NNBaseVC.h"

@interface NNLoginVC : NNBaseVC
@property (weak, nonatomic) IBOutlet UITextField *userNameText;

@property (weak, nonatomic) IBOutlet UITextField *passWordTextField;

@property (weak, nonatomic) IBOutlet UIButton *loginButton;
@property (weak, nonatomic) IBOutlet UIButton *passWordButton;
@property (weak, nonatomic) IBOutlet UIButton *registerButtom;

@property (nonatomic,strong) NSString *showHudText;
@end
