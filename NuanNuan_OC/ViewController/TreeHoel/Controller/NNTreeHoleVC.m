//
//  NNTreeHoleVC.m
//  NuanNuan_OC
//
//  Created by 忘、 on 16/9/21.
//  Copyright © 2016年 NuanNuan. All rights reserved.
//

#import "NNTreeHoleVC.h"
#import "NNCustomNavigationView.h"
#import "NNTreeHoelCell.h"
#import "NNQuestionAndAnswerDetailVC.h"
#import "NNPsychologicalTeacherVC.h"
#import "NNSpitslotCell.h"
#import "NNImageBroswerView.h"
#import "NNSpitslotDetailVC.h"
#import "NNEmotionTeacherModel.h"
#import "NNEmotionTeacherViewModel.h"
#import "NNTreeHoelViewModel.h"
#import "NNTreeHoelModel.h"
#import "MWPhotoBrowser.h"
#import "NNPariseViewModel.h"
#import "NNUnPariseViewModel.h"
#import "NNTreeHoelSendVC.h"
#import "NNLoginAndRegisterVC.h"
#import "NNNoticeViewModel.h"
#import "NNMineNoticeVC.h"

@interface NNTreeHoleVC ()<UITableViewDelegate,UITableViewDataSource> {
    UIButton *defaultSelectButton;
    NSMutableArray *teacherModelArrays;
    NSMutableArray *treeHoelModelArrays;
    MJRefreshFooter *footer;
    MJRefreshHeader *header;
    NSMutableArray *phonoArrays;
    UIButton *treeHoleButton;
    UIBarButtonItem *rightItem;

    UILabel *noticeLabel;
}
@property (weak, nonatomic) IBOutlet UITableView *treeHoelTableView;

@end

@implementation NNTreeHoleVC

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO];
    if (TEST_TOKEN == nil) {
        NNLoginAndRegisterVC *loginVC = [[NNLoginAndRegisterVC alloc] initWithNibName:@"NNLoginAndRegisterVC" bundle:nil];;
        loginVC.isPresent = YES;
        [self presentViewController:loginVC animated:YES completion:^{
            
        }];
        return ;
    }
    if (treeHoleButton.hidden == NO) {
        [treeHoelModelArrays removeAllObjects];
        [self reflashTreeHoelData];
    }
    [self initNoticeData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
   
    [self initUI];
    [self initData];
    // Do any additional setup after loading the view.
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
}

