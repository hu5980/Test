//
//  NNArticleDetailVC.m
//  NuanNuan_OC
//
//  Created by 忘、 on 16/10/26.
//  Copyright © 2016年 NuanNuan. All rights reserved.
//

#import "NNArticleDetailVC.h"
#import <WebKit/WebKit.h>
#import "NNPariseViewModel.h"
#import "NNUnPariseViewModel.h"

@interface NNArticleDetailVC () {
    UIView *customView;
}

@end

@implementation NNArticleDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createUI];
    // Do any additional setup after loading the view from its nib.
}

- (void)createUI {
    
    self.view.backgroundColor = [UIColor orangeColor];
    
    WKWebView *webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, NNAppWidth, NNAppHeight)];
    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/?c=static_article&a=index&id=%ld",NNBaseUrl,_articleID]]]];
    [self.view addSubview:webView];
    
    customView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, NNAppWidth, 64)];
    customView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:customView];
    
    
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    backButton.frame = CGRectMake(15, 26, 32, 32);
    [backButton setBackgroundImage:[UIImage imageNamed:@"103_03"] forState:UIControlStateNormal];
    [backButton setBackgroundImage:[UIImage imageNamed:@"103_03_p"] forState:UIControlStateHighlighted];
    [backButton addTarget:self action:@selector(popAction:) forControlEvents:UIControlEventTouchUpInside];
    [customView addSubview:backButton];
    
    UIButton *likeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    likeButton.frame = CGRectMake(NNAppWidth - 15 - 32, 26, 32, 32);
    [likeButton setBackgroundImage:[UIImage imageNamed:@"103_07"] forState:UIControlStateNormal];
    [likeButton setBackgroundImage:[UIImage imageNamed:@"103_07_p"] forState:UIControlStateHighlighted];
    [likeButton setBackgroundImage:[UIImage imageNamed:@"103_07_p"] forState:UIControlStateSelected];
    [likeButton addTarget:self action:@selector(likeAction:) forControlEvents:UIControlEventTouchUpInside];
    [customView addSubview:likeButton];
    
    
    UIButton *shareButton = [UIButton buttonWithType:UIButtonTypeCustom];
    shareButton.frame = CGRectMake(NNAppWidth - 15*2 - 32 * 2, 26, 32, 32);
    [shareButton setBackgroundImage:[UIImage imageNamed:@"103_05"] forState:UIControlStateNormal];
    [shareButton setBackgroundImage:[UIImage imageNamed:@"103_05_p"] forState:UIControlStateHighlighted];
    [shareButton addTarget:self action:@selector(shareAction:) forControlEvents:UIControlEventTouchUpInside];
    [customView addSubview:shareButton];
    
    
}

#pragma --mark Action 
- (void)popAction:(UIButton *)button {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)likeAction:(UIButton *)button {
    NNPariseViewModel  *viewModel = [[NNPariseViewModel alloc] init];
    [viewModel setBlockWithReturnBlock:^(id returnValue) {
        if([returnValue isEqualToString:@"success"]){
            button.selected = YES;
        }
    } WithErrorBlock:^(id errorCode) {
        
    } WithFailureBlock:^(id failureBlock) {
        
    }];
    
    NNUnPariseViewModel *unViewModel = [[NNUnPariseViewModel alloc] init];
    [unViewModel setBlockWithReturnBlock:^(id returnValue) {
        if([returnValue isEqualToString:@"success"]){
            button.selected = NO;
        }
    } WithErrorBlock:^(id errorCode) {
    } WithFailureBlock:^(id failureBlock) {
    }];
    
    
    if (button.selected) {
        [unViewModel unParisdArticleWithToken:TEST_TOKEN andArticleType:[NSString stringWithFormat:@"%ld",_defaultType] andArticleID:[NSString stringWithFormat:@"%ld",_articleID]];
    }else{
        [viewModel parisdArticleWithToken:TEST_TOKEN andArticleType:[NSString stringWithFormat:@"%ld",_defaultType] andArticleID:[NSString stringWithFormat:@"%ld",_articleID]];
    }
}

- (void)shareAction:(UIButton *)button {
    
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
