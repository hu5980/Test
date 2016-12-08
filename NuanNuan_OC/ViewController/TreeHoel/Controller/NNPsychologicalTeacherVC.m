//
//  NNPsychologicalTeacherVC.m
//  NuanNuan_OC
//
//  Created by 忘、 on 16/10/12.
//  Copyright © 2016年 NuanNuan. All rights reserved.
//

#import "NNPsychologicalTeacherVC.h"
#import "NNPsychologicalTeacherHeaderView.h"
#import "NNQuestionAndAnswerCell.h"
#import "NNQuestionAndAnswerDetailVC.h"
#import "NNReplyView.h"
#import "NNAskingView.h"
#import "NNAskingViewModel.h"
#import "NNProgressHUD.h"
#import "NNQuestionAndAnswerViewModel.h"
#import "NNPariseViewModel.h"
#import "NNUnPariseViewModel.h"
@interface NNPsychologicalTeacherVC ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,UITextViewDelegate> {
    NNPsychologicalTeacherHeaderView *headerView;
    UIButton *defaultSelectButton;
    NNAskingView *askingView;
    UIButton *backgroundButton;
    NNReplyView *replyView ;
    NSString  *defaultType;
    NSMutableArray *questionAndAnswerMutableArray;
    MJRefreshBackNormalFooter *footer;
}

@property (weak, nonatomic) IBOutlet UITableView *psychologicalTeacherTableView;

@end

@implementation NNPsychologicalTeacherVC

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    [headerView.backgroundImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo([NSNumber numberWithFloat:NNAppWidth]);
    }];
    CGSize size = [headerView systemLayoutSizeFittingSize:UILayoutFittingExpandedSize];
    NNLog(@"%f,%f",size.width,size.height);
    headerView.size = size;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initData];
    [self initUI];
    // Do any additional setup after loading the view from its nib.
}


- (void)initUI {
    
    headerView = LOAD_VIEW_FROM_BUNDLE(@"NNPsychologicalTeacherHeaderView");
    [headerView.backgroundImageView sd_setImageWithURL:[NSURL URLWithString:_model.backgroundImageUrl] placeholderImage:[UIImage imageNamed:@"detail_defalut"] options:SDWebImageAllowInvalidSSLCertificates];
    [headerView.headimageView sd_setImageWithURL:[NSURL URLWithString:_model.teacherHeadUrl] placeholderImage:[UIImage imageNamed:@"detail_defalut"] options:SDWebImageAllowInvalidSSLCertificates];
    headerView.nickNamelabel.text = _model.teacherNickName;
    headerView.studyTypeLabel.text = _model.teacherTypeName;
    headerView.teacherDescribeLabel.text = _model.teacherDescription;
    headerView.teacherIntroduceLabel.text = _model.teacherQualifications;
    _psychologicalTeacherTableView.tableHeaderView = headerView;
    _psychologicalTeacherTableView.backgroundColor = NN_BACKGROUND_COLOR;
    _psychologicalTeacherTableView.delegate = self;
    _psychologicalTeacherTableView.dataSource = self;
    _psychologicalTeacherTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    __weak NNPsychologicalTeacherHeaderView *weakHeaderView = headerView;
    
    __weak NSString *descriptionStr = _model.teacherDescription;
    
    headerView.showDetail = ^(){
        
        CGFloat height = [descriptionStr boundingRectWithSize:CGSizeMake(NNAppWidth - 30, CGFLOAT_MAX)
                                                 options:NSStringDrawingUsesLineFragmentOrigin
                                              attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:14.f]}
                                                 context:nil].size.height;
        
        weakHeaderView.describelLabelConstraint.constant = height;
        [weakHeaderView updateConstraints];
    };
    [_psychologicalTeacherTableView registerNib:[UINib nibWithNibName:@"NNQuestionAndAnswerCell" bundle:nil] forCellReuseIdentifier:@"NNQuestionAndAnswerCell"];
    footer =  [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [self reflashQuestionAndAnswerData];
    }];
    
    _psychologicalTeacherTableView.mj_footer =  footer;
  
    __weak NNPsychologicalTeacherVC *weakSelf = self;
    headerView.popblock = ^(){
        [weakSelf.navigationController popViewControllerAnimated:YES];
    };
    
    replyView = LOAD_VIEW_FROM_BUNDLE(@"NNReplyView");
    [self.view addSubview:replyView];
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

    askingView = LOAD_VIEW_FROM_BUNDLE(@"NNAskingView");
    askingView.frame = CGRectMake(0, NNAppHeight, NNAppWidth, 130);
    askingView.askingTextView.delegate = self;
    
    __weak NNAskingView *weakAskingView = askingView;
    __weak NNEmotionTeacherModel *weakModel = _model;
    askingView.block =  ^(NSInteger tag){
        
        if(tag == 100){
            [weakSelf registKeyboard];
        }else{
            NNAskingViewModel *askingViewModel = [[NNAskingViewModel alloc] init];
            [askingViewModel setBlockWithReturnBlock:^(id returnValue) {
                if ([returnValue  isEqualToString:@"success"]) {
                    [weakSelf registKeyboard];
                    [NNProgressHUD showHudAotoHideAddToView:weakSelf.view withMessage:@"提问成功，将在回复后显示"];
                }else{
                    [NNProgressHUD showHudAotoHideAddToView:weakSelf.view withMessage:@"提问失败"];
                }
            } WithErrorBlock:^(id errorCode) {
                
            } WithFailureBlock:^(id failureBlock) {
                
            }];
            [askingViewModel askingQuestionWithToken:TEST_TOKEN andTeacherID:weakModel.teacherID andQuestionType:@"1" andQuestionContent:weakAskingView.askingTextView.text];
        }
    };
    [self.view addSubview:askingView];
   
    
}

