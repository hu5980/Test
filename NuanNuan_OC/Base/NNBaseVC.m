//
//  NNBaseVC.m
//  NuanNuan_OC
//
//  Created by 忘、 on 16/9/21.
//  Copyright © 2016年 NuanNuan. All rights reserved.
//

#import "NNBaseVC.h"
#import "NNLoginVC.h"
@interface NNBaseVC ()
{
    UIBarButtonItem *leftItem;
    UIBarButtonItem *rightItem;
    
    UIImageView *backgroundImageView;
    UILabel   *describeLabel;
}
@end

@implementation NNBaseVC

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if (self.tabBarController != nil ) {
        [self.navigationController setNavigationBarHidden:YES];
    }else{
        [self.navigationController setNavigationBarHidden:NO];
    }
   
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.automaticallyAdjustsScrollViewInsets = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //注册键盘出现的通知
    
    [[NSNotificationCenter defaultCenter] addObserver:self
     
                                             selector:@selector(keyboardWillShow:)
     
                                                 name:UIKeyboardWillShowNotification object:nil];
    
    //注册键盘消失的通知
    
    [[NSNotificationCenter defaultCenter] addObserver:self
     
                                             selector:@selector(keyboardWillHide:)
     
                                                 name:UIKeyboardWillHideNotification object:nil];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginAgein:) name:@"loginAgain" object:nil];
   
    // Do any additional setup after loading the view.
}

- (void)setNavigationBackButton:(BOOL ) showOrHidden; {
    if (leftItem == nil) {
        leftItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"ic_leftArrow"] style:UIBarButtonItemStylePlain target:self action:@selector(popVC)];
        leftItem.tintColor = [UIColor colorFromHexString:@"#666666"];
    }
    if (showOrHidden) {
        self.navigationItem.leftBarButtonItem = leftItem;
    }else{
        self.navigationItem.leftBarButtonItem = nil;
    }
}


- (void)setNavigationRightItem:(NSString *)title {
    if (rightItem == nil) {
        rightItem = [[UIBarButtonItem alloc] initWithTitle: title style:UIBarButtonItemStylePlain target:self action:@selector(rightItemAction:)];
        [rightItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont boldSystemFontOfSize:14],NSFontAttributeName, nil] forState:UIControlStateNormal ];
        rightItem.tintColor = [UIColor colorFromHexString:@"#666666"];
    }

    self.navigationItem.rightBarButtonItem = rightItem;
}

- (void)rightItemAction:(UIBarButtonItem *) item {

}

- (void)keyboardWillShow:(NSNotification*)notification{
       
    
}

- (void)keyboardWillHide:(NSNotification*)notification{
    
   
    
}

- (void)loginAgein:(NSNotification *)nitification {
     NNLoginVC *loginVC = [[NNLoginVC alloc] initWithNibName:@"NNLoginVC" bundle:nil];
    loginVC.isPresent = YES;
    loginVC.showHudText = [nitification object];
    [self presentViewController:loginVC animated:YES completion:^{
        
    }];

}

- (void)setNavTitle:(NSString *)navTitle{
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    titleLabel.textColor = [UIColor colorFromHexString:@"#666666"];
    titleLabel.font = [UIFont systemFontOfSize:18.f];
    titleLabel.text =navTitle;
    [titleLabel sizeToFit];
    self.navigationItem.titleView = titleLabel;
}

- (void)popVC {
    if (_isPresent) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }else{
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)dealloc {
     [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)showBackgroundViewImageName:(NSString *)imageName andTitle:(NSString *)title {
    if(backgroundImageView == nil){
        backgroundImageView = [[UIImageView alloc] initWithFrame:CGRectMake((NNAppWidth - 60)/2, (NNAppHeight - 60) / 2 - 94, 60, 60)];
        [self.view addSubview:backgroundImageView];
    }
    backgroundImageView.image = [UIImage imageNamed:imageName];
    backgroundImageView.hidden = NO;
    if (describeLabel == nil) {
        describeLabel = [[UILabel alloc] initWithFrame:CGRectMake(30, backgroundImageView.bottom + 5, NNAppWidth - 60, 40)];
        describeLabel.backgroundColor = [UIColor clearColor];
        describeLabel.font = [UIFont systemFontOfSize:14.f];
        describeLabel.textAlignment = NSTextAlignmentCenter;
        describeLabel.textColor = NN_TEXT666666_COLOR;
        describeLabel.numberOfLines = 0;
        [self.view addSubview:describeLabel];
    }
    describeLabel.text = title;
    describeLabel.hidden = NO;
}

- (void)hideBackgroundViewImage{
    if (backgroundImageView != nil && describeLabel!= nil) {
        backgroundImageView.hidden = YES;
        describeLabel.hidden = YES;
    }
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
