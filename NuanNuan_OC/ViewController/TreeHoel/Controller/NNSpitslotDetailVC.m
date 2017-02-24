//
//  NNSpitslotDetailVC.m
//  NuanNuan_OC
//
//  Created by hu5980 on 16/10/23.
//  Copyright © 2016年 NuanNuan. All rights reserved.
//

#import "NNSpitslotDetailVC.h"
#import "NNSpitslotCell.h"
#import "NNImageBroswerView.h"
#import "NNNeterReplyCell.h"
#import "NNReplyView.h"
#import "NNAskingView.h"
#import "MWPhotoBrowser.h"
#import "NNReplyViewModel.h"
#import "NNCommentViewModel.h"
#import "NNCommentModel.h"
#import "NNUnPariseViewModel.h"
#import "NNPariseViewModel.h"

@interface NNSpitslotDetailVC () <UITableViewDelegate,UITableViewDataSource,UITextViewDelegate,UITextFieldDelegate> {
    NNAskingView *askingView;
    UIButton *backgroundButton;
    NNReplyView *replyView ;
    
    MJRefreshBackNormalFooter *footer;
}

@property (strong, nonatomic) IBOutlet UITableView *spitslotTableView;
@end

@implementation NNSpitslotDetailVC

- (void)viewWillAppear:(BOOL)animated {
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
    self.navTitle = @"树洞详情";
    [self setNavigationBackButton:YES];
    _spitslotTableView.delegate = self;
    _spitslotTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _spitslotTableView.dataSource = self;
    _spitslotTableView.backgroundColor = NN_BACKGROUND_COLOR;
    [_spitslotTableView registerNib:[UINib nibWithNibName:@"NNNeterReplyCell" bundle:nil] forCellReuseIdentifier:@"NNNeterReplyCell"];
    [_spitslotTableView registerNib:[UINib nibWithNibName:@"NNSpitslotCell" bundle:nil] forCellReuseIdentifier:@"NNSpitslotCell"];
    
    replyView = LOAD_VIEW_FROM_BUNDLE(@"NNReplyView");
    replyView.hidden = YES;
    [self.view addSubview:replyView];
    replyView.replytextField.placeholder = @"我也说两句";
    [replyView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@0);
        make.width.equalTo(@(NNAppWidth));
        make.bottom.equalTo(self.view.mas_bottom).with.offset(0.0f);
        make.height.equalTo(@40);
    }];
    replyView.replytextField.delegate = self;
    
    backgroundButton = [UIButton buttonWithType:UIButtonTypeCustom];
    backgroundButton.frame = CGRectMake(0, 0, NNAppWidth, NNAppHeight);
    backgroundButton.backgroundColor = [UIColor blackColor];
    backgroundButton.alpha = 0.3;
    backgroundButton.hidden = YES;
    [backgroundButton addTarget:self action:@selector(registKeyboard) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backgroundButton];
    
    __weak NNSpitslotDetailVC *weakSelf = self;
    askingView = LOAD_VIEW_FROM_BUNDLE(@"NNAskingView");
    askingView.frame = CGRectMake(0, NNAppHeight, NNAppWidth, 130);
    askingView.typeLabel.text = @"说点什么吧";
    askingView.askingTextView.delegate = self;
    askingView.placeHolderLabel.text = @"请输入您想说的话";
    askingView.block =  ^(NSInteger tag){
        if(tag == 100){
            [weakSelf registKeyboard];
        }else{
            [weakSelf replyComment];
        }
    };
    [self.view addSubview:askingView];
    
    if (_isComment) {
        [replyView.replytextField becomeFirstResponder];
    }
    
    if (!_isFromNotice) {
        footer =  [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
            [self reflashCommentData:NO];
        }];
        replyView.hidden = NO;
        _spitslotTableView.mj_footer =  footer;
    }
}

- (void)initData {
    if (_commentMutableArray == nil) {
        _commentMutableArray = [NSMutableArray array] ;
    }
    if (!_isFromNotice) {
        [self reflashCommentData:NO];
    }
}

