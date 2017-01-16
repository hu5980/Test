//
//  NNMineAskVC.m
//  NuanNuan_OC
//
//  Created by 忘、 on 16/12/13.
//  Copyright © 2016年 NuanNuan. All rights reserved.
//

#import "NNMineAskVC.h"
#import "NNAskingListViewModel.h"
#import "NNQuestionAndAnswerCell.h"
#import "NNQuestionAndAnswerDetailVC.h"
#import "NNUnAnswerQuestionCell.h"

@interface NNMineAskVC ()<UITableViewDelegate,UITableViewDataSource> {
    UIButton *defaultButton;
    NSString *hadAnswer;
    NSMutableArray *askArray;
    NSMutableArray *unAskArray;
    MJRefreshFooter *footer;
}
@property (weak, nonatomic) IBOutlet UIButton *hadAnswerButton;

@property (weak, nonatomic) IBOutlet UITableView *askingTableView;
@end

@implementation NNMineAskVC

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initData];
    [self initUI];
    // Do any additional setup after loading the view from its nib.
}

- (void)initUI {
    self.navTitle = @"我的问吧";
    [self setNavigationBackButton:YES];
    defaultButton = _hadAnswerButton ;
    
    _askingTableView.delegate = self;
    _askingTableView.dataSource = self;
    _askingTableView.backgroundColor = NN_BACKGROUND_COLOR;
    _askingTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    footer =  [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [self refreshData];
    }];
    _askingTableView.mj_footer = footer;
    [_askingTableView registerNib:[UINib nibWithNibName:@"NNQuestionAndAnswerCell" bundle:nil] forCellReuseIdentifier:@"NNQuestionAndAnswerCell"];
    [_askingTableView registerNib:[UINib nibWithNibName:@"NNUnAnswerQuestionCell" bundle:nil] forCellReuseIdentifier:@"NNUnAnswerQuestionCell"];
}

- (void)initData {
    hadAnswer = @"1";
    askArray = [NSMutableArray array];
    unAskArray = [NSMutableArray array];
    [self refreshData];
}


- (void)refreshData {
    NNAskingListViewModel *viewModel = [[NNAskingListViewModel alloc] init];
    [viewModel setBlockWithReturnBlock:^(id returnValue) {
        if ([hadAnswer isEqualToString:@"1"]) {
            [askArray addObjectsFromArray:returnValue];
            [self showBackgroundImageViewArrays:askArray];
        }else{
            [unAskArray addObjectsFromArray:returnValue];
            [self showBackgroundImageViewArrays:unAskArray];
        }
        [_askingTableView reloadData];
    } WithErrorBlock:^(id errorCode) {
        [NNProgressHUD showHudAotoHideAddToView:self.view withMessage:errorCode];
    } WithFailureBlock:^(id failureBlock) {
        
    }];
    
    
    NNQuestionAndAnswerModel *model ;
    
    if ([hadAnswer isEqualToString:@"1"]) {
        model = [askArray lastObject];
    }else{
        model = [unAskArray lastObject];
    }
    
    NSString *lastID = model.questionId ;
    if (lastID == nil) {
        lastID = @"";
    }
    
    [viewModel getAnswerListWithToken:TEST_TOKEN andHasAnswer:hadAnswer andLastId:lastID andpageNum:@"10"];
}

- (IBAction)hadAnswerOrUnAnswerAction:(UIButton *)sender {
    if (defaultButton.tag != sender.tag) {
        defaultButton.selected = NO;
        defaultButton = sender;
        defaultButton.selected = YES;
        if (sender.tag == 100) {
            hadAnswer = @"1";
        }else{
            hadAnswer = @"0";
        }
        [self refreshData];
    }
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if ([hadAnswer isEqualToString:@"1"]) {
        return askArray.count;
    }else{
        return unAskArray.count;
    }
    
}


- (void)showBackgroundImageViewArrays:(NSMutableArray *)array {
    if (array.count == 0) {
        if([hadAnswer isEqualToString:@"1"]){
            [self showBackgroundViewImageName:@"back_ic" andTitle:@"还没有已回答的提问，暖暖的老师随时等你咨询哦"];
        }else{
            [self showBackgroundViewImageName:@"back_ic" andTitle:@"还没有未回答的提问，暖暖的老师随时等你咨询哦"];
        }
    }else{
        [self hideBackgroundViewImage];
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat height;
    if ([hadAnswer isEqualToString:@"1"]) {
        height = [tableView fd_heightForCellWithIdentifier:@"NNQuestionAndAnswerCell" cacheByIndexPath:indexPath configuration:^(id cell) {
            NNQuestionAndAnswerCell *questionAndAnswerCell =  cell;
            questionAndAnswerCell.commentConstraint.constant = 0;
            questionAndAnswerCell.model = [askArray objectAtIndex:indexPath.section];
        }];
        
    }else{
        height = [tableView fd_heightForCellWithIdentifier:@"NNUnAnswerQuestionCell" cacheByIndexPath:indexPath configuration:^(id cell) {
            NNUnAnswerQuestionCell *unAnswerQuestionCell =  cell;
            unAnswerQuestionCell.model = [unAskArray objectAtIndex:indexPath.section];
        }];
        
    }
    
    return height;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, NNAppWidth, 10)];
    view.backgroundColor = [UIColor clearColor];
    return view;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if ([hadAnswer isEqualToString:@"1"]) {
        NNQuestionAndAnswerCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NNQuestionAndAnswerCell"];
        cell.model = [askArray objectAtIndex:indexPath.section];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.likeBlock = ^(UIButton *button) {
            
        };
        
        cell.commentBlock = ^{
            
        };
        return cell;
    }else{
        NNUnAnswerQuestionCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NNUnAnswerQuestionCell"];
        cell.model = [unAskArray objectAtIndex:indexPath.section];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if ([hadAnswer isEqualToString:@"1"]) {
        NNQuestionAndAnswerDetailVC *detailVC = [[NNQuestionAndAnswerDetailVC alloc] initWithNibName:@"NNQuestionAndAnswerDetailVC" bundle:nil];
        detailVC.signModel = [askArray objectAtIndex:indexPath.section];
        [self.navigationController pushViewController:detailVC animated:YES];
    }else{
        
    }
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
