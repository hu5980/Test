//
//  NNHomePageVC.m
//  NuanNuan_OC
//
//  Created by 忘、 on 16/9/21.
//  Copyright © 2016年 NuanNuan. All rights reserved.
//

#import "NNHomePageVC.h"
#import "NNRingImageViewView.h"

@interface NNHomePageVC ()
{
    NNRingImageViewView *headerView;
}

@property (weak, nonatomic) IBOutlet UITableView *homePageTableView;
@end

@implementation NNHomePageVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initData];
    [self initUI];
    
    // Do any additional setup after loading the view.
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    headerView.frame = CGRectMake(0, 0, NNAppWidth, NNAppWidth * 164 / 375 );
}

- (void)initUI {
    headerView = LOAD_VIEW_FROM_BUNDLE(@"NNRingImageViewView");
    _homePageTableView.tableHeaderView = headerView;
    
    _homePageTableView.backgroundColor = NN_BACKGROUND_COLOR;
 
    
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
