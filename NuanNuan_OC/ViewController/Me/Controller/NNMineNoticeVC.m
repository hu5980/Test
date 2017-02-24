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
#import "NNCommentModel.h"
#import "NNTreeHoelModel.h"
#import "NNUserInfoModel.h"
#import "NNSpitslotDetailVC.h"
#import "NNQuestionAndAnswerModel.h"
#import "NNEmotionTeacherModel.h"
#import "NNQuestionAndAnswerDetailVC.h"
#import "NNNoticeServer.h"
#import "NNNoticeHadReadViewModel.h"
@interface NNMineNoticeVC ()<UITableViewDelegate,UITableViewDataSource>{
    RLMResults *results;
    NNNoticeModel *selectNoticeModel;
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
    
    if(results.count == 0){
        [self showBackgroundViewImageName:@"back_ic" andTitle:@"暂时没有消息"];
    }else{
        [self hideBackgroundViewImage];
    }
    
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
    return height;
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
    if([model.isRead isEqualToString:@"1"]){
        cell.noticeContentLabel.textColor =  NN_TEXT666666_COLOR;
        cell.noticeTimeLabel.textColor = NN_TEXT666666_COLOR;
        cell.noticeTypeLabel.textColor =  NN_TEXT666666_COLOR;
    }else{
        cell.noticeContentLabel.textColor =  NN_TEXT333333_COLOR;
        cell.noticeTimeLabel.textColor = NN_TEXT333333_COLOR;
        cell.noticeTypeLabel.textColor =  NN_TEXT333333_COLOR;
    }
    cell.noticeTimeLabel.text = [NNTimeUtil timeDealWithFormat:@"yyyy-MM-dd hh:mm" andTime:[model.time integerValue]];
    cell.noticeContentLabel.text = model.noticeMsg;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    selectNoticeModel = [results objectAtIndex:indexPath.section];
    NSLog(@"%@",selectNoticeModel.noticeId);
    NSDictionary *dic =  [self dictionaryWithJsonString:selectNoticeModel.noticeData];
    
    NNNoticeHadReadViewModel *viewModel = [[NNNoticeHadReadViewModel alloc] init];
    [viewModel setBlockWithReturnBlock:^(id returnValue) {
        if([returnValue isEqualToString:@"success"]){
             NSLog(@"%@",selectNoticeModel.noticeId);
            [NNNoticeViewModel changeNoticeReadState:selectNoticeModel.noticeId];
        }
    } WithErrorBlock:^(id errorCode) {
        [NNProgressHUD showHudAotoHideAddToView:self.view withMessage:errorCode];
    } WithFailureBlock:^(id failureBlock) {
        
    }];
    [viewModel hadReadNoticeWithToken:TEST_TOKEN andNoticeID:selectNoticeModel.noticeId];
    
    [NNNoticeServer dealWithDictionary:dic andNoticeType:selectNoticeModel.noticeType andisPresent:NO andViewController:self];
    
}

- (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString {
    if (jsonString == nil) {
        return nil;
    }
    
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    if(err) {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return dic;
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