- (void)initData {
    defaultType = @"new";
    questionAndAnswerMutableArray = [NSMutableArray array];
    [self reflashQuestionAndAnswerData];
}

- (void)reflashQuestionAndAnswerData {
    NNQuestionAndAnswerViewModel *viewModel = [[NNQuestionAndAnswerViewModel alloc] init];
    viewModel.teacherModel = _model;
    
    [viewModel setBlockWithReturnBlock:^(id returnValue) {
        [questionAndAnswerMutableArray addObjectsFromArray:returnValue];
        [footer endRefreshing];
        [_psychologicalTeacherTableView reloadData];
    } WithErrorBlock:^(id errorCode) {
        
    } WithFailureBlock:^(id failureBlock) {
        
    }];
    
    NNQuestionAndAnswerModel *model = [questionAndAnswerMutableArray lastObject];
    NSString *lastID ;
    if ([defaultType isEqualToString:@"new"]) {
        lastID = model.questionId;
    }else{
        lastID = [NSString stringWithFormat:@"%ld",(long)model.questionCreateTime];
    }
    [viewModel getQuestionAndAnswerWithType:defaultType andToken:TEST_TOKEN andTeacherID:_model.teacherID andLastQuestionAndAnswerID:lastID andPageNum:@"10"];
}

#pragma --mark  Action
- (void)changeNewestAndhottestQuestionAction :(UIButton *)button {
    defaultSelectButton.selected = NO;
    defaultSelectButton = button;
    defaultSelectButton.selected = YES;
    [questionAndAnswerMutableArray removeAllObjects];
    if (button.tag == 200) {
        defaultType = @"new";
    }else{
        defaultType = @"hot";
    }
    
    [self reflashQuestionAndAnswerData];
}

- (void)registKeyboard {
    replyView.replytextField.text = nil;
    askingView.askingTextView.text = nil;
    [replyView.replytextField resignFirstResponder];
    [askingView.askingTextView resignFirstResponder];
}

