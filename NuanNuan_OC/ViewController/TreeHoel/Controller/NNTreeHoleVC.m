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

@interface NNTreeHoleVC ()<UITableViewDelegate,UITableViewDataSource> {
    UIButton *defaultSelectButton;
}
@property (weak, nonatomic) IBOutlet UITableView *treeHoelTableView;

@end

@implementation NNTreeHoleVC

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO];
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
    NNCustomNavigationView *view = LOAD_VIEW_FROM_BUNDLE(@"NNCustomNavigationView");
    view.backgroundColor = [UIColor clearColor];
    defaultSelectButton = view.emotionAskButton;
    view.selectBlock = ^(UIButton *button) {
        if (defaultSelectButton.tag != button.tag ) {
            defaultSelectButton.selected = NO;
            defaultSelectButton = button;
            defaultSelectButton.selected = YES;
            if (button.tag == 200) {
                NNLog(@"情感问吧");
            }else{
                NNLog(@"吐槽树洞");
            }
        }
    };
    self.navigationItem.titleView = view;
    
    _treeHoelTableView.backgroundColor = NN_BACKGROUND_COLOR;
    _treeHoelTableView.delegate = self;
    _treeHoelTableView.dataSource = self;
    [_treeHoelTableView registerNib:[UINib nibWithNibName:@"NNTreeHoelCell" bundle:nil] forCellReuseIdentifier:@"NNTreeHoelCell"];
}

- (void)initData {
    
}

#pragma --mark  UItableViewDelegate UItableViewDatasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 10;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NNTreeHoelCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NNTreeHoelCell"];
    return cell;
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat height = [tableView fd_heightForCellWithIdentifier:@"NNTreeHoelCell" cacheByIndexPath:indexPath configuration:^(id cell) {
        
    }];
    return height   ;
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
    NNQuestionAndAnswerDetailVC *detailVC = [[NNQuestionAndAnswerDetailVC alloc] initWithNibName:@"NNQuestionAndAnswerDetailVC" bundle:nil];
    detailVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController: detailVC animated:YES];
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
