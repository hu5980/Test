//
//  NNQuestionAndAnswerDetailVC.m
//  NuanNuan_OC
//
//  Created by 忘、 on 16/10/12.
//  Copyright © 2016年 NuanNuan. All rights reserved.
//

#import "NNQuestionAndAnswerDetailVC.h"
#import "NNNeterReplyCell.h"
#import "NNQuestionAndAnswerCell.h"
#import "NNAskingView.h"
#import "NNReplyView.h"
#import "NNQuestionAndAnswerViewModel.h"
#import "NNCommentViewModel.h"
#import "NNCommentModel.h"
#import "NNReplyViewModel.h"
#import "NNUnPariseViewModel.h"
#import "NNPariseViewModel.h"
@interface NNQuestionAndAnswerDetailVC ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,UITextViewDelegate> {
    NNAskingView *askingView;
    UIButton *backgroundButton;
    NNReplyView *replyView ;
    MJRefreshBackNormalFooter *footer;
    NSMutableArray *commentMutableArray;
}


@property (weak, nonatomic) IBOutlet UITableView *questionAndAnswerTableView;

@end

@implementation NNQuestionAndAnswerDetailVC


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self setNavigationBackButton:YES];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initUI];
    
    [self initData];
    // Do any additional setup after loading the view from its nib.
}

- (void)initUI {
    self.navTitle = @"问答详情";
    _questionAndAnswerTableView.delegate = self;
    _questionAndAnswerTableView.dataSource = self;
    _questionAndAnswerTableView.backgroundColor = NN_BACKGROUND_COLOR;
    [_questionAndAnswerTableView registerNib:[UINib nibWithNibName:@"NNNeterReplyCell" bundle:nil] forCellReuseIdentifier:@"NNNeterReplyCell"];
    [_questionAndAnswerTableView registerNib:[UINib nibWithNibName:@"NNQuestionAndAnswerCell" bundle:nil] forCellReuseIdentifier:@"NNQuestionAndAnswerCell"];
    
    footer =  [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [self reflashCommentData:NO];
    }];
    
    _questionAndAnswerTableView.mj_footer =  footer;
    
    replyView = LOAD_VIEW_FROM_BUNDLE(@"NNReplyView");
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
    
    __weak NNQuestionAndAnswerDetailVC *weakSelf = self;
    askingView = LOAD_VIEW_FROM_BUNDLE(@"NNAskingView");
    askingView.frame = CGRectMake(0, NNAppHeight, NNAppWidth, 130);
    askingView.typeLabel.text = @"想回复什么呢";
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

}

- (void)initData {
    commentMutableArray = [NSMutableArray array] ;
    [self reflashCommentData:NO];
}

- (void)reflashCommentData:(BOOL) isDowm {
    NNCommentViewModel *viewModel = [[NNCommentViewModel alloc] init];
    
    [viewModel setBlockWithReturnBlock:^(id returnValue) {
        if (isDowm) {
            NSMutableArray *array = [NSMutableArray arrayWithArray:returnValue];
            [array addObjectsFromArray:commentMutableArray];
            commentMutableArray = array;
        }else{
            [commentMutableArray addObjectsFromArray:returnValue];
        }
        [footer endRefreshing];
        [_questionAndAnswerTableView reloadData];
    } WithErrorBlock:^(id errorCode) {
        
    } WithFailureBlock:^(id failureBlock) {
        
    }];
    
    NNCommentModel *lastModel = [commentMutableArray lastObject];
    NNCommentModel *firstModel = [commentMutableArray firstObject];
    if (isDowm) {
         [viewModel getCommentWithToken:TEST_TOKEN andCommentType:@"1" andID:_signModel.questionId andLastID:firstModel.commentID andPageNum:@"10" andIsDownReflash:@"1" ];
    }else{
         [viewModel getCommentWithToken:TEST_TOKEN andCommentType:@"1" andID:_signModel.questionId andLastID:lastModel.commentID andPageNum:@"10" andIsDownReflash:@"0" ];
    }
   
    
}

- (void)replyComment {
    NNReplyViewModel *viewModel = [[NNReplyViewModel alloc] init];
    __weak NNQuestionAndAnswerDetailVC *weakSelf = self;
    [viewModel setBlockWithReturnBlock:^(id returnValue) {
        if ([returnValue isEqualToString:@"success"]) {
            [weakSelf registKeyboard];
            [weakSelf reflashCommentData:YES];
        }
    } WithErrorBlock:^(id errorCode) {
        
    } WithFailureBlock:^(id failureBlock) {
        
    }];
    
    [viewModel replyAnswerOrTreeHoelWithToken:TEST_TOKEN andReplyType:@"1" andTargetID:_signModel.questionId andConnent: askingView.askingTextView.text];
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
    
    replyView.replytextField = nil;
    askingView.askingTextView.text = nil;
}

