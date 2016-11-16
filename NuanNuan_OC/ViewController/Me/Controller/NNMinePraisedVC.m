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
@interface NNMinePraisedVC ()<UITableViewDataSource,UITableViewDelegate>{

    MJRefreshFooter *footer;
    NSArray *imageArrays;
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
}

- (void)refreshData {
    
}

#pragma --mark Action
- (IBAction)selectTypeAction:(UIButton *)sender {
    _defaultButton.selected = NO;
    _defaultButton = sender;
    _defaultButton.selected = YES;
    if (sender.tag == 100) {
        
    }else{
        
    }
    [_praisedTableView reloadData];
}


#pragma --mark Delegate
#pragma --mark UITableViewDelegate UItableViewDatasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (_defaultButton.tag == 100) {
        return 1;
    }else{
        return 3;
    }
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
            
        }];
        
    }else{
        height = [tableView fd_heightForCellWithIdentifier:@"NNSpitslotCell" cacheByIndexPath:indexPath configuration:^(id cell) {
            NNSpitslotCell *spitslotCell = cell;
            spitslotCell.contentLabel.text = @"我要是开始 测试了啊我要是开始 测试了啊我要是开始 测试了啊我要是开始 测试了啊我要是开始 测试了啊我要是开始 测试了啊";
            NNImageBroswerView *broswerImageView = [[NNImageBroswerView alloc] initWithFrame:CGRectMake(0, 0, NNAppWidth, 0) ImageUrls:imageArrays SpaceWithImage:10 SpaceWithSideOfSuperView:15 NumberImageOfLine:3];
            spitslotCell.broswerViewConstraint.constant = broswerImageView.broswerViewHeight;
            
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
        
        return cell;
    }else{
        NNSpitslotCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NNSpitslotCell"];
        
        cell.contentLabel.text = @"我要是开始 测试了啊我要是开始 测试了啊我要是开始 测试了啊我要是开始 测试了啊我要是开始 测试了啊我要是开始 测试了啊";
        NNImageBroswerView *broswerImageView = [[NNImageBroswerView alloc] initWithFrame:CGRectMake(0, 0, NNAppWidth, 0) ImageUrls:imageArrays SpaceWithImage:10 SpaceWithSideOfSuperView:15 NumberImageOfLine:3];
        cell.broswerViewConstraint.constant = broswerImageView.broswerViewHeight;
        [cell.broswerView addSubview:broswerImageView];
        broswerImageView.block = ^(NSInteger tag){
            NNLog(@"%ld",(long)tag);
        };
        
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
