//
//  NNSpitslotDetailVC.m
//  NuanNuan_OC
//
//  Created by 胡光耀 on 16/10/23.
//  Copyright © 2016年 NuanNuan. All rights reserved.
//

#import "NNSpitslotDetailVC.h"
#import "NNSpitslotCell.h"
#import "NNImageBroswerView.h"
#import "NNNeterReplyCell.h"
#import "NNReplyView.h"
#import "NNAskingView.h"
#import "MWPhotoBrowser.h"

@interface NNSpitslotDetailVC () <UITableViewDelegate,UITableViewDataSource,UITextViewDelegate,UITextFieldDelegate> {
    NSArray *array;
    NNAskingView *askingView;
    UIButton *backgroundButton;
    NNReplyView *replyView ;
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
    _spitslotTableView.dataSource = self;
    _spitslotTableView.backgroundColor = NN_BACKGROUND_COLOR;
    [_spitslotTableView registerNib:[UINib nibWithNibName:@"NNNeterReplyCell" bundle:nil] forCellReuseIdentifier:@"NNNeterReplyCell"];
    [_spitslotTableView registerNib:[UINib nibWithNibName:@"NNSpitslotCell" bundle:nil] forCellReuseIdentifier:@"NNSpitslotCell"];
    
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
            
        }
    };
    [self.view addSubview:askingView];

    if (_isComment) {
        [replyView.replytextField becomeFirstResponder];
    }
}

- (void)initData {
    array = @[@"http1",@"http2",@"http1",@"http2"];
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
    
    
}

- (void)keyboardWillHide:(NSNotification *)notification{
    backgroundButton.hidden = YES;
    CGFloat animationDuration =  [[[notification userInfo] objectForKey:UIKeyboardAnimationDurationUserInfoKey] floatValue];
    [UIView animateWithDuration:animationDuration animations:^{
        askingView.frame = CGRectMake(0, NNAppHeight, NNAppWidth, 130);
    }];
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
        return 10;
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
        [view addSubview:label];                                              label.text = @"网友评论";
        label.font = [UIFont systemFontOfSize:14.f];
        label.textColor = [UIColor colorFromHexString:@"#ff8833"];
        view.backgroundColor = NN_BACKGROUND_COLOR;
        return view;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        NNSpitslotCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NNSpitslotCell"];
     
        __weak NNSpitslotDetailVC *weakSelf = self;
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
        cell.model = _model;
        
        cell.block = ^(NSInteger tag){
            switch (tag) {
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
    }else{
        NNNeterReplyCell *cell  = [tableView dequeueReusableCellWithIdentifier:@"NNNeterReplyCell"];
        
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
