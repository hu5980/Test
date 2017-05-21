//
//  NNTabbarVC.m
//  NuanNuan_OC
//
//  Created by 忘、 on 16/9/21.
//  Copyright © 2016年 NuanNuan. All rights reserved.
//

#import "NNTabbarVC.h"
#import "UIColor+Helper.h"

#import "NNHomePageVC.h"
#import "NNTreeHoleVC.h"
#import "NNServerVC.h"
#import "NNMeVC.h"
#import "NNTabbarButton.h"

@interface NNTabbarVC () {
    NNTabbarButton *defaultButton;
}

@end

@implementation NNTabbarVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIView * tabbarBG = [[UIView alloc]initWithFrame:CGRectMake(0, 0, NNAppHeight, 49)];
    tabbarBG.backgroundColor = [UIColor whiteColor];
   
    
    NSArray *titleArray = @[@"主页",@"树洞",@"服务",@"我"];
    NSArray *heightImageArray = @[@"ic_home_p",@"ic_TreeHoel_p",@"ic_server_p",@"ic_me_p"];
    NSArray *normalImageArray = @[@"ic_home",@"ic_TreeHoel",@"ic_server",@"ic_me"];
    
    for (int i  = 0; i < titleArray.count; i++) {
        
        NNTabbarButton *button = [NNTabbarButton buttonWithType:UIButtonTypeCustom] ;
        [tabbarBG addSubview:button];
        button.frame = CGRectMake(i*NNAppWidth/4, 0, NNAppWidth/4, 49) ;
        [button setNormalImage:[normalImageArray objectAtIndex:i] andHeightImage:[heightImageArray objectAtIndex:i] andTitle:[titleArray objectAtIndex:i]];
        [button addTarget:self action:@selector(changeVC:) forControlEvents:UIControlEventTouchUpInside];
        button.tag = 100 + i;
        if (i == 0) {
            button.selected = YES;
            defaultButton = button;
        }
    }
    
    NNHomePageVC *homePageVC = [[NNHomePageVC alloc] init];
    NNTreeHoleVC *treeVC = [[NNTreeHoleVC alloc] init];
    NNServerVC *serverVC = [[NNServerVC alloc] init];
    NNMeVC *meVC = [[NNMeVC alloc] init];

    UINavigationController *homeNav = [[UINavigationController alloc] initWithRootViewController:homePageVC];
   
    UINavigationController *treeNav = [[UINavigationController alloc] initWithRootViewController:treeVC];
    UINavigationController *serverNav = [[UINavigationController alloc] initWithRootViewController:serverVC];
    UINavigationController *meNav = [[UINavigationController alloc] initWithRootViewController:meVC];
    
    self.viewControllers = @[homeNav,treeNav,serverNav,meNav];
    
    self.selectedIndex = 0;
    
    [self.tabBar addSubview:tabbarBG];
   
    // Do any additional setup after loading the view.
}

- (void)changeVC:(NNTabbarButton *)button {
    defaultButton.selected = NO;
    defaultButton = button;
    defaultButton.selected = YES;
    self.selectedIndex = button.tag - 100;
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
