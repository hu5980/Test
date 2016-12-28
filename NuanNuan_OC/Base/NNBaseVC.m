//
//  NNBaseVC.m
//  NuanNuan_OC
//
//  Created by 忘、 on 16/9/21.
//  Copyright © 2016年 NuanNuan. All rights reserved.
//

#import "NNBaseVC.h"

@interface NNBaseVC ()
{
    UIBarButtonItem *leftItem;
    UIBarButtonItem *rightItem;
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
   
    // Do any additional setup after loading the view.
}

- (void)setNavigationBackButton:(BOOL ) showOrHidden; {
    if (leftItem == nil) {
        leftItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"101_03"] style:UIBarButtonItemStylePlain target:self action:@selector(popVC)];
        leftItem.tintColor = [UIColor colorFromHexString:@"#ff9933"];
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
        rightItem.tintColor = [UIColor colorFromHexString:@"#ff9933"];
    }

    self.navigationItem.rightBarButtonItem = rightItem;
}

- (void)rightItemAction:(UIBarButtonItem *) item {

}

- (void)keyboardWillShow:(NSNotification*)notification{
       
    
}

- (void)keyboardWillHide:(NSNotification*)notification{
    
   
    
}

- (void)setNavTitle:(NSString *)navTitle{
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    titleLabel.textColor = [UIColor colorFromHexString:@"#ff9933"];
    titleLabel.font = [UIFont systemFontOfSize:17.f];
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
