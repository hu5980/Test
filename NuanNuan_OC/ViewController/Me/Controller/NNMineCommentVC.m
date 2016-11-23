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

@interface NNMineCommentVC ()<UITableViewDelegate,UITableViewDataSource>{
    NSMutableArray *commentArrays;
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
    self.navTitle = @"我的评论";
    [self setNavigationBackButton:YES];
    
    _commentTableView.delegate = self;
    _commentTableView.dataSource = self;
    _commentTableView.backgroundColor = NN_BACKGROUND_COLOR;
    footer =  [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [self refreshData];
    }];
    _commentTableView.mj_footer = footer;
    [_commentTableView registerNib:[UINib nibWithNibName:@"NNQuestionAndAnswerCell" bundle:nil] forCellReuseIdentifier:@"NNQuestionAndAnswerCell"];
    [_commentTableView registerNib:[UINib nibWithNibName:@"NNSpitslotCell" bundle:nil] forCellReuseIdentifier:@"NNSpitslotCell"];

}

- (void)initData {
    commentArrays = [NSMutableArray array];
    defaultType = @"1";
    
    [self refreshData];
}

- (void)refreshData {
    
   NNMineCommentViewModel *commentViewModel = [[NNMineCommentViewModel alloc] init];
    [commentViewModel setBlockWithReturnBlock:^(id returnValue) {
        
    } WithErrorBlock:^(id errorCode) {
        
    } WithFailureBlock:^(id failureBlock) {
        
    }];
    NSString *lastID;
    if ([defaultType isEqualToString:@"1"]) {
        NNQuestionAndAnswerCommentModel *model = [commentArrays lastObject];
        lastID = model.commentID;
    }else{
        NNSpitslotCommentModel *model = [commentArrays lastObject];
        lastID = model.commentID;
    }
    
    [commentViewModel getMineCommentWithToken:TEST_TOKEN andCommentType:defaultType andLastComentID:lastID andDown:@"0" andPageNum:@"10"];
}




- (IBAction)selectTypeAction:(UIButton *)sender {
    
    _defaultButton.selected = NO;
    _defaultButton = sender;
    _defaultButton.selected = YES;
    [commentArrays removeAllObjects];
    if (sender.tag == 100) {
        defaultType = @"1";
    }else{
        defaultType = @"2";
    }
    [self refreshData];

}

#pragma --mark  UITableViewDatasource  UItableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return commentArrays.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat height;
    if (_defaultButton.tag == 100) {
        height = [tableView fd_heightForCellWithIdentifier:@"NNQuestionAndAnswerCell" cacheByIndexPath:indexPath configuration:^(id cell) {
            
        }];
        
    }else{
        height = [tableView fd_heightForCellWithIdentifier:@"NNSpitslotCell" cacheByIndexPath:indexPath configuration:^(id cell) {
            NNSpitslotCell *spitslotCell = cell;
            spitslotCell.model = [commentArrays objectAtIndex:indexPath.section];
        }];
    }
    return height;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
     CGFloat height;
    if (_defaultButton.tag == 100) {
        
    }else{
        
    }
    
    
    return 50;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, NNAppWidth, 0)];
    
    if (_defaultButton.tag == 100) {
        
    }else{
        
    }
    
    
    
    return view;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (_defaultButton.tag == 100) {
        NNQuestionAndAnswerCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NNQuestionAndAnswerCell"];
        NNQuestionAndAnswerCommentModel *model = [commentArrays objectAtIndex:indexPath.section];
        cell.model = model.questionAndAnswerModelmodel;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.likeBlock = ^(UIButton *button) {
            
        };
        
        cell.commentBlock = ^ {
            
        };
        return cell;
    }else{
        NNSpitslotCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NNSpitslotCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        NNSpitslotCommentModel *model =  [commentArrays objectAtIndex:indexPath.section];
        
        __weak NNSpitslotCell *weakCell = cell;
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