- (void)reflashCommentData:(BOOL) isDowm {
    NNCommentViewModel *viewModel = [[NNCommentViewModel alloc] init];
    [viewModel setBlockWithReturnBlock:^(id returnValue) {
        if (isDowm) {
            NSMutableArray *array = [NSMutableArray arrayWithArray:returnValue];
            [array addObjectsFromArray:_commentMutableArray];
            _commentMutableArray = array;
        }else{
            [_commentMutableArray addObjectsFromArray:returnValue];
        }
        
        [footer endRefreshing];
        [_spitslotTableView reloadData];
    } WithErrorBlock:^(id errorCode) {
        [NNProgressHUD showHudAotoHideAddToView:self.view withMessage:errorCode];
    } WithFailureBlock:^(id failureBlock) {
        
    }];
    
    NNCommentModel *lastModel = [_commentMutableArray lastObject];
    NNCommentModel *firstModel = [_commentMutableArray firstObject];
    if (isDowm) {
        [viewModel getCommentWithToken:TEST_TOKEN andCommentType:@"2" andID:_model.thID andLastID:firstModel.commentID andPageNum:@"10" andIsDownReflash:@"1" ];
    }else{
        [viewModel getCommentWithToken:TEST_TOKEN andCommentType:@"2" andID:_model.thID andLastID:lastModel.commentID andPageNum:@"10" andIsDownReflash:@"0" ];
    }
}

- (void)replyComment {
    NNReplyViewModel *viewModel = [[NNReplyViewModel alloc] init];
    __weak NNSpitslotDetailVC *weakSelf = self;
    [viewModel setBlockWithReturnBlock:^(id returnValue) {
        if ([returnValue isEqualToString:@"success"]) {
            [weakSelf registKeyboard];
            [weakSelf reflashCommentData:YES];
        }
    } WithErrorBlock:^(id errorCode) {
        
    } WithFailureBlock:^(id failureBlock) {
        
    }];
    
    [viewModel replyAnswerOrTreeHoelWithToken:TEST_TOKEN andReplyType:@"2" andTargetID:_model.thID andConnent: askingView.askingTextView.text];
}


#pragma --mark  Action

- (void)registKeyboard {
    [replyView.replytextField resignFirstResponder];
    [askingView.askingTextView resignFirstResponder];
}

