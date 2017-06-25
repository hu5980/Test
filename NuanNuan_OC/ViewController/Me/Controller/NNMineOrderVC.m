//
//  NNMineOrderVC.m
//  NuanNuan_OC
//
//  Created by 忘、 on 16/10/24.
//  Copyright © 2016年 NuanNuan. All rights reserved.
//

#import "NNMineOrderVC.h"
#import "NNOrderModel.h"
#import "NNOrderViewModel.h"
#import "NNOrderCell.h"
@interface NNMineOrderVC ()<UITableViewDelegate,UITableViewDataSource>
{
    NSMutableArray  <NNOrderModel *> *orderArray;
    MJRefreshFooter *footer;
}
@property (weak, nonatomic) IBOutlet UITableView *orderTableView;
@end

@implementation NNMineOrderVC

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initData];
    [self initUI];
    // Do any additional setup after loading the view from its nib.
}

- (void)initUI {
    self.navTitle = @"我的预约";
    [self setNavigationBackButton:YES];
    _orderTableView.delegate = self;
    _orderTableView.dataSource = self;
    _orderTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _orderTableView.backgroundColor = NN_BACKGROUND_COLOR;
    footer =  [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [self refreshData];
    }];
    _orderTableView.mj_footer = footer;
    [_orderTableView registerNib:[UINib nibWithNibName:@"NNOrderCell" bundle:nil] forCellReuseIdentifier:@"NNOrderCell"];
}

- (void)initData {
    orderArray = [NSMutableArray array];
    [[NNProgressHUD instance] showHudToView:self.view withMessage:@"加载中..."];
    [self refreshData];
}

- (void)refreshData {
    NNOrderViewModel *viewModel = [[NNOrderViewModel alloc] init];
    [viewModel setBlockWithReturnBlock:^(id returnValue) {
        [[NNProgressHUD instance] hideHud];
        [footer endRefreshing];
        [orderArray addObjectsFromArray:returnValue];
        if(orderArray.count == 0){
            [self showBackgroundViewImageName:@"Icon_default" andTitle:@"全国最棒的心理导师等你来约哦"];
        }else{
            [self hideBackgroundViewImage];
        }
        [_orderTableView reloadData];
    } WithErrorBlock:^(id errorCode) {
         [[NNProgressHUD instance] hideHud];
         [NNProgressHUD showHudAotoHideAddToView:self.view withMessage:errorCode];
    } WithFailureBlock:^(id failureBlock) {
         [[NNProgressHUD instance] hideHud];
    }];
    
    NNOrderModel *model = [orderArray lastObject];
    [viewModel getMineOrderInfoWithToken:TEST_TOKEN andOrderID:model.orderID andPageNum:@"10"];
}

#pragma --mark UItableViewDataSource UItableViewdelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return orderArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat height = [tableView fd_heightForCellWithIdentifier:@"NNOrderCell" cacheByIndexPath:indexPath configuration:^(id cell) {
        NNOrderCell *orderCell = cell;
        orderCell.model = [orderArray objectAtIndex:indexPath.section];
    }];
    
    return height;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, NNAppWidth, 10)];
    view.backgroundColor = [UIColor clearColor];
    return view;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NNOrderCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NNOrderCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.model = [orderArray objectAtIndex:indexPath.section];
    return cell;
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
