//
//  NNMeVC.m
//  NuanNuan_OC
//
//  Created by 忘、 on 16/9/21.
//  Copyright © 2016年 NuanNuan. All rights reserved.
//

#import "NNMeVC.h"
#import "NNMeTableHeadView.h"
#import "NNMineEmotionalMangmentCell.h"
#import "NNEmotionallCell.h"

@interface NNMeVC ()
@property (weak, nonatomic) IBOutlet UITableView *meTableView;

@end

@implementation NNMeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
    // Do any additional setup after loading the view.
}


- (void)initView {
    NNMeTableHeadView *headerView = [[NSBundle mainBundle] loadNibNamed:@"NNMeTableHeadView" owner:self options:nil][0];
    headerView.frame = CGRectMake(0, 0, NNAppWidth, NNAppWidth *164 / 375);
    [headerView.backgroundButton setBackgroundColor:[UIColor redColor]];
    _meTableView.tableHeaderView = headerView;
    _meTableView.backgroundColor = [UIColor yellowColor];
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
