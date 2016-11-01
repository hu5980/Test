//
//  NNSuccessCaseVC.m
//  NuanNuan_OC
//
//  Created by 忘、 on 16/10/11.
//  Copyright © 2016年 NuanNuan. All rights reserved.
//

#import "NNEmotionCaseVC.h"
#import "NNEmotionallItemCell.h"
#import "NNMoreSuccessCaseViewModel.h"

#import "NNSuccessCaseModel.h"
#import "NNArticleDetailVC.h"

@interface NNEmotionCaseVC ()<UITableViewDataSource,UITableViewDelegate> {
    UIButton *defaultSelectButton;
    NSInteger selectType;
    
    NSMutableArray *caseArray;
    
    MJRefreshFooter *footer;
}

@end

@implementation NNEmotionCaseVC

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO];
    [self createEmotionalTypeUI];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavigationBackButton:YES];
   
    
    self.navTitle = _navigationTitle;
 
    self.view.backgroundColor = NN_BACKGROUND_COLOR;
    footer =  [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [self refreshData];
    }];
   
    _emotionalTableView.mj_footer =  footer;
    _emotionalTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _emotionalTableView.delegate = self;
    _emotionalTableView.dataSource = self;
    _emotionalTableView.backgroundColor = NN_BACKGROUND_COLOR;
    [_emotionalTableView registerNib:[UINib nibWithNibName:@"NNEmotionallItemCell" bundle:nil] forCellReuseIdentifier:@"NNEmotionallItemCell"];
    
    if(_caseTypeArray.count == 0){
        _scrollViewConstraint.constant = 0;
    }
    
    [self initData];
    
    // Do any additional setup after loading the view from its nib.
}

- (void)createEmotionalTypeUI {
    _emotionalTypeScrollView.contentSize = CGSizeMake((NNAppWidth/3)*_caseTypeArray.count, 32);
    for (UIView *view in _emotionalTypeScrollView.subviews) {
        [view removeFromSuperview];
    }
    for (int i = 0; i< _caseTypeArray.count; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(i*(NNAppWidth/3), 0, NNAppWidth/3, 32);
        [button setTitleColor:[UIColor colorFromHexString:@"333333"] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor colorFromHexString:@"FF8833"] forState:UIControlStateSelected];
         [button setTitleColor:[UIColor colorFromHexString:@"FF8833"] forState:UIControlStateHighlighted];
        button.tag = 100 + i;
        button.titleLabel.font = [UIFont systemFontOfSize:14];
        
        [button setTitle:[_caseTypeArray objectAtIndex:i] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(changeEmotionalType:) forControlEvents:UIControlEventTouchUpInside];
        [_emotionalTypeScrollView addSubview:button];
        if (i == 0) {
            defaultSelectButton = button;
            defaultSelectButton.selected = YES;
        }
    }
}


- (void)initData {
    selectType = _defaultType;
    caseArray = [NSMutableArray array];
    [self refreshData];
}


- (void)refreshData {
    NNMoreSuccessCaseViewModel *caseModel = [[NNMoreSuccessCaseViewModel alloc] init];
    NNSuccessCaseModel *model = [caseArray lastObject];
    [caseModel setBlockWithReturnBlock:^(id returnValue) {
        [caseArray addObjectsFromArray:returnValue];
        [_emotionalTableView reloadData];
        [footer endRefreshing];
    } WithErrorBlock:^(id errorCode) {
        NSLog(@"%@",errorCode);
    } WithFailureBlock:^(id failureBlock) {
        
    }];
    [caseModel getMoreSuccessCaseWithPageNum:10 andCaseType:selectType andCaseID:model.caseAdID];
}


#pragma --mark Action 

- (void)changeEmotionalType :(UIButton *)button {
    [caseArray removeAllObjects];
    defaultSelectButton.selected = NO;
    defaultSelectButton = button;
    defaultSelectButton.selected = YES;
    selectType = button.tag - 100 + _defaultType;
    
    [self refreshData];
}

- (void)likeArticle :(UIButton *)button {

}

#pragma --mark UITableViewDelegate UITableViewDatasource

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
    return height   ;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, NNAppWidth, 10)];
    view.backgroundColor = [UIColor clearColor];
    return view;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NNEmotionallItemCell *cell =  [tableView dequeueReusableCellWithIdentifier:@"NNEmotionallItemCell"];
    [cell.likeButton addTarget:self action:@selector(likeArticle:) forControlEvents:UIControlEventTouchUpInside];
    cell.model = [caseArray objectAtIndex:indexPath.section];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NNArticleDetailVC *articleVC = [[NNArticleDetailVC alloc] init];
    NNSuccessCaseModel *model = [caseArray objectAtIndex:indexPath.section];
    articleVC.articleID = model.caseAdID;
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
