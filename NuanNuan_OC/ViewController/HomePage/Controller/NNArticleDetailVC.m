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
#import "NNAppointmentVC.h"
#import "NNArticleIsLikeViewModel.h"
#import <UMSocialCore/UMSocialCore.h>

@interface NNArticleDetailVC () {
    UIView *customView;
    UIButton *likeButton;
    UIButton  *shareBgButton;
    NSString *url;
}

@end

@implementation NNArticleDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createUI];
    [self initData];
    // Do any additional setup after loading the view from its nib.
}

- (void)createUI {
    self.view.backgroundColor = [UIColor orangeColor];
    WKWebView *webView =  [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, NNAppWidth, NNAppHeight)];
    url = [NSString stringWithFormat:@"%@/?c=static_article&a=index&id=%ld",NNBaseUrl,_articleID];
    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:url]]];
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
    
    likeButton = [UIButton buttonWithType:UIButtonTypeCustom];
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
    _isShowAppointment = YES;
    if (_isShowAppointment) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.backgroundColor = NN_MAIN_COLOR;
        button.frame = CGRectMake(0, NNAppHeight - 40, NNAppWidth, 40);
        button.titleLabel.font = [UIFont systemFontOfSize:16.f];
        [button setTitle:@"我要预约" forState:UIControlStateNormal];
        [button addTarget:self action:@selector(makeAnAppointment:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:button];
    }
    
    shareBgButton = [UIButton buttonWithType:UIButtonTypeCustom];
    shareBgButton.frame = CGRectMake(0, 0, NNAppWidth, NNAppHeight);
    shareBgButton.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.6];
    shareBgButton.hidden = YES;
    [shareBgButton addTarget:self action:@selector(hideShareButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:shareBgButton];
    
    NSArray *imageArrays = @[@"103_08",@"103_09",@"103_10",@"103_11"];
    
    for (int i = 0; i < imageArrays.count; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(70*i + (NNAppWidth - 70 * 4 ) / 2, NNAppHeight - 120, 70, 72.5);
        button.tag = 1000 + i;
        [button addTarget:self action:@selector(share:) forControlEvents:UIControlEventTouchUpInside];
        [button setBackgroundImage:[UIImage imageNamed:[imageArrays objectAtIndex:i]] forState:UIControlStateNormal];
        [shareBgButton addSubview:button];
    }
}


- (void)initData {
    NNArticleIsLikeViewModel *isLikeViewModel = [[NNArticleIsLikeViewModel alloc] init];
    [isLikeViewModel setBlockWithReturnBlock:^(id returnValue) {
        NSLog(@"%@",[[returnValue objectForKey:@"data"] objectForKey:@"good"]);
        if([[[returnValue objectForKey:@"data"] objectForKey:@"good"] boolValue]){
            likeButton.selected = YES;
        }
    } WithErrorBlock:^(id errorCode) {
        
    } WithFailureBlock:^(id failureBlock) {
        
    }];
    [isLikeViewModel getUserIsLikeTheArticleWithToken:TEST_TOKEN andType:@"3" andArticleID:[NSString stringWithFormat:@"%ld",_articleID]];
}

#pragma --mark Action
- (void)share:(UIButton *)button {
    switch (button.tag) {
        case 1000:
            [self shareWebPageToPlatformType:UMSocialPlatformType_WechatSession];
            break;
        case 1001:
            [self shareWebPageToPlatformType:UMSocialPlatformType_WechatTimeLine];
            break;
        case 1002:
            [self shareWebPageToPlatformType:UMSocialPlatformType_Qzone];
            break;
        case 1003:
            [self shareWebPageToPlatformType:UMSocialPlatformType_Sina];
            break;
        default:
            break;
    }
}


//网页分享
- (void)shareWebPageToPlatformType:(UMSocialPlatformType)platformType
{
    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    
    //创建网页内容对象
    UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:_artileTitle descr:nil thumImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:_imageUrl]]]];
    //设置网页地址
    shareObject.webpageUrl =url;
    
    //分享消息对象设置分享内容对象
    messageObject.shareObject = shareObject;
    
    //调用分享接口
    [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:self completion:^(id data, NSError *error) {
        if (error) {
            NSLog(@"************Share fail with error %@*********",error);
        }else{
            if ([data isKindOfClass:[UMSocialShareResponse class]]) {
                UMSocialShareResponse *resp = data;
                //分享结果消息
                NSLog(@"response message is %@",resp.message);
                //第三方原始返回的数据
                NSLog(@"response originalResponse data is %@",resp.originalResponse);
                
            }else{
                NSLog(@"response data is %@",data);
            }
        }
    }];
}






- (void)hideShareButton :(UIButton *)button {
    shareBgButton.hidden = YES;
}

- (void)makeAnAppointment:(UIButton *)button {
    NNAppointmentVC *appointmentVC = [[NNAppointmentVC alloc] initWithNibName:@"NNAppointmentVC" bundle:nil];
    
    [self.navigationController pushViewController:appointmentVC animated:YES];
}

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
        [NNProgressHUD showHudAotoHideAddToView:self.view withMessage:errorCode];
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
    shareBgButton.hidden = NO;
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
