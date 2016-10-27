//
//  NNUserAgreementVC.m
//  NuanNuan_OC
//
//  Created by 忘、 on 16/10/27.
//  Copyright © 2016年 NuanNuan. All rights reserved.
//

#import "NNUserAgreementVC.h"

@interface NNUserAgreementVC ()

@end

@implementation NNUserAgreementVC


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavigationBackButton:YES];
    self.navTitle = @"用户协议";
    // Do any additional setup after loading the view from its nib.
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
