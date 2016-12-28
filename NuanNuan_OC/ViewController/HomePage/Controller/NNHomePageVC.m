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
#import "NNHomepageSuccessCaseViewModel.h"
#import "NNHomepageSuccessCaseModel.h"
#import "AppDelegate.h"
#import "NNNoticeServer.h"

@interface NNHomePageVC () <UITableViewDelegate,UITableViewDataSource>
{
    NNRingImageView *headerView;
    NSArray *titleArray ;
    NNHomepageSuccessCaseModel *successCasemodel;
}

@property (weak, nonatomic) IBOutlet UITableView *homePageTableView;
@end

@implementation NNHomePageVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initUI];
    [self initData];
    
    AppDelegate * app = (AppDelegate *)[UIApplication sharedApplication].delegate;
    //pushName 是我给后天约定的通知必传值，所以我可以根据他是否为空来判断是否有通知
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] < 10.0) {
        NSString *  pushName = [[app.remoteNotification objectForKey:@"aps"] objectForKey:@"alert"];
        if (pushName !=nil) {
            NSString *noticeType = [NSString stringWithFormat:@"%@",[app.remoteNotification objectForKey:@"n_type"]];
            NSDictionary *dicInfo = [app.remoteNotification objectForKey:@"n_data"];
            [NNNoticeServer dealWithDictionary:dicInfo andNoticeType:noticeType andisPresent:YES andViewController:self];
        }
    }
    
    
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
        articleVC.defaultType = 3;
        articleVC.articleID = model.ringId;
        articleVC.artileTitle = model.title;
        articleVC.imageUrl = model.imageUrl;
        articleVC.hidesBottomBarWhenPushed = YES;
        articleVC.isShowAppointment = [model.isShowAppointment isEqualToString:@"1"] ? YES : NO ;
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
    NNHomepageSuccessCaseViewModel *successCaseViewModel = [[NNHomepageSuccessCaseViewModel alloc] init];
    [successCaseViewModel setBlockWithReturnBlock:^(id returnValue) {
        successCasemodel = returnValue;
        [_homePageTableView reloadData];
    } WithErrorBlock:^(id errorCode) {
        
    } WithFailureBlock:^(id failureBlock) {
        
    }];
    
    [successCaseViewModel getHomepageSuccessCase];
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
                    emotionCaseVC.defaultType = 1;
                    emotionCaseVC.caseTypeArray = @[@"婆媳关系",@"夫妻心事",@"家庭琐事",@"婚外恋"];
                    break;
                case emotionalSave:
                    emotionCaseVC.navigationTitle = @"情感挽回";
                    emotionCaseVC.defaultType = 5;
                    emotionCaseVC.caseTypeArray = @[@"暗恋",@"失恋",@"复杂恋情"];
                    break;
                case selfImprovement:
                    emotionCaseVC.navigationTitle = @"自我提升";
                     emotionCaseVC.defaultType = 8;
                    emotionCaseVC.caseTypeArray = @[@"爱情探索",@"人际关系",@"人生信念"];
                    break;
                default:
                    break;
            }
            [self.navigationController pushViewController:emotionCaseVC animated:YES];
        };
    }else{
        NNEmotionallCell *emotionAllcell = (NNEmotionallCell *)[tableView dequeueReusableCellWithIdentifier:@"emotionAllCell"];
        emotionAllcell.successCasemoreBlock = ^(NSInteger type){
            NNEmotionCaseVC *emotionCaseVC = [[NNEmotionCaseVC alloc] initWithNibName:@"NNEmotionCaseVC" bundle:nil];
            emotionCaseVC.hidesBottomBarWhenPushed = YES;
            emotionCaseVC.defaultType = type;
            emotionCaseVC.navigationTitle = [titleArray objectAtIndex:indexPath.row];
            [self.navigationController pushViewController:emotionCaseVC animated:YES];
        };
        __weak NNHomePageVC *weakSelf = self;
        emotionAllcell.successCaseBlock = ^(NNSuccessCaseModel *model){
            NNLog(@"成功故事");
            
            NNArticleDetailVC *articleVC = [[NNArticleDetailVC alloc] init];
            articleVC.articleID = model.caseAdID;
            articleVC.defaultType = 3;
            articleVC.artileTitle = model.caseTitle;
            articleVC.imageUrl = model.caseImageUrl;
            articleVC.hidesBottomBarWhenPushed = YES;
            [weakSelf.navigationController pushViewController:articleVC animated:YES];

        };
        emotionAllcell.emotionTitleLabel.text = [titleArray objectAtIndex:indexPath.row];
        
        switch (indexPath.row) {
            case 0:
                emotionAllcell.successCaseModelArray = successCasemodel.loveStoryArray ;
                emotionAllcell.type = 11;
                break;
            case 1:
                 emotionAllcell.successCaseModelArray = successCasemodel.redeemStoryArray ;
                emotionAllcell.type = 12;
                break;
            case 2:
                 emotionAllcell.successCaseModelArray = successCasemodel.improvementArray ;
                emotionAllcell.type = 13;
                break;
                
            default:
                break;
        }
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