- (void)initUI {
    [self.navigationController setNavigationBarHidden:NO];
    
    UIButton *rightButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 24, 24)];
    [rightButton setBackgroundImage:[UIImage imageNamed:@"msg_ic"] forState:UIControlStateNormal];
    [rightButton addTarget:self action:@selector(entryNotice) forControlEvents:UIControlEventTouchUpInside];
    rightItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
    self.navigationItem.rightBarButtonItem = rightItem;
    
    noticeLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, -7.5, 15, 15)];
    noticeLabel.backgroundColor = [UIColor redColor];
    noticeLabel.font = [UIFont systemFontOfSize:12.f];
    noticeLabel.layer.masksToBounds = YES;
    noticeLabel.layer.cornerRadius = 7.5;
    noticeLabel.hidden = YES;
    noticeLabel.textAlignment = NSTextAlignmentCenter;
    noticeLabel.textColor = [UIColor whiteColor];
    [rightButton addSubview:noticeLabel];
    
    self.navigationItem.rightBarButtonItem.tintColor = NN_MAIN_COLOR;
    
    NNCustomNavigationView *view = LOAD_VIEW_FROM_BUNDLE(@"NNCustomNavigationView");
    
    view.backgroundColor = [UIColor clearColor];
    __weak NNTreeHoleVC *weakSelf = self;
    defaultSelectButton = view.index1Button;
    view.selectBlock = ^(UIButton *button) {
        if (defaultSelectButton.tag != button.tag ) {
            defaultSelectButton.selected = NO;
            defaultSelectButton = button;
            defaultSelectButton.selected = YES;
      
            if (button.tag == 200) {
               treeHoleButton.hidden = YES;
                [weakSelf reflashTeachData];
            }else{
               treeHoleButton.hidden = NO;
                [weakSelf reflashTreeHoelData];
            }
            [_treeHoelTableView reloadData];
        }
    };
    self.navigationItem.titleView = view;
    [self.navigationItem.titleView layoutIfNeeded];
    footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        if (defaultSelectButton.tag == 200) {
            [weakSelf reflashTeachData];
        }else{
            [weakSelf reflashTreeHoelData];
        }
    }];

    header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        if (defaultSelectButton.tag == 200) {
            [teacherModelArrays removeAllObjects];
            [weakSelf reflashTeachData];
        }else{
            [treeHoelModelArrays removeAllObjects];
            [weakSelf reflashTreeHoelData];
        }
    } ];
    
    _treeHoelTableView.mj_header = header;
    _treeHoelTableView.mj_footer = footer;
    _treeHoelTableView.backgroundColor = NN_BACKGROUND_COLOR;
    _treeHoelTableView.delegate = self;
    _treeHoelTableView.dataSource = self;
    _treeHoelTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_treeHoelTableView registerNib:[UINib nibWithNibName:@"NNTreeHoelCell" bundle:nil] forCellReuseIdentifier:@"NNTreeHoelCell"];
    [_treeHoelTableView registerNib:[UINib nibWithNibName:@"NNSpitslotCell" bundle:nil] forCellReuseIdentifier:@"NNSpitslotCell"];
    
    treeHoleButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [treeHoleButton setBackgroundImage:[UIImage imageNamed:@"210_01"] forState:UIControlStateNormal];
    treeHoleButton.frame = CGRectMake(NNAppWidth - 15 - 54, NNAppHeight - 49 - 15 - 54 - 64, 54, 54);
    [treeHoleButton addTarget:self action:@selector(sendTreeHoleAction:) forControlEvents:UIControlEventTouchUpInside];
    treeHoleButton.hidden = YES;
    [self.view addSubview:treeHoleButton];
}

- (void)initData {
    teacherModelArrays= [NSMutableArray array];
    treeHoelModelArrays =[NSMutableArray array];
    [self reflashTeachData];
  }


- (void)initNoticeData {
    NNNoticeViewModel *viewModel = [[NNNoticeViewModel alloc] init];
    [viewModel setBlockWithReturnBlock:^(id returnValue) {
       NSInteger unReadNotice =  [NNNoticeViewModel getUnreadNoticeWithUserID:USERID];
        NSArray *tabBarItems = self.navigationController.tabBarController.tabBar.items;
        UITabBarItem *treeHoelItem = [tabBarItems objectAtIndex:1];
        UITabBarItem *MeHoelItem = [tabBarItems objectAtIndex:3];
        if (unReadNotice > 0) {
          
            treeHoelItem.badgeValue = [NSString stringWithFormat:@"%ld",(long)unReadNotice];
            MeHoelItem.badgeValue = [NSString stringWithFormat:@"%ld",(long)unReadNotice];
            noticeLabel.text = [NSString stringWithFormat:@"%ld",(long)unReadNotice];
            noticeLabel.hidden = NO;
        }else{
            noticeLabel.hidden = YES;
            treeHoelItem.badgeValue = nil;
            MeHoelItem.badgeValue = nil;
        }
       
    } WithErrorBlock:^(id errorCode) {
        [NNProgressHUD showHudAotoHideAddToView:self.view withMessage:errorCode];
    } WithFailureBlock:^(id failureBlock) {
            
    }];

    [viewModel getNoticeWithToken:TEST_TOKEN andLastID:@"" andPageNum:@"10000"];
}

