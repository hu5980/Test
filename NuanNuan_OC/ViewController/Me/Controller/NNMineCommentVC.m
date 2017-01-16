//
//  NNMineCommentVC.m
//  NuanNuan_OC
//
//  Created by 忘、 on 16/10/24.
//  Copyright © 2016年 NuanNuan. All rights reserved.
//

#import "NNMineCommentVC.h"
#import "NNQuestionAndAnswerCell.h"
#import "NNSpitslotCell.h"
#import "NNMineCommentViewModel.h"
#import "NNQuestionAndAnswerCommentModel.h"
#import "NNSpitslotCommentModel.h"
#import "MWPhotoBrowser.h"
#import "NNMinePraisedVC.h"
#import "NNQuestionAndAnswerDetailVC.h"
#import "NNSpitslotDetailVC.h"

@interface NNMineCommentVC ()<UITableViewDelegate,UITableViewDataSource>{
    NSMutableArray *commentQuestionArrays;
    NSMutableArray *commentTreeHoelArrays;
    MJRefreshFooter *footer;
    NSMutableArray *phonoArrays;
    NSString *defaultType;
}
@property (strong, nonatomic) IBOutlet UIButton *defaultButton;

@property (weak, nonatomic) IBOutlet UITableView *commentTableView;
@end

@implementation NNMineCommentVC

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initData];
    [self createUI];
    // Do any additional setup after loading the view from its nib.
}

- (void)createUI {
    self.navTitle = @"我评论的";
    [self setNavigationBackButton:YES];
    
    _commentTableView.delegate = self;
    _commentTableView.dataSource = self;
    _commentTableView.backgroundColor = NN_BACKGROUND_COLOR;
    _commentTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    footer =  [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [self refreshData];
    }];
    _commentTableView.mj_footer = footer;
    [_commentTableView registerNib:[UINib nibWithNibName:@"NNQuestionAndAnswerCell" bundle:nil] forCellReuseIdentifier:@"NNQuestionAndAnswerCell"];
    [_commentTableView registerNib:[UINib nibWithNibName:@"NNSpitslotCell" bundle:nil] forCellReuseIdentifier:@"NNSpitslotCell"];

}

- (void)initData {
    commentQuestionArrays = [NSMutableArray array];
    commentTreeHoelArrays = [NSMutableArray array];
    defaultType = @"1";
    [[NNProgressHUD instance] showHudToView:self.view withMessage:@"加载中..."];
    [self refreshData];
}

- (void)refreshData {
    
   NNMineCommentViewModel *commentViewModel = [[NNMineCommentViewModel alloc] init];
    [commentViewModel setBlockWithReturnBlock:^(id returnValue) {
        [[NNProgressHUD instance] hideHud];
        if([defaultType isEqualToString:@"1"]){
            [commentQuestionArrays addObjectsFromArray:returnValue];
            [self showBackgroundImageViewArrays:commentQuestionArrays];
        }else{
            [commentTreeHoelArrays addObjectsFromArray:returnValue];
            [self showBackgroundImageViewArrays:commentTreeHoelArrays];
        }
        
        [_commentTableView reloadData];
    } WithErrorBlock:^(id errorCode) {
         [[NNProgressHUD instance] hideHud];
         [NNProgressHUD showHudAotoHideAddToView:self.view withMessage:errorCode];
    } WithFailureBlock:^(id failureBlock) {
         [[NNProgressHUD instance] hideHud];
    }];
    NSString *lastID;
    if ([defaultType isEqualToString:@"1"]) {
        NNQuestionAndAnswerCommentModel *model = [commentQuestionArrays lastObject];
        lastID = model.commentID;
    }else{
        NNSpitslotCommentModel *model = [commentTreeHoelArrays lastObject];
        lastID = model.commentID;
    }
    
    [commentViewModel getMineCommentWithToken:TEST_TOKEN andCommentType:defaultType andLastComentID:lastID andDown:@"0" andPageNum:@"10"];
}


