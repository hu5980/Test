//
//  NNHomePageVC.m
//  NuanNuan_OC
//
//  Created by 忘、 on 16/9/21.
//  Copyright © 2016年 NuanNuan. All rights reserved.
//

#import "NNHomePageVC.h"
#import "NNRingImageViewView.h"
#import "NNEmotionalItemCell.h"

@interface NNHomePageVC () <UITableViewDelegate,UITableViewDataSource>
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
    _homePageTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _homePageTableView.delegate = self;
    _homePageTableView.dataSource = self;
 
    [_homePageTableView registerNib:[UINib nibWithNibName:@"NNEmotionallCell" bundle:nil] forCellReuseIdentifier:@"emotionAllCell"];
    [_homePageTableView registerNib:[UINib nibWithNibName:@"NNEmotionalItemCell" bundle:nil] forCellReuseIdentifier:@"emotionalItemCell"];
}

- (void)initData {

}

#pragma --mark UItableViewDataSource UItableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 108;
    }else {
        return NNAppWidth *252 /375;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *  cell;
    if (indexPath.section == 0) {
        cell = [tableView dequeueReusableCellWithIdentifier:@"emotionalItemCell"];
    }else{
        cell = [tableView dequeueReusableCellWithIdentifier:@"emotionAllCell"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, NNAppWidth, 10)];
    view.backgroundColor = [UIColor clearColor];
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 10;
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