- (void)reflashTeachData {
    NNEmotionTeacherViewModel  *emotionTeacherViewModel =  [[NNEmotionTeacherViewModel alloc] init];
    [emotionTeacherViewModel setBlockWithReturnBlock:^(id returnValue) {
        [teacherModelArrays addObjectsFromArray:returnValue];
        [_treeHoelTableView reloadData];
        [self endRefreshing];
    } WithErrorBlock:^(id errorCode) {
        [NNProgressHUD showHudAotoHideAddToView:self.view withMessage:errorCode];
        [self endRefreshing];
    } WithFailureBlock:^(id failureBlock) {
        [self endRefreshing];
    }];
    NNEmotionTeacherModel *lastModel = [teacherModelArrays lastObject];
    [emotionTeacherViewModel getEmotionTeacherListContentWithLastTeacherID:lastModel.teacherID andUpdatePageNum:@"5"];

}

- (void)reflashTreeHoelData {
    NNTreeHoelViewModel *modelView = [[NNTreeHoelViewModel alloc] init];
    [modelView setBlockWithReturnBlock:^(id returnValue) {
        [treeHoelModelArrays addObjectsFromArray:returnValue];
        [_treeHoelTableView reloadData];
        [self endRefreshing];

    } WithErrorBlock:^(id errorCode) {
        [NNProgressHUD showHudAotoHideAddToView:self.view withMessage:errorCode];
        [self endRefreshing];
    } WithFailureBlock:^(id failureBlock) {
        [self endRefreshing];
    }];
    NNTreeHoelModel *model = [treeHoelModelArrays lastObject];
    [modelView getTreeHoelListContentWithToken:TEST_TOKEN andLastTreeHoelId:model.thID
                          andUpdatePageNum:@"5"];
}

- (void)sendTreeHoleAction:(UIButton *)button {
    NNTreeHoelSendVC *sendVC = [[NNTreeHoelSendVC alloc] init];
    sendVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:sendVC animated:YES];
}

- (void)entryNotice {
    NNMineNoticeVC *noticeVC = [[NNMineNoticeVC alloc] init];
    noticeVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:noticeVC animated:YES];
}


- (void) endRefreshing {
    if ([footer isRefreshing]) {
        [footer endRefreshing];
    }
    if ([header isRefreshing]) {
        [header endRefreshing];
    }
}


