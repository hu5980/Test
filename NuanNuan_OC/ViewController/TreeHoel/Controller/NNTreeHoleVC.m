//
//  NNTreeHoleVC.m
//  NuanNuan_OC
//
//  Created by 忘、 on 16/9/21.
//  Copyright © 2016年 NuanNuan. All rights reserved.
//

#import "NNTreeHoleVC.h"
#import "NNCustomNavigationView.h"
@interface NNTreeHoleVC ()

@end

@implementation NNTreeHoleVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    [self initData];
    // Do any additional setup after loading the view.
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
}

- (void)initUI {
    [self.navigationController setNavigationBarHidden:NO];
    NNCustomNavigationView *view = LOAD_VIEW_FROM_BUNDLE(@"NNCustomNavigationView");
    view.backgroundColor = [UIColor clearColor];
    self.navigationItem.titleView = view;
}

- (void)initData {
    
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
