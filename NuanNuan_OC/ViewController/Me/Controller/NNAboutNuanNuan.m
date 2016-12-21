//
//  NNAboutNuanNuan.m
//  NuanNuan_OC
//
//  Created by 忘、 on 16/12/12.
//  Copyright © 2016年 NuanNuan. All rights reserved.
//

#import "NNAboutNuanNuan.h"
#import "NNAboutHeadView.h"
#import "NNAboutCell.h"
#import "NNSetCell.h"
@interface NNAboutNuanNuan () <UITableViewDelegate,UITableViewDataSource> {
    NSArray *titleArrays ;
    NSArray *contentArrays;
}
@property (weak, nonatomic) IBOutlet UITableView *aboutTableView;

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
    
    _aboutTableView.tableHeaderView.frame = CGRectMake(0, 0, NNAppWidth, 200);
    UIView *headView = LOAD_VIEW_FROM_BUNDLE(@"NNAboutHeadView");
    _aboutTableView.backgroundColor = NN_BACKGROUND_COLOR;
    _aboutTableView.tableHeaderView = headView;
    
    _aboutTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [_aboutTableView registerNib:[UINib nibWithNibName:@"NNAboutCell" bundle:nil] forCellReuseIdentifier:@"NNAboutCell"];
    [_aboutTableView registerNib:[UINib nibWithNibName:@"NNSetCell" bundle:nil] forCellReuseIdentifier:@"NNSetCell"];
    _aboutTableView.delegate = self;
    _aboutTableView.dataSource = self;
    titleArrays = @[@"微信公众号",@"邮箱",@"电话"];
    contentArrays = @[@"Nuannuanqg",@"nuannuan@vip.126.com",@"0755-26917174"];
    
    // Do any additional setup after loading the view from its nib.
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        NNAboutCell *ablutCell = [tableView dequeueReusableCellWithIdentifier:@"NNAboutCell"];
        return ablutCell;
    }else{
        NNSetCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NNSetCell"];
        cell.setTltleLabel.text = [titleArrays objectAtIndex:indexPath.row];
        cell.contentLabel.text = [contentArrays objectAtIndex:indexPath.row];
        cell.arrowImageView.hidden = YES;
        cell.contentConstraint.constant = 15;
        return cell;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0){
        return 1;
    }else {
        return 3;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, NNAppWidth, 44)];
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return  100;
    }else {
        return 44;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return  44;
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
