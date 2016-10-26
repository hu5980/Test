//
//  NNHomePageVC.m
//  NuanNuan_OC
//
//  Created by 忘、 on 16/9/21.
//  Copyright © 2016年 NuanNuan. All rights reserved.
//

#import "NNHomePageVC.h"
#import "NNRingImageView.h"
#import "NNEmotionalItemCell.h"
#import "NNEmotionCaseVC.h"
#import "NNEmotionallCell.h"
#import "NNRingImageViewModel.h"
#import "NNRingImageModel.h"
#import "NNArticleDetailVC.h"
@interface NNHomePageVC () <UITableViewDelegate,UITableViewDataSource>
{
    NNRingImageView *headerView;
    NSArray *titleArray ;
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

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    NNRingImageViewModel *ringFocusViewModel = [[NNRingImageViewModel alloc] init];
    [ringFocusViewModel setBlockWithReturnBlock:^(id returnValue) {
         [headerView createRingImageviewWithRingArray:returnValue];
    } WithErrorBlock:^(id errorCode) {
        
    } WithFailureBlock:^(id failureBlock) {
        
    }];
    
    [ringFocusViewModel getRingFocueAreaContent];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    [headerView.ringScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@0);
        make.left.equalTo(@0);
        make.right.equalTo(@0);
        make.bottom.equalTo(@0);
        make.width.equalTo([NSNumber numberWithFloat:NNAppWidth]);
    }];
    CGSize size = [headerView systemLayoutSizeFittingSize:UILayoutFittingExpandedSize];
    headerView.size = size;
}

- (void)initUI {
    headerView = LOAD_VIEW_FROM_BUNDLE(@"NNRingImageView");
   
    __weak NNHomePageVC *weakSelf = self;
    headerView.ringBlock = ^(NNRingImageModel *model){
        NNLog(@"点击滚动图片  %@",model);
        NNArticleDetailVC *articleVC = [[NNArticleDetailVC alloc] init];
        articleVC.articleID = model.ringId;
        articleVC.hidesBottomBarWhenPushed = YES;
        [weakSelf.navigationController pushViewController:articleVC animated:YES];
    };
    _homePageTableView.tableHeaderView = headerView;
    
    _homePageTableView.backgroundColor = NN_BACKGROUND_COLOR;
    _homePageTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _homePageTableView.delegate = self;
    _homePageTableView.dataSource = self;
 
    [_homePageTableView registerNib:[UINib nibWithNibName:@"NNEmotionallCell" bundle:nil] forCellReuseIdentifier:@"emotionAllCell"];
    [_homePageTableView registerNib:[UINib nibWithNibName:@"NNEmotionalItemCell" bundle:nil] forCellReuseIdentifier:@"emotionalItemCell"];
}

- (void)initData {
    titleArray = @[@"成功故事・婚恋",@"成功故事・挽回",@"成功故事・提升"];
}

#pragma --mark UItableViewDataSource UItableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }
    return titleArray.count;
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
        NNEmotionalItemCell *emotionItemCell = (NNEmotionalItemCell *)cell;
        NNEmotionCaseVC *emotionCaseVC = [[NNEmotionCaseVC alloc] initWithNibName:@"NNEmotionCaseVC" bundle:nil];
        emotionCaseVC.hidesBottomBarWhenPushed = YES;
        
    
        emotionItemCell.eblock = ^(EmotionType type){
            switch (type) {
                case marriageAndFamily:
                    emotionCaseVC.navigationTitle = @"婚姻家庭";
                    emotionCaseVC.caseTypeArray = @[@"婆媳关系",@"夫妻心事",@"家庭琐事",@"婚外恋"];
                    break;
                case emotionalSave:
                    emotionCaseVC.navigationTitle = @"情感挽回";
                    emotionCaseVC.caseTypeArray = @[@"暗恋",@"失恋",@"复杂恋情"];
                    break;
                case selfImprovement:
                    emotionCaseVC.navigationTitle = @"自我提升";
                    emotionCaseVC.caseTypeArray = @[@"爱情探索",@"人际关系",@"人生信念"];
                    break;
                default:
                    break;
            }
            [self.navigationController pushViewController:emotionCaseVC animated:YES];
        };
    }else{
        NNEmotionallCell *emotionAllcell = (NNEmotionallCell *)[tableView dequeueReusableCellWithIdentifier:@"emotionAllCell"];
        emotionAllcell.successCasemoreBlock = ^(){
            NNEmotionCaseVC *emotionCaseVC = [[NNEmotionCaseVC alloc] initWithNibName:@"NNEmotionCaseVC" bundle:nil];
            emotionCaseVC.hidesBottomBarWhenPushed = YES;
            emotionCaseVC.navigationTitle = [titleArray objectAtIndex:indexPath.row];
            [self.navigationController pushViewController:emotionCaseVC animated:YES];
        };
        emotionAllcell.successCaseBlock = ^(){
            NNLog(@"成功故事");
        };
        emotionAllcell.emotionTitleLabel.text = [titleArray objectAtIndex:indexPath.row];
        cell = emotionAllcell;
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
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
