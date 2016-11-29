//
//  NNServerVC.m
//  NuanNuan_OC
//
//  Created by 忘、 on 16/9/21.
//  Copyright © 2016年 NuanNuan. All rights reserved.
//

#import "NNServerVC.h"
#import "NNCustomNavigationView.h"
#import "NNServerListCell.h"
#import "NNMoreSuccessCaseViewModel.h"
#import "NNSuccessCaseModel.h"
#import "NNArticleDetailVC.h"

@interface NNServerVC () <UITableViewDelegate,UITableViewDataSource> {
    UIButton *defaultSelectButton;
    MJRefreshFooter *footer;
    NSInteger defaultType;
    NSMutableArray *serverArray;
}
@property (weak, nonatomic) IBOutlet UITableView *serverListTableView;

@end

@implementation NNServerVC

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initData];
    [self initUI];
    // Do any additional setup after loading the view.
}

- (void) initUI {
    NNCustomNavigationView *view = LOAD_VIEW_FROM_BUNDLE(@"NNCustomNavigationView");
    view.backgroundColor = [UIColor clearColor];
    defaultSelectButton = view.index1Button;
    [view.index1Button setTitle:@"私人定制" forState:UIControlStateNormal];
    [view.index2Button setTitle:@"服务介绍" forState:UIControlStateNormal];
    
    view.selectBlock = ^(UIButton *button) {
        if (defaultSelectButton.tag != button.tag ) {
            defaultSelectButton.selected = NO;
            defaultSelectButton = button;
            defaultSelectButton.selected = YES;
            if (button.tag == 200) {
                defaultType = 14;
            }else{
                defaultType = 15;
            }
            [serverArray removeAllObjects];
            [self refreshData];
        }
        [_serverListTableView reloadData];
    };
    self.navigationItem.titleView = view;
    footer =  [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [self refreshData];
    }];
    _serverListTableView.mj_footer = footer;
    _serverListTableView.dataSource = self;
    _serverListTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _serverListTableView.delegate = self;
    _serverListTableView.backgroundColor = NN_BACKGROUND_COLOR;
    [_serverListTableView registerNib:[UINib nibWithNibName:@"NNServerListCell" bundle:nil] forCellReuseIdentifier:@"NNServerListCell"];
}

- (void)initData {
    defaultType = 14;
    serverArray = [NSMutableArray array];
    [self refreshData];
}

- (void)refreshData {
    NNMoreSuccessCaseViewModel *viewModel = [[NNMoreSuccessCaseViewModel alloc] init];
    [viewModel setBlockWithReturnBlock:^(id returnValue) {
        [serverArray addObjectsFromArray:returnValue];
        [_serverListTableView reloadData];
        [footer endRefreshing];
    } WithErrorBlock:^(id errorCode) {
        
    } WithFailureBlock:^(id failureBlock) {
        
    }];
    NNSuccessCaseModel *model = [serverArray lastObject];
    [viewModel getMoreSuccessCaseWithPageNum:10 andCaseType:defaultType andCaseID:model.caseAdID];
}

#pragma --mark UITableViewdelegate UItableViewdatasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return serverArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, NNAppWidth, 10)];
    view.backgroundColor = [UIColor clearColor];
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat height = [tableView fd_heightForCellWithIdentifier:@"NNServerListCell" cacheByIndexPath:indexPath configuration:^(id cell) {
        
    }];
    return height;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NNServerListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NNServerListCell"];
    cell.caseMode = [serverArray objectAtIndex:indexPath.section];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (defaultSelectButton.tag == 200) {
        cell.apaleView.hidden = YES;
    }else{
        cell.apaleView.hidden = NO;
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NNArticleDetailVC *articleVC = [[NNArticleDetailVC alloc] init];
    NNSuccessCaseModel *model = [serverArray objectAtIndex:indexPath.section];
    articleVC.articleID = model.caseAdID;
    articleVC.artileTitle = model.caseTitle;
    articleVC.imageUrl = model.caseImageUrl;
    articleVC.defaultType = 3;
    articleVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:articleVC animated:YES];
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