#pragma --mark  UItableViewDelegate UItableViewDatasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (defaultSelectButton.tag == 200) {
        return teacherModelArrays.count;
    }else{
        return treeHoelModelArrays.count;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (defaultSelectButton.tag == 200) {
        NNTreeHoelCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NNTreeHoelCell"];
        NNEmotionTeacherModel *model = [teacherModelArrays objectAtIndex:indexPath.section];
        
        cell.model = model;
        return cell;
    }else{
        NNSpitslotCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NNSpitslotCell"];
        NNTreeHoelModel *model = [treeHoelModelArrays objectAtIndex:indexPath.section];
        __weak NNSpitslotCell *weakCell = cell;
        __weak NNTreeHoleVC *weakSelf = self;
        cell.selectImageBlock = ^(NSInteger selectIndex){
            
            phonoArrays = [NSMutableArray arrayWithCapacity:model.picArrays.count];
            
            for (int i  = 0 ; i < model.picArrays.count; i++) {
                [phonoArrays addObject:[MWPhoto photoWithURL:[NSURL URLWithString:[model.picArrays objectAtIndex:i]]]];
            }
            
            MWPhotoBrowser *browser = [[MWPhotoBrowser alloc] initWithPhotos:phonoArrays];
            browser.displayActionButton = YES;
            browser.displayNavArrows = YES;
            browser.displaySelectionButtons = NO;
            browser.alwaysShowControls = NO;
            browser.zoomPhotosToFill = YES;
            browser.enableSwipeToDismiss = NO;
            [browser setCurrentPhotoIndex:selectIndex];
            [weakSelf.navigationController pushViewController:browser animated:YES];
        };
        cell.model = model;

        
        cell.block = ^(UIButton * button){
            switch (button.tag) {
                case 100:
                {
                    NNSpitslotDetailVC *spitslotDetailVC = [[NNSpitslotDetailVC alloc] initWithNibName:@"NNSpitslotDetailVC" bundle:nil];
                    spitslotDetailVC.hidesBottomBarWhenPushed = YES;
                    spitslotDetailVC.model = [treeHoelModelArrays objectAtIndex:indexPath.section];
                    spitslotDetailVC.isComment = YES;
                    [self.navigationController pushViewController:spitslotDetailVC animated:YES];
                }
                    break;
                case 101:
                {
                    NNPariseViewModel  *viewModel = [[NNPariseViewModel alloc] init];
                    [viewModel setBlockWithReturnBlock:^(id returnValue) {
                        if([returnValue isEqualToString:@"success"]){
                            button.selected = YES;
                            weakCell.bePraisedLabel.text = [NSString stringWithFormat:@"%ld",[cell.bePraisedLabel.text integerValue] + 1];
                        }
                    } WithErrorBlock:^(id errorCode) {
                        
                    } WithFailureBlock:^(id failureBlock) {
                        
                    }];
                    
                    NNUnPariseViewModel *unViewModel = [[NNUnPariseViewModel alloc] init];
                    [unViewModel setBlockWithReturnBlock:^(id returnValue) {
                        if([returnValue isEqualToString:@"success"]){
                            button.selected = NO;
                            weakCell.bePraisedLabel.text = [NSString stringWithFormat:@"%ld",[cell.bePraisedLabel.text integerValue] - 1];
                        }
                    } WithErrorBlock:^(id errorCode) {
                    } WithFailureBlock:^(id failureBlock) {
                    }];
                    
                   
                    
                    if (button.selected) {
                        [unViewModel unParisdArticleWithToken:TEST_TOKEN andArticleType:@"2" andArticleID:model.thID];
                    }else{
                        [viewModel parisdArticleWithToken:TEST_TOKEN andArticleType:@"2" andArticleID:model.thID];
                    }

                }
                    break;
                default:
                    break;
            }
        };

        return cell;
    }
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat height;
    if (defaultSelectButton.tag == 200) {
        height = [tableView fd_heightForCellWithIdentifier:@"NNTreeHoelCell" cacheByIndexPath:indexPath configuration:^(id cell) {
            NNTreeHoelCell *teacherCell = cell;
            NNEmotionTeacherModel *model = [teacherModelArrays objectAtIndex:indexPath.section];
            teacherCell.model = model;
        }];
    }else{
        height = [tableView fd_heightForCellWithIdentifier:@"NNSpitslotCell" cacheByIndexPath:indexPath configuration:^(id cell) {
            NNSpitslotCell *spitslotCell = cell;
            NSLog(@"section = %ld",indexPath.section);
             spitslotCell.model = [treeHoelModelArrays objectAtIndex:indexPath.section];
            spitslotCell.commentConstraint.constant = 0;
        }];
    }
    
    return height;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, NNAppWidth, 10)];
    view.backgroundColor = [UIColor clearColor];
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (defaultSelectButton.tag == 200) {
        NNPsychologicalTeacherVC *teacherVC = [[NNPsychologicalTeacherVC alloc] initWithNibName:@"NNPsychologicalTeacherVC" bundle:nil];
        teacherVC.model = [teacherModelArrays objectAtIndex:indexPath.section];
        teacherVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController: teacherVC animated:YES];
    }else{
        NNSpitslotDetailVC *spitslotDetailVC = [[NNSpitslotDetailVC alloc] initWithNibName:@"NNSpitslotDetailVC" bundle:nil];
        spitslotDetailVC.hidesBottomBarWhenPushed = YES;
        spitslotDetailVC.model = [treeHoelModelArrays objectAtIndex:indexPath.section];
        [self.navigationController pushViewController:spitslotDetailVC animated:YES];
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
