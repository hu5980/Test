//
//  NNAboutNuanNuan.m
//  NuanNuan_OC
//
//  Created by 忘、 on 16/12/12.
//  Copyright © 2016年 NuanNuan. All rights reserved.
//

#import "NNAboutNuanNuan.h"

@interface NNAboutNuanNuan ()

@end

@implementation NNAboutNuanNuan


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navTitle = @"关于暖暖";
    [self setNavigationBackButton:YES];
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