#pragma --mark Delegate

- (void)textViewDidBeginEditing:(UITextView *)textView{
    askingView.placeHolderLabel.hidden = YES;
}

- (void)textViewDidChange:(UITextView *)textView {
    if (textView.text.length == 0) {
        askingView.placeHolderLabel.hidden = NO;
    }else{
        askingView.placeHolderLabel.hidden = YES;
    }
}


#pragma --mark UITableViewDelegate UItableViewDatasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }
    return commentMutableArray.count;
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 0;
    }
    return 30;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat height ;
    if (indexPath.section == 0) {
        height = [tableView fd_heightForCellWithIdentifier:@"NNQuestionAndAnswerCell" cacheByIndexPath:indexPath configuration:^(id cell) {
        }];
    }else{
         height = [tableView fd_heightForCellWithIdentifier:@"NNNeterReplyCell" cacheByIndexPath:indexPath configuration:^(id cell) {
        }];
    }
    return height;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return nil;
    }
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, NNAppWidth, 30)];
    view.backgroundColor = NN_BACKGROUND_COLOR;
    UILabel *neterReplyLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 10, 100, 10)];
    neterReplyLabel.font = [UIFont systemFontOfSize:12.f];
    neterReplyLabel.text = @"网友回复";
    neterReplyLabel.textColor = [UIColor colorFromHexString:@"#ff8833"];
    [view addSubview:neterReplyLabel];
    return view;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath .section == 0) {
        NNQuestionAndAnswerCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NNQuestionAndAnswerCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        __weak NNQuestionAndAnswerCell *weakCell = cell;
        cell.likeBlock = ^(UIButton *button){
            NNPariseViewModel  *viewModel = [[NNPariseViewModel alloc] init];
            [viewModel setBlockWithReturnBlock:^(id returnValue) {
                if([returnValue isEqualToString:@"success"]){
                    button.selected = YES;
                    weakCell.likeNumLabel.text = [NSString stringWithFormat:@"%ld",[cell.likeNumLabel.text integerValue] + 1];
                }
            } WithErrorBlock:^(id errorCode) {
                
            } WithFailureBlock:^(id failureBlock) {
                
            }];
            
            NNUnPariseViewModel *unViewModel = [[NNUnPariseViewModel alloc] init];
            [unViewModel setBlockWithReturnBlock:^(id returnValue) {
                if([returnValue isEqualToString:@"success"]){
                    button.selected = NO;
                    weakCell.likeNumLabel.text = [NSString stringWithFormat:@"%ld",[cell.likeNumLabel.text integerValue] - 1];
                }
            } WithErrorBlock:^(id errorCode) {
            } WithFailureBlock:^(id failureBlock) {
            }];
            
          
            
            if (button.selected) {
                [unViewModel unParisdArticleWithToken:TEST_TOKEN andArticleType:@"1" andArticleID:_signModel.questionId];
            }else{
                [viewModel parisdArticleWithToken:TEST_TOKEN andArticleType:@"1" andArticleID:_signModel.questionId];
            }
        };
        cell.commentBlock = ^(){
            [replyView.replytextField becomeFirstResponder];
        };
        cell.model = _signModel;
        return cell;
    }else{
        NNNeterReplyCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NNNeterReplyCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
         __weak NNNeterReplyCell*weakCell = cell;
        cell.model = [commentMutableArray objectAtIndex:indexPath.row];
        cell.likeCommentBlock = ^(UIButton * button ){
            NNPariseViewModel  *viewModel = [[NNPariseViewModel alloc] init];
            [viewModel setBlockWithReturnBlock:^(id returnValue) {
                if([returnValue isEqualToString:@"success"]){
                    button.selected = YES;
                    weakCell.likeNumLabel.text = [NSString stringWithFormat:@"%ld",[cell.likeNumLabel.text integerValue] + 1];
                }
            } WithErrorBlock:^(id errorCode) {
                NSLog(@"%@",errorCode);
            } WithFailureBlock:^(id failureBlock) {
                
            }];
            
            NNUnPariseViewModel *unViewModel = [[NNUnPariseViewModel alloc] init];
            [unViewModel setBlockWithReturnBlock:^(id returnValue) {
                if([returnValue isEqualToString:@"success"]){
                    button.selected = NO;
                    weakCell.likeNumLabel.text = [NSString stringWithFormat:@"%ld",[cell.likeNumLabel.text integerValue] - 1];
                }
            } WithErrorBlock:^(id errorCode) {
            } WithFailureBlock:^(id failureBlock) {
            }];
            
            
            
            if (button.selected) {
                [unViewModel unParisdArticleWithToken:TEST_TOKEN andArticleType:@"4" andArticleID:_signModel.questionId];
            }else{
                [viewModel parisdArticleWithToken:TEST_TOKEN andArticleType:@"4" andArticleID:_signModel.questionId];
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
