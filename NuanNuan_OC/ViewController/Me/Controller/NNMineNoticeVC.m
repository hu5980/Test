//
//  NNMineNoticeVC.m
//  NuanNuan_OC
//
//  Created by 忘、 on 16/10/24.
//  Copyright © 2016年 NuanNuan. All rights reserved.
//

#import "NNMineNoticeVC.h"
#import "NNNoticeViewModel.h"
#import "NNNoticeCell.h"
#import "NNNoticeModel.h"
@interface NNMineNoticeVC ()<UITableViewDelegate,UITableViewDataSource>{
    RLMResults *results;
}

@property (weak, nonatomic) IBOutlet UITableView *noticeTableView;
@end

@implementation NNMineNoticeVC

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
    self.navTitle = @"我的消息";
    [self setNavigationBackButton:YES];
    _noticeTableView.backgroundColor = NN_BACKGROUND_COLOR;
    _noticeTableView.delegate = self;
    _noticeTableView.dataSource = self;
    _noticeTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_noticeTableView registerNib:[UINib nibWithNibName:@"NNNoticeCell" bundle:nil] forCellReuseIdentifier:@"NNNoticeCell"];
    
}

- (void)initData {
    results = [NNNoticeViewModel getNoticeListWithUserID:USERID];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return results.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat height = [tableView fd_heightForCellWithIdentifier:@"NNNoticeCell" cacheByIndexPath:indexPath configuration:^(id cell) {
        NNNoticeCell *noticeCell = (NNNoticeCell *) cell;
        NNNoticeModel *model = [results objectAtIndex:indexPath.section];
        noticeCell.noticeContentLabel.text = model.noticeMsg;
    }];
    return height   ;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, NNAppWidth, 10)];
    view.backgroundColor = [UIColor clearColor];
    return view;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NNNoticeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NNNoticeCell"];
    NNNoticeModel *model = [results objectAtIndex:indexPath.section];
    if ([model.noticeType isEqualToString:@"1"]) {
        cell.noticeTypeLabel.text = @"收到回复";
    }else if ([model.noticeType isEqualToString:@"2"] || [model.noticeType isEqualToString:@"3"]){
        cell.noticeTypeLabel.text = @"收到评论";
    }else if  ([model.noticeType isEqualToString:@"4"] || [model.noticeType isEqualToString:@"5"]){
        cell.noticeTypeLabel.text = @"收到赞";
    }
    
    cell.noticeTimeLabel.text = [NNTimeUtil timeDealWithFormat:@"yyyy-MM-dd hh:mm:ss" andTime:[model.time integerValue]];
    
    cell.noticeContentLabel.text = model.noticeMsg;
    
    return cell;
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