- (void)keyboardWillShow:(NSNotification *)notification{
    
    backgroundButton.hidden = NO;

    //键盘高度
    CGRect keyBoardFrame = [[[notification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    CGFloat animationDuration =  [[[notification userInfo] objectForKey:UIKeyboardAnimationDurationUserInfoKey] floatValue];
    
    [UIView animateWithDuration:animationDuration animations:^{
        askingView.frame = CGRectMake(0, keyBoardFrame.origin.y - 130, NNAppWidth, 130);
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



#pragma --mark UItableViewDelegate   UItableViewDatasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return questionAndAnswerMutableArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 30;
    }else{
        return 10;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, NNAppWidth, 30)];
        view.backgroundColor = NN_BACKGROUND_COLOR;
        
        UILabel *questionLabel = [[UILabel alloc] init];
        [view addSubview:questionLabel];
        questionLabel.font = [UIFont systemFontOfSize:12];
        questionLabel.text = [NSString stringWithFormat:@"%@提问",_model.teacherQuestionNum];
        questionLabel.textColor = [UIColor colorFromHexString:@"#999999"];
        [questionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(@15);
            make.top.mas_equalTo(@10);
            make.bottom.mas_equalTo(@-10);
            make.width.mas_greaterThanOrEqualTo(@20);
        }];
        
        UIView *lineView = [[UIView alloc] init];
        [view addSubview:lineView];
        lineView.backgroundColor = [UIColor colorFromHexString:@"#999999"];
        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(questionLabel.mas_right).with.offset(5);
            make.top.mas_equalTo(@10);
            make.bottom.mas_equalTo(@-10);
            make.width.mas_equalTo(@0.5);
        }];
        
        UILabel *replyLabel = [[UILabel alloc] init];
        [view addSubview:replyLabel];
        replyLabel.font = [UIFont systemFontOfSize:12];
        replyLabel.text = [NSString stringWithFormat:@"%@回复",_model.teacherAnswerNum];
        replyLabel.textColor = [UIColor colorFromHexString:@"#999999"];
        [replyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(lineView.mas_right).with.offset(5);
            make.height.mas_equalTo(@10);
            make.centerY.mas_equalTo(lineView.mas_centerY);
        }];
        
        UIButton *newButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [view addSubview:newButton];
        newButton.tag = 201;
        [newButton addTarget:self action:@selector(changeNewestAndhottestQuestionAction:) forControlEvents:UIControlEventTouchUpInside];
        [newButton setTitle:@"最新" forState:UIControlStateNormal];
        [newButton setTitleColor:[UIColor colorFromHexString:@"#666666"] forState:UIControlStateNormal];
        [newButton setTitleColor:[UIColor colorFromHexString:@"#ff8833"] forState:UIControlStateSelected];
        [newButton setTitleColor:[UIColor colorFromHexString:@"#ff8833"] forState:UIControlStateHighlighted];
        [newButton.titleLabel setFont:[UIFont systemFontOfSize:12]];
        [newButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(@-15);
            make.top.mas_equalTo(@0);
            make.bottom.mas_equalTo(@0);
            make.width.mas_equalTo(@30);
        }];
        
        UIView *buttonLineView = [[UIView alloc] init];
        [view addSubview:buttonLineView];
        buttonLineView.backgroundColor = [UIColor colorFromHexString:@"#999999"];
        [buttonLineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(newButton.mas_left).with.offset(-5);
            make.top.mas_equalTo(@10);
            make.bottom.mas_equalTo(@-10);
            make.width.mas_equalTo(@0.5);
        }];
        
        UIButton *hotButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [view addSubview:hotButton];
        hotButton.selected = YES;
        hotButton.tag = 200;
        if (defaultSelectButton == nil) {
            defaultSelectButton = hotButton;
        }
        
        [hotButton addTarget:self action:@selector(changeNewestAndhottestQuestionAction:) forControlEvents:UIControlEventTouchUpInside];
        [hotButton setTitle:@"最热" forState:UIControlStateNormal];
        [hotButton setTitleColor:[UIColor colorFromHexString:@"#666666"] forState:UIControlStateNormal];
        [hotButton setTitleColor:[UIColor colorFromHexString:@"#ff8833"] forState:UIControlStateSelected];
        [hotButton setTitleColor:[UIColor colorFromHexString:@"#ff8833"] forState:UIControlStateHighlighted];
        [hotButton.titleLabel setFont:[UIFont systemFontOfSize:12]];
        [hotButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(buttonLineView.mas_left).with.offset(-5);
            make.top.mas_equalTo(@10);
            make.bottom.mas_equalTo(@-10);
            make.centerY.mas_equalTo(buttonLineView.mas_centerY);
            make.width.mas_equalTo(@30);
        }];
        
        if (defaultSelectButton.tag == 200) {
            hotButton.selected = YES;
            newButton.selected = NO;
        }else{
            newButton.selected = YES;
            hotButton.selected = NO;
        }
        
        return view;
    }else{
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, NNAppWidth, 10)];
        view.backgroundColor = [UIColor clearColor];
        return view;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NNQuestionAndAnswerCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NNQuestionAndAnswerCell"];
    cell.commentConstraint.constant = 0;
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
        
        NNQuestionAndAnswerModel *signModel = [questionAndAnswerMutableArray objectAtIndex:indexPath.section];
        
        if (button.selected) {
            [unViewModel unParisdArticleWithToken:TEST_TOKEN andArticleType:@"1" andArticleID:signModel.questionId];
        }else{
            [viewModel parisdArticleWithToken:TEST_TOKEN andArticleType:@"1" andArticleID:signModel.questionId];
        }

    };
    
    cell.commentBlock = ^(){
        NNQuestionAndAnswerDetailVC *detailVC = [[NNQuestionAndAnswerDetailVC alloc] initWithNibName:@"NNQuestionAndAnswerDetailVC" bundle:nil];
        detailVC.signModel = [questionAndAnswerMutableArray objectAtIndex:indexPath.section];
        detailVC.isComment = YES;
        [self.navigationController pushViewController:detailVC animated:YES];

    };
    cell.model = [questionAndAnswerMutableArray objectAtIndex:indexPath.section];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat height = [tableView fd_heightForCellWithIdentifier:@"NNQuestionAndAnswerCell" cacheByIndexPath:indexPath configuration:^(id cell) {
        NNQuestionAndAnswerCell *questionAndAnswerCell =  cell;
        questionAndAnswerCell.commentConstraint.constant = 0;

    }];
    return height;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NNQuestionAndAnswerDetailVC *detailVC = [[NNQuestionAndAnswerDetailVC alloc] initWithNibName:@"NNQuestionAndAnswerDetailVC" bundle:nil];
    detailVC.signModel = [questionAndAnswerMutableArray objectAtIndex:indexPath.section];
    [self.navigationController pushViewController:detailVC animated:YES];
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
