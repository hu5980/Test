//
//  NNMinePraisedVC.m
//  NuanNuan_OC
//
//  Created by 忘、 on 16/10/24.
//  Copyright © 2016年 NuanNuan. All rights reserved.
//

#import "NNMinePraisedVC.h"
#import "NNQuestionAndAnswerCell.h"
#import "NNSpitslotCell.h"
#import "NNImageBroswerView.h"
#import "NNMinePraisedViewModel.h"
#import "NNQuestionAndAnswerModel.h"
#import "NNTreeHoelModel.h"
#import "MWPhotoBrowser.h"
#import "NNQuestionAndAnswerDetailVC.h"
#import "NNSpitslotDetailVC.h"

@interface NNMinePraisedVC ()<UITableViewDataSource,UITableViewDelegate>{

    MJRefreshFooter *footer;
    NSArray *imageArrays;
    NSString *defaultType;
    NSMutableArray *praisedArray;
    NSMutableArray *phonoArrays;
}
@property (weak, nonatomic) IBOutlet UIButton *defaultButton;

@property (weak, nonatomic) IBOutlet UITableView *praisedTableView;
@end

@implementation NNMinePraisedVC

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavigationBackButton:YES];
    [self initData];
    [self createUI];
    // Do any additional setup after loading the view from its nib.
}

- (void)createUI {
    self.navTitle = @"我的赞";
    _praisedTableView.delegate = self;
    _praisedTableView.dataSource = self;
    _praisedTableView.backgroundColor = NN_BACKGROUND_COLOR;
    footer =  [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [self refreshData];
    }];
    _praisedTableView.mj_footer = footer;
    [_praisedTableView registerNib:[UINib nibWithNibName:@"NNQuestionAndAnswerCell" bundle:nil] forCellReuseIdentifier:@"NNQuestionAndAnswerCell"];
    [_praisedTableView registerNib:[UINib nibWithNibName:@"NNSpitslotCell" bundle:nil] forCellReuseIdentifier:@"NNSpitslotCell"];
}

- (void)initData {
    imageArrays = @[@"1",@"2"];
    defaultType = @"1";
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
        [_praisedTableView reloadData];
    } WithErrorBlock:^(id errorCode) {
         [[NNProgressHUD instance] hideHud];
         [NNProgressHUD showHudAotoHideAddToView:self.view withMessage:errorCode];
    } WithFailureBlock:^(id failureBlock) {
         [[NNProgressHUD instance] hideHud];
    }];
   
    if ([defaultType isEqualToString:@"1"]) {
        NNQuestionAndAnswerModel *model = [praisedArray lastObject];
         [viewModel getMinePraisedContentWithToken:TEST_TOKEN andPraisedType:defaultType andPraisedId:model.questionId andpageNum:@"10"];
    }else{
        NNTreeHoelModel *model = [praisedArray lastObject];
        [viewModel getMinePraisedContentWithToken:TEST_TOKEN andPraisedType:defaultType andPraisedId:model.thID andpageNum:@"10"];
    }
    
   
}

#pragma --mark Action
- (IBAction)selectTypeAction:(UIButton *)sender {
    _defaultButton.selected = NO;
    _defaultButton = sender;
    _defaultButton.selected = YES;
    [praisedArray removeAllObjects];
    if (sender.tag == 100) {
        defaultType = @"1";
    }else{
        defaultType = @"2";
    }
    [[NNProgressHUD instance] showHudToView:self.view withMessage:@"加载中..."];
    [self refreshData];
    
    //[_praisedTableView reloadData];
}


#pragma --mark Delegate
#pragma --mark UITableViewDelegate UItableViewDatasource
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
    CGFloat height;
    if (_defaultButton.tag == 100) {
        height = [tableView fd_heightForCellWithIdentifier:@"NNQuestionAndAnswerCell" cacheByIndexPath:indexPath configuration:^(id cell) {
            NNQuestionAndAnswerCell *questionAndAnswerCell =  cell;
            questionAndAnswerCell.commentConstraint.constant = 0;
        }];
        
    }else{
        height = [tableView fd_heightForCellWithIdentifier:@"NNSpitslotCell" cacheByIndexPath:indexPath configuration:^(id cell) {
            NNSpitslotCell *spitslotCell = cell;
            spitslotCell.commentConstraint.constant = 0;
            spitslotCell.model = [praisedArray objectAtIndex:indexPath.section];
           
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
  
    if (_defaultButton.tag == 100) {
        NNQuestionAndAnswerCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NNQuestionAndAnswerCell"];
        cell.model = [praisedArray objectAtIndex:indexPath.section];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.likeBlock = ^(UIButton *button) {
        
        };
        
        cell.commentBlock = ^{
        
        };
        return cell;
    }else{
        NNSpitslotCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NNSpitslotCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        NNTreeHoelModel *model =  [praisedArray objectAtIndex:indexPath.section];
        __weak NNMinePraisedVC *weakSelf = self;
        cell.selectImageBlock = ^(NSInteger selectIndex){
            
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
        cell.model = model;
        
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
    if (_defaultButton.tag == 100) {
        NNQuestionAndAnswerDetailVC *detailVC = [[NNQuestionAndAnswerDetailVC alloc] initWithNibName:@"NNQuestionAndAnswerDetailVC" bundle:nil];
        detailVC.signModel = [praisedArray objectAtIndex:indexPath.section];
        [self.navigationController pushViewController:detailVC animated:YES];
    }else{
        NNSpitslotDetailVC *spitslotDetailVC = [[NNSpitslotDetailVC alloc] initWithNibName:@"NNSpitslotDetailVC" bundle:nil];
        spitslotDetailVC.model = [praisedArray objectAtIndex:indexPath.section];
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
