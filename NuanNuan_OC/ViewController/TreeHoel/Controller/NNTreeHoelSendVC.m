//
//  NNTreeHoelSendVC.m
//  NuanNuan_OC
//
//  Created by 胡光耀 on 16/11/19.
//  Copyright © 2016年 NuanNuan. All rights reserved.
//

#import "NNTreeHoelSendVC.h"

@interface NNTreeHoelSendVC ()

@end

@implementation NNTreeHoelSendVC

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
    self.view.backgroundColor = NN_BACKGROUND_COLOR;
    [self setNavigationBackButton:YES];
    self.navTitle = @"发表树洞";
    [self setNavigationRightItem:@"发送"];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.backgroundColor = [UIColor clearColor];
    [button setBackgroundImage:[UIImage imageNamed:@"addimage"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(addImageAction:) forControlEvents:UIControlEventTouchUpInside];
    [_imageView addSubview:button];
}


#pragma --mark Action
- (void)addImageAction:(UIButton *)button {

}

- (void)rightItemAction:(UIBarButtonItem *)item {

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
