//
//  NNMineTreeHoelVC.m
//  NuanNuan_OC
//
//  Created by 忘、 on 17/1/16.
//  Copyright © 2017年 NuanNuan. All rights reserved.
//

#import "NNMineTreeHoelVC.h"
#import "NNMineTreeHoelViewModel.h"
#import "NNTreeHoelModel.h"
#import "NNSpitslotCell.h"
#import "MWPhotoBrowser.h"
#import "NNSpitslotDetailVC.h"

@interface NNMineTreeHoelVC ()<UITableViewDelegate,UITableViewDataSource> {
    NSMutableArray *treeHoelArrays;
    NSMutableArray *phonoArrays;
    MJRefreshFooter *footer;
}
@property (weak, nonatomic) IBOutlet UITableView *treehoelTableView;

@end

@implementation NNMineTreeHoelVC

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
    if (treeHoelArrays !=nil) {
        [treeHoelArrays removeAllObjects];
         [self refreshData];
    }
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initUI];
    [self initData];
    // Do any additional setup after loading the view from its nib.
}

- (void)initUI {
    self.navTitle = @"我的树洞";
    [self setNavigationBackButton:YES];
    _treehoelTableView.delegate = self;
    _treehoelTableView.dataSource = self;
    _treehoelTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _treehoelTableView.backgroundColor = NN_BACKGROUND_COLOR;
    [_treehoelTableView registerNib:[UINib nibWithNibName:@"NNSpitslotCell" bundle:nil] forCellReuseIdentifier:@"NNSpitslotCell"];
    footer =  [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [self refreshData];
    }];
    _treehoelTableView.mj_footer = footer;
}



- (void)initData {
    treeHoelArrays = [NSMutableArray array];
    [self refreshData];
}

- (void)refreshData {
    NNMineTreeHoelViewModel *viewModel = [[NNMineTreeHoelViewModel alloc] init];
    [viewModel setBlockWithReturnBlock:^(id returnValue) {
        [footer endRefreshing];
        [treeHoelArrays addObjectsFromArray:returnValue];
        [_treehoelTableView reloadData];
        if(treeHoelArrays.count == 0){
            [self showBackgroundViewImageName:@"back_ic" andTitle:@"还没有发表树洞哦，快去树洞发布吧"];
        }else{
            [self hideBackgroundViewImage];
        }
    } WithErrorBlock:^(id errorCode) {
        [footer endRefreshing];
        [NNProgressHUD showHudAotoHideAddToView:self.view withMessage:errorCode];
    } WithFailureBlock:^(id failureBlock) {
        [footer endRefreshing];
    }];
    
    NNTreeHoelModel *model = [treeHoelArrays lastObject];
    
    [viewModel getMineTreeHoelWithToken:TEST_TOKEN andlastID:model.thID andPageNum:@"10"];
    
}


- (void)deleteTreeHoel:(NSString *)treeHoelID androw:(NSInteger ) indexRow {
    NNMineTreeHoelViewModel *viewModel = [[NNMineTreeHoelViewModel alloc] init];
    [viewModel setBlockWithReturnBlock:^(id returnValue) {
        [treeHoelArrays removeObjectAtIndex:indexRow];
        [_treehoelTableView reloadData];
        [NNProgressHUD showHudAotoHideAddToView:self.view withMessage:@"删除成功"];
    } WithErrorBlock:^(id errorCode) {
        [NNProgressHUD showHudAotoHideAddToView:self.view withMessage:errorCode];
    } WithFailureBlock:^(id failureBlock) {
        
    }];
    [viewModel deleteTreeHoelWithToken:TEST_TOKEN andTreeHoelID:treeHoelID];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return treeHoelArrays.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat height = [tableView fd_heightForCellWithIdentifier:@"NNSpitslotCell" cacheByIndexPath:indexPath configuration:^(id cell) {
        NNTreeHoelModel *model = [treeHoelArrays objectAtIndex:indexPath.section];
        NNSpitslotCell *spitslotCell = cell;
        spitslotCell.model = model;
    }];
    return height   ;

}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, NNAppWidth, 10)];
    view.backgroundColor = [UIColor clearColor];
    return view;
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    return @"删除";
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
     NNTreeHoelModel *model =  [treeHoelArrays objectAtIndex:indexPath.section];
    [self deleteTreeHoel:model.thID androw:indexPath.section];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NNSpitslotCell *spitslotCell = [tableView dequeueReusableCellWithIdentifier:@"NNSpitslotCell"];
    spitslotCell.selectionStyle = UITableViewCellSelectionStyleNone;
    NNTreeHoelModel *model =  [treeHoelArrays objectAtIndex:indexPath.section];
    __weak NNMineTreeHoelVC *weakSelf = self;
    spitslotCell.selectImageBlock = ^(NSInteger selectIndex){
        
        phonoArrays = [NSMutableArray arrayWithCapacity:model.picArrays.count];
        
        for (int i  = 0 ; i < model.picArrays.count; i++) {
            [phonoArrays addObject:[MWPhoto photoWithURL:[NSURL URLWithString:[model.picArrays objectAtIndex:i]]]];
        }
        
        MWPhotoBrowser *browser = [[MWPhotoBrowser alloc] initWithPhotos:phonoArrays];
        browser.displayActionButton = NO;
        browser.displayNavArrows = YES;
        browser.displaySelectionButtons = NO;
        browser.alwaysShowControls = NO;
        browser.zoomPhotosToFill = YES;
        browser.enableSwipeToDismiss = NO;
        [browser setCurrentPhotoIndex:selectIndex];
        [weakSelf.navigationController pushViewController:browser animated:YES];
    };
    spitslotCell.model = model;
    
    spitslotCell.block = ^(UIButton *button){
        switch (button.tag) {
            case 100:
                NNLog(@"评论");
                break;
            case 101:
                NNLog(@"点赞");
                break;
            default:
                break;
        }
    };
    
    return spitslotCell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
        NNSpitslotDetailVC *spitslotDetailVC = [[NNSpitslotDetailVC alloc] initWithNibName:@"NNSpitslotDetailVC" bundle:nil];
        spitslotDetailVC.hidesBottomBarWhenPushed = YES;
        spitslotDetailVC.model = [treeHoelArrays objectAtIndex:indexPath.section];
        [self.navigationController pushViewController:spitslotDetailVC animated:YES];
    
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
