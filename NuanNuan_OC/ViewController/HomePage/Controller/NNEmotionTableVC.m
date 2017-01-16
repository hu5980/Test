//
//  NNEmotionTableVC.m
//  NuanNuan_OC
//
//  Created by 忘、 on 17/1/11.
//  Copyright © 2017年 NuanNuan. All rights reserved.
//

#import "NNEmotionTableVC.h"
#import "MJRefresh.h"
#import "NNMoreSuccessCaseViewModel.h"

#import "NNProgressHUD.h"
#import "NNPariseViewModel.h"
#import "NNUnPariseViewModel.h"
#import "UITableView+FDTemplateLayoutCell.h"
#import "NNEmotionallItemCell.h"
#import "NNArticleDetailVC.h"
#import "NNLoginAndRegisterVC.h"

@interface NNEmotionTableVC ()<UITableViewDelegate,UITableViewDataSource>
{
    MJRefreshFooter *footer;
    MJRefreshHeader *header;
    NSMutableArray *caseArray;
}
@end

@implementation NNEmotionTableVC


- (void)viewDidLoad {
    [super viewDidLoad];
    
    footer =  [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [self refreshData];
    }];
    header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [caseArray removeAllObjects];
        [self refreshData];
    }];
    _emotionalTableView.mj_footer =  footer;
    _emotionalTableView.mj_header =  header;
    _emotionalTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _emotionalTableView.delegate = self;
    _emotionalTableView.dataSource = self;
    
    _emotionalTableView.backgroundColor = NN_BACKGROUND_COLOR;
    [_emotionalTableView registerNib:[UINib nibWithNibName:@"NNEmotionallItemCell" bundle:nil] forCellReuseIdentifier:@"NNEmotionallItemCell"];
}

- (void)initData {
    if (caseArray == nil) {
        caseArray = [NSMutableArray array];
    }else{
        [caseArray removeAllObjects];
    }
    [self refreshData];
}


- (void)refreshData {
    NNMoreSuccessCaseViewModel *caseModel = [[NNMoreSuccessCaseViewModel alloc] init];
    NNSuccessCaseModel *model = [caseArray lastObject];
    [caseModel setBlockWithReturnBlock:^(id returnValue) {
        [caseArray addObjectsFromArray:returnValue];
        [_emotionalTableView reloadData];
        [self endRefreshing];
    } WithErrorBlock:^(id errorCode) {
        [NNProgressHUD showHudAotoHideAddToView:self.view withMessage:errorCode];
         [self endRefreshing];
    } WithFailureBlock:^(id failureBlock) {
         [self endRefreshing];
    }];
    [caseModel getMoreSuccessCaseWithPageNum:10 andCaseType:_defaultType andCaseID:model.caseAdID andToken:TEST_TOKEN];
}

- (void) endRefreshing {
    if ([footer isRefreshing]) {
        [footer endRefreshing];
    }
    if ([header isRefreshing]) {
        [header endRefreshing];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setDefaultType:(NSInteger)defaultType {
    _defaultType = defaultType;
     [self initData];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return caseArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat height = [tableView fd_heightForCellWithIdentifier:@"NNEmotionallItemCell" cacheByIndexPath:indexPath configuration:^(id cell) {
        
    }];
    return height;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, NNAppWidth, 10)];
    view.backgroundColor = [UIColor clearColor];
    return view;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NNEmotionallItemCell *cell =  [tableView dequeueReusableCellWithIdentifier:@"NNEmotionallItemCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    __weak NNEmotionallItemCell *weakCell = cell;
    
    cell.block = ^(NNSuccessCaseModel *model) {
        
        if (TEST_TOKEN == nil) {
            NNLoginAndRegisterVC *loginVC = [[NNLoginAndRegisterVC alloc] initWithNibName:@"NNLoginAndRegisterVC" bundle:nil];
            loginVC.isPresent = YES;
            [self presentViewController:loginVC animated:YES completion:^{
            }];
            return ;
        }
        
        NNPariseViewModel  *viewModel = [[NNPariseViewModel alloc] init];
        [viewModel setBlockWithReturnBlock:^(id returnValue) {
            if([returnValue isEqualToString:@"success"]){
                weakCell.likeButton.selected = YES;
                weakCell.likeNumLabel.text = [NSString stringWithFormat:@"%ld",[weakCell.likeNumLabel.text integerValue] + 1];
                [NNProgressHUD showHudAotoHideAddToView:self.view withMessage:@"点赞成功"];
            }
        } WithErrorBlock:^(id errorCode) {
            [NNProgressHUD showHudAotoHideAddToView:self.view withMessage:errorCode];
        } WithFailureBlock:^(id failureBlock) {
            
        }];
        
        NNUnPariseViewModel *unViewModel = [[NNUnPariseViewModel alloc] init];
        [unViewModel setBlockWithReturnBlock:^(id returnValue) {
            if([returnValue isEqualToString:@"success"]){
                weakCell.likeButton.selected = NO;
                weakCell.likeNumLabel.text = [NSString stringWithFormat:@"%ld",[weakCell.likeNumLabel.text integerValue] - 1];
                [NNProgressHUD showHudAotoHideAddToView:self.view withMessage:@"取消点赞"];
            }
        } WithErrorBlock:^(id errorCode) {
            
        } WithFailureBlock:^(id failureBlock) {
            
        }];
        
        
        if (weakCell.likeButton.selected) {
            [unViewModel unParisdArticleWithToken:TEST_TOKEN andArticleType:@"3" andArticleID:[NSString stringWithFormat:@"%ld",model.caseAdID]];
        }else{
            [viewModel parisdArticleWithToken:TEST_TOKEN andArticleType:@"3" andArticleID:[NSString stringWithFormat:@"%ld",model.caseAdID]];
        }
    };
    
    cell.model = [caseArray objectAtIndex:indexPath.section];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NNSuccessCaseModel *model = [caseArray objectAtIndex:indexPath.section];
    _block(model);

}


@end