- (void)showBackgroundImageViewArrays:(NSMutableArray *)array {
    if (array.count == 0) {
        if([defaultType isEqualToString:@"1"]){
            [self showBackgroundViewImageName:@"back_ic" andTitle:@"还没有评论的问题，快去问吧看看吧"];
        }else{
            [self showBackgroundViewImageName:@"back_ic" andTitle:@"还没有评论的树洞，快去树洞看看吧"];
        }
    }else{
        [self hideBackgroundViewImage];
    }
}



- (IBAction)selectTypeAction:(UIButton *)sender {
    
    _defaultButton.selected = NO;
    _defaultButton = sender;
    _defaultButton.selected = YES;

    if (sender.tag == 100) {
        defaultType = @"1";
    }else{
        defaultType = @"2";
    }
   // [[NNProgressHUD instance] showHudToView:self.view withMessage:@"加载中..."];
    [self refreshData];

}

#pragma --mark  UITableViewDatasource  UItableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if([defaultType isEqualToString:@"1"]){
        return commentQuestionArrays.count;
    }else{
        return commentTreeHoelArrays.count;
    }
   
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat height;
    if ([defaultType isEqualToString:@"1"]) {
        height = [tableView fd_heightForCellWithIdentifier:@"NNQuestionAndAnswerCell" cacheByIndexPath:indexPath configuration:^(id cell) {
            NNQuestionAndAnswerCommentModel *model = [commentQuestionArrays objectAtIndex:indexPath.section];
            NNQuestionAndAnswerCell *questionAndAnswerCell = cell;
            questionAndAnswerCell.commentLabel.text = model.comment;
        }];
        
    }else{
        height = [tableView fd_heightForCellWithIdentifier:@"NNSpitslotCell" cacheByIndexPath:indexPath configuration:^(id cell) {
            NNSpitslotCell *spitslotCell = cell;
            NNSpitslotCommentModel *model =  [commentTreeHoelArrays objectAtIndex:indexPath.section];
            spitslotCell.model = model.treeHoelModel;
          //  spitslotCell.commentLabel.text = model.comment;
        }];
    }
    return height + 5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, NNAppWidth, 13)];
    view.backgroundColor = [UIColor clearColor];
    return view;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([defaultType isEqualToString:@"1"]) {
        NNQuestionAndAnswerCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NNQuestionAndAnswerCell"];
        NNQuestionAndAnswerCommentModel *model = [commentQuestionArrays objectAtIndex:indexPath.section];
        cell.model = model.questionAndAnswerModelmodel;
        cell.commentLabel.text = model.comment;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.likeBlock = ^(UIButton *button) {
            
        };
        
        cell.commentBlock = ^ {
            
        };
        return cell;
    }else{
        NNSpitslotCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NNSpitslotCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        NNSpitslotCommentModel *model =  [commentTreeHoelArrays objectAtIndex:indexPath.section];
        __weak NNMineCommentVC *weakSelf = self;
        cell.selectImageBlock = ^(NSInteger selectIndex){
            phonoArrays = [NSMutableArray arrayWithCapacity:model.treeHoelModel.picArrays.count];
            for (int i  = 0 ; i < model.treeHoelModel.picArrays.count; i++) {
                [phonoArrays addObject:[MWPhoto photoWithURL:[NSURL URLWithString:[model.treeHoelModel.picArrays objectAtIndex:i]]]];
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
        cell.model = model.treeHoelModel;
        
        cell.block = ^(UIButton *button){
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
        
        return cell;
        
    }

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if ([defaultType isEqualToString:@"1"]) {
        NNQuestionAndAnswerDetailVC *detailVC = [[NNQuestionAndAnswerDetailVC alloc] initWithNibName:@"NNQuestionAndAnswerDetailVC" bundle:nil];
        NNQuestionAndAnswerCommentModel *model = [commentQuestionArrays objectAtIndex:indexPath.section];
     
        detailVC.signModel =  model.questionAndAnswerModelmodel;
        [self.navigationController pushViewController:detailVC animated:YES];
    }else{
        NNSpitslotDetailVC *spitslotDetailVC = [[NNSpitslotDetailVC alloc] initWithNibName:@"NNSpitslotDetailVC" bundle:nil];
        NNSpitslotCommentModel *model =  [commentTreeHoelArrays objectAtIndex:indexPath.section];
        spitslotDetailVC.model = model.treeHoelModel;
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