- (void)keyboardWillShow:(NSNotification *)notification{
    
    backgroundButton.hidden = NO;
    
    //键盘高度
    CGRect keyBoardFrame = [[[notification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    CGFloat animationDuration =  [[[notification userInfo] objectForKey:UIKeyboardAnimationDurationUserInfoKey] floatValue];
    
    [UIView animateWithDuration:animationDuration animations:^{
        askingView.frame = CGRectMake(0, keyBoardFrame.origin.y - 130 - 64, NNAppWidth, 130);
    }];
    
    [askingView.askingTextView becomeFirstResponder];
    [replyView.replytextField resignFirstResponder];
    
}

- (void)keyboardWillHide:(NSNotification *)notification{
    backgroundButton.hidden = YES;
    CGFloat animationDuration =  [[[notification userInfo] objectForKey:UIKeyboardAnimationDurationUserInfoKey] floatValue];
    [UIView animateWithDuration:animationDuration animations:^{
        askingView.frame = CGRectMake(0, NNAppHeight, NNAppWidth, 130);
    }];
    askingView.askingTextView.text = nil;
    replyView.replytextField.text = nil;
}

#pragma --mark Delegate

- (void)textViewDidBeginEditing:(UITextView *)textView{
    askingView.placeHolderLabel.hidden = YES;
}

- (void)textViewDidChange:(UITextView *)textView{
    if (textView.text.length == 0) {
        askingView.placeHolderLabel.hidden = NO;
    }else{
        askingView.placeHolderLabel.hidden = YES;
    }
}
#pragma --mark UITableViewDelagate UItableViewDarasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }else{
        return _commentMutableArray.count;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat height;
    if (indexPath.section == 0) {
        height = [tableView fd_heightForCellWithIdentifier:@"NNSpitslotCell" cacheByIndexPath:indexPath configuration:^(id cell) {
            NNSpitslotCell *spitslotCell = cell;
            spitslotCell.model = _model;
        }];
        
    }else{
        height = [tableView fd_heightForCellWithIdentifier:@"NNNeterReplyCell" cacheByIndexPath:indexPath configuration:^(id cell) {
            NNNeterReplyCell *replyCell = cell;
            replyCell.model = [_commentMutableArray objectAtIndex:indexPath.row];
        }];
    }
    return height ;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 10;
    }else{
        return 30;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, NNAppWidth, 10)];
        view.backgroundColor = [UIColor clearColor];
        return view;
    }else{
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, NNAppWidth, 30)];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, 100, 30)];
        [view addSubview:label];
        label.text = @"网友评论";
        label.font = [UIFont systemFontOfSize:14.f];
        label.textColor = [UIColor colorFromHexString:@"#ff8833"];
        view.backgroundColor = NN_BACKGROUND_COLOR;
        return view;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        NNSpitslotCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NNSpitslotCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        __weak NNSpitslotDetailVC *weakSelf = self;
        __weak NNSpitslotCell *weakCell = cell;
        cell.selectImageBlock = ^(NSInteger selectIndex){
            
            NSMutableArray *phonoArrays = [NSMutableArray arrayWithCapacity:_model.picArrays.count];
            
            for (int i  = 0 ; i < _model.picArrays.count; i++) {
                [phonoArrays addObject:[MWPhoto photoWithURL:[NSURL URLWithString:[_model.picArrays objectAtIndex:i]]]];
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
        
        
        cell.block = ^(UIButton *button){
            switch (button.tag) {
                case 100:
                    NNLog(@"评论");
                    [replyView.replytextField becomeFirstResponder];
                    break;
                case 101:
                {
                    NNPariseViewModel  *viewModel = [[NNPariseViewModel alloc] init];
                    [viewModel setBlockWithReturnBlock:^(id returnValue) {
                        if([returnValue isEqualToString:@"success"]){
                            button.selected = YES;
                            weakCell.bePraisedLabel.text = [NSString stringWithFormat:@"%ld",[weakCell.bePraisedLabel.text integerValue] + 1];
                            [NNProgressHUD showHudAotoHideAddToView:self.view withMessage:@"点赞成功"];
                        }
                    } WithErrorBlock:^(id errorCode) {
                        [NNProgressHUD showHudAotoHideAddToView:self.view withMessage:errorCode];
                    } WithFailureBlock:^(id failureBlock) {
                        
                    }];
                    
                    NNUnPariseViewModel *unViewModel = [[NNUnPariseViewModel alloc] init];
                    [unViewModel setBlockWithReturnBlock:^(id returnValue) {
                        if([returnValue isEqualToString:@"success"]){
                            button.selected = NO;
                            weakCell.bePraisedLabel.text = [NSString stringWithFormat:@"%ld",[weakCell.bePraisedLabel.text integerValue] - 1];
                            [NNProgressHUD showHudAotoHideAddToView:self.view withMessage:@"取消点赞"];
                        }
                    } WithErrorBlock:^(id errorCode) {
                    } WithFailureBlock:^(id failureBlock) {
                    }];
                    if (button.selected) {
                        [unViewModel unParisdArticleWithToken:TEST_TOKEN andArticleType:@"2" andArticleID:_model.thID];
                    }else{
                        [viewModel parisdArticleWithToken:TEST_TOKEN andArticleType:@"2" andArticleID:_model.thID];
                    }
                    
                    
                }
                    break;
                default:
                    break;
            }
        };
        
        cell.model = _model;
        return cell;
    }else{
        NNNeterReplyCell *cell  = [tableView dequeueReusableCellWithIdentifier:@"NNNeterReplyCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        NNCommentModel *commentModel = [_commentMutableArray objectAtIndex:indexPath.row];
        cell.model = commentModel;
        __weak NNNeterReplyCell*weakCell = cell;
        cell.likeCommentBlock = ^(UIButton * button ){
            NNPariseViewModel  *viewModel = [[NNPariseViewModel alloc] init];
            [viewModel setBlockWithReturnBlock:^(id returnValue) {
                if([returnValue isEqualToString:@"success"]){
                    button.selected = YES;
                    weakCell.likeNumLabel.text = [NSString stringWithFormat:@"%ld",[cell.likeNumLabel.text integerValue] + 1];
                    [NNProgressHUD showHudAotoHideAddToView:self.view withMessage:@"点赞成功"];
                }
            } WithErrorBlock:^(id errorCode) {
                [NNProgressHUD showHudAotoHideAddToView:self.view withMessage:errorCode];
            } WithFailureBlock:^(id failureBlock) {
                
            }];
            
            NNUnPariseViewModel *unViewModel = [[NNUnPariseViewModel alloc] init];
            [unViewModel setBlockWithReturnBlock:^(id returnValue) {
                if([returnValue isEqualToString:@"success"]){
                    button.selected = NO;
                    weakCell.likeNumLabel.text = [NSString stringWithFormat:@"%ld",[cell.likeNumLabel.text integerValue] - 1];
                    [NNProgressHUD showHudAotoHideAddToView:self.view withMessage:@"取消点赞"];
                }
            } WithErrorBlock:^(id errorCode) {
            } WithFailureBlock:^(id failureBlock) {
            }];
            if (button.selected) {
                [unViewModel unParisdArticleWithToken:TEST_TOKEN andArticleType:@"4" andArticleID:commentModel.commentID];
            }else{
                [viewModel parisdArticleWithToken:TEST_TOKEN andArticleType:@"4" andArticleID:commentModel.commentID];
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
