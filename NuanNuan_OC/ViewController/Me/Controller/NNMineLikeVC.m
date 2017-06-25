//
//  NNMineLikeVC.m
//  NuanNuan_OC
//
//  Created by 忘、 on 16/10/24.
//  Copyright © 2016年 NuanNuan. All rights reserved.
//

#import "NNMineLikeVC.h"
#import "NNEmotionallItemCell.h"
#import "NNMinePraisedViewModel.h"
#import "NNSuccessCaseModel.h"
#import "NNArticleDetailVC.h"

@interface NNMineLikeVC ()<UITableViewDelegate,UITableViewDataSource> {
    NSMutableArray *praisedArray;
    MJRefreshFooter *footer;
}

@property (weak, nonatomic) IBOutlet UITableView *likeTableView;

@end

@implementation NNMineLikeVC

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
    [self initData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavigationBackButton:YES];
 
    [self createUI];
    // Do any additional setup after loading the view from its nib.
}

- (void)createUI {
    self.navTitle = @"我喜欢的";
    [self setNavigationBackButton:YES];
    
    _likeTableView.delegate = self;
    _likeTableView.dataSource = self;
    _likeTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _likeTableView.backgroundColor = NN_BACKGROUND_COLOR;
    [_likeTableView registerNib:[UINib nibWithNibName:@"NNEmotionallItemCell" bundle:nil] forCellReuseIdentifier:@"NNEmotionallItemCell"];
    
    footer =  [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [self refreshData];
    }];
    _likeTableView.mj_footer = footer;

}

- (void)initData {
    praisedArray = [NSMutableArray array];
    [[NNProgressHUD instance] showHudToView:self.view withMessage:@"加载中..."];
    [self refreshData];
}

- (void)refreshData {
    NNMinePraisedViewModel *viewModel = [[NNMinePraisedViewModel alloc] init];
    [viewModel setBlockWithReturnBlock:^(id returnValue) {
        [[NNProgressHUD instance] hideHud];
        [praisedArray addObjectsFromArray:returnValue];
        [footer endRefreshing];
        [_likeTableView reloadData];
        
        if(praisedArray.count == 0){
            [self showBackgroundViewImageName:@"Icon_default" andTitle:@"空空的哦，快去寻找你喜欢的文章吧"];
        }else{
            [self hideBackgroundViewImage];
        }
        
    } WithErrorBlock:^(id errorCode) {
        [[NNProgressHUD instance] hideHud];
        [NNProgressHUD showHudAotoHideAddToView:self.view withMessage:errorCode];
    } WithFailureBlock:^(id failureBlock) {
        [[NNProgressHUD instance] hideHud];
    }];
    
    NNSuccessCaseModel *model = [praisedArray lastObject];
    [viewModel getMinePraisedContentWithToken:TEST_TOKEN andPraisedType:@"3" andPraisedId:[NSString stringWithFormat:@"%ld",(long)model.caseAdID] andpageNum:@"10"];
}

#pragma --mark Delegate
#pragma --mark UItableViewdelegate UItableViewdatasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return praisedArray.count;
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
    return height   ;

}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, NNAppWidth, 10)];
    view.backgroundColor = [UIColor clearColor];
    return  view;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NNEmotionallItemCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NNEmotionallItemCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.model = [praisedArray objectAtIndex:indexPath.section];
    cell.block = ^(NNSuccessCaseModel *model){
        NSLog(@"我的喜欢里面什么都不做");
    };
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    NNSuccessCaseModel *model = [praisedArray objectAtIndex:indexPath.section];
    NNArticleDetailVC *articleVC = [[NNArticleDetailVC alloc] init];
    articleVC.artileTitle = model.caseTitle;
    articleVC.imageUrl = model.caseImageUrl;
    articleVC.articleID = model.caseAdID;
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
