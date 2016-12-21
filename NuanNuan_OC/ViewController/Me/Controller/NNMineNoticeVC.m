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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NNNoticeModel *model = [results objectAtIndex:indexPath.section];
    
    NSDictionary *dic =  [self dictionaryWithJsonString:model.noticeData];
    
    [self dealWithDictionary:dic andNoticeType:model.noticeType];
    
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

- (void)dealWithDictionary:(NSDictionary *)dicInfo andNoticeType:(NSString *)noticeType {
    if ([noticeType isEqualToString:@"3"]) {
        NSDictionary *commentInfo = [dicInfo  objectForKey:@"comment_info"];
        NSDictionary *treeHoleInfo = [dicInfo objectForKey:@"treehole_info"];
        NSDictionary *userInfo = [dicInfo objectForKey:@"user_info"];
        NNTreeHoelModel *treeHoelModel  = [self analysisTreeHoelDictoModelwithDic:treeHoleInfo];
        NNCommentModel *commentModel = [self analysiscommentModelwithDic:commentInfo];
        commentModel.commentHeaderUrl = [userInfo objectForKey:@"head"];
        
        NNSpitslotDetailVC *spitslotDetailVC = [[NNSpitslotDetailVC alloc] init];
        spitslotDetailVC.model = treeHoelModel;
        spitslotDetailVC.isFromNotice = YES;
        spitslotDetailVC.commentMutableArray = [NSMutableArray arrayWithObject:commentModel];
        [self.navigationController pushViewController:spitslotDetailVC animated:YES];
    }else if ([noticeType isEqualToString:@"5"]){
    
        NSDictionary *treeHoleInfo = [dicInfo objectForKey:@"treehole_info"];
        NNTreeHoelModel *treeHoelModel  = [self analysisTreeHoelDictoModelwithDic:treeHoleInfo];
        NNSpitslotDetailVC *spitslotDetailVC = [[NNSpitslotDetailVC alloc] init];
        spitslotDetailVC.model = treeHoelModel;
        spitslotDetailVC.isFromNotice = YES;
        spitslotDetailVC.commentMutableArray = nil;
        [self.navigationController pushViewController:spitslotDetailVC animated:YES];
    }else if ([noticeType isEqualToString:@"1"]){
        NNQuestionAndAnswerDetailVC *questionAndAnswerVC = [[NNQuestionAndAnswerDetailVC alloc] init];
        questionAndAnswerVC.isFromNotice = YES;
        questionAndAnswerVC.signModel = [self analysisQuestionAndAnswerModelwithDic:dicInfo];
        [self.navigationController pushViewController:questionAndAnswerVC animated:YES];
    }else if ([noticeType isEqualToString:@"2"]){
        NSDictionary *commentInfo = [dicInfo  objectForKey:@"comment_info"];
        NNCommentModel *commentModel = [self analysiscommentModelwithDic:commentInfo];
        NNQuestionAndAnswerDetailVC *questionAndAnswerVC = [[NNQuestionAndAnswerDetailVC alloc] init];
        questionAndAnswerVC.isFromNotice = YES;
        questionAndAnswerVC.commentMutableArray = [NSMutableArray arrayWithObject:commentModel];
        questionAndAnswerVC.signModel = [self analysisQuestionAndAnswerModelwithDic:dicInfo];
        [self.navigationController pushViewController:questionAndAnswerVC animated:YES];
        
    }
 
}


- (NNTreeHoelModel *)analysisTreeHoelDictoModelwithDic :(NSDictionary  *)treeHoleInfo {
    NNTreeHoelModel *treeHoelModel = [[NNTreeHoelModel alloc] init];
    
    treeHoelModel.thID = [treeHoleInfo objectForKey:@"th_id"];
    treeHoelModel.isGood = [[treeHoleInfo objectForKey:@"has_good"] boolValue];
    treeHoelModel.uid = [treeHoleInfo objectForKey:@"uid"];
    treeHoelModel.thContent = [treeHoleInfo objectForKey:@"th_content"];
    NSString *basePathUrl = [treeHoleInfo objectForKey:@"th_pic_path"];
    NSString  *picString =  [treeHoleInfo objectForKey:@"th_pics"];
    NSData *jsonData = [picString dataUsingEncoding:NSUTF8StringEncoding];
    NSArray *picArrays = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableLeaves error:nil];
    NSMutableArray *picMutableArrays = [NSMutableArray array];
    for (int j= 0; j < picArrays.count; j++) {
        [picMutableArrays addObject:[NSString stringWithFormat:@"%@/%@",basePathUrl,[picArrays objectAtIndex:j]]];
    }
    
    treeHoelModel.picArrays = picMutableArrays;
    treeHoelModel.thAnonymity = [treeHoleInfo objectForKey:@"th_anonymity"];
    treeHoelModel.thCommentNum =[treeHoleInfo objectForKey:@"th_comment_num"];
    treeHoelModel.thGoodsNum =[treeHoleInfo objectForKey:@"th_goods_num"];
    treeHoelModel.userHeadUrl = [NSString stringWithFormat:@"%@/%@",basePathUrl,[treeHoleInfo objectForKey:@"user_head"]];
    treeHoelModel.userNikeName = [treeHoleInfo objectForKey:@"user_nickname"];
    treeHoelModel.createTime = [[treeHoleInfo objectForKey:@"create_time"] integerValue];
    treeHoelModel.modifyTime = [[treeHoleInfo objectForKey:@"modify_time"] integerValue];

    return treeHoelModel;
}

- (NNCommentModel *)analysiscommentModelwithDic :(NSDictionary  *)commentInfo {

    NNCommentModel *commentModel = [[NNCommentModel alloc] init];
    commentModel.commentID = [commentInfo objectForKey:@"c_id"];
    commentModel.commentUID = [commentInfo objectForKey:@"uid"];
    commentModel.commentOID = [commentInfo objectForKey:@"o_id"];
    commentModel.commentType = [commentInfo objectForKey:@"c_type"];
    commentModel.commentContent = [commentInfo objectForKey:@"c_content"];
    commentModel.commentGoodsNum = [commentInfo objectForKey:@"c_goods_num"];
    commentModel.commentIsdel = [commentInfo objectForKey:@"c_isdel"];
    commentModel.commentNickName = [commentInfo objectForKey:@"user_nickname"];
    commentModel.commentCreateTime = [[commentInfo objectForKey:@"create_time"] integerValue];
    commentModel.commentModifyTime = [[commentInfo objectForKey:@"modify_time"] integerValue];

    return commentModel;
    
}


- (NNQuestionAndAnswerModel *)analysisQuestionAndAnswerModelwithDic:(NSDictionary  *)dic{
    NNQuestionAndAnswerModel *signalModel = [[NNQuestionAndAnswerModel alloc] init];
    NSDictionary *teacherInfo = [dic objectForKey:@"teacher_info"];
    NNEmotionTeacherModel *teacherModel = [self analysisteacherModelwithDic:teacherInfo];
    NSDictionary *questionInfo = [dic objectForKey:@"question_info"];
    signalModel.teacherModel = teacherModel;
    signalModel.questionId = [questionInfo objectForKey:@"q_id"];
    signalModel.questionContent = [questionInfo objectForKey:@"q_content"];
    signalModel.questionCommentNum = [questionInfo objectForKey:@"q_comment_num"];
    signalModel.questionGoodsNum = [questionInfo objectForKey:@"q_goods_num"];
    signalModel.questionAnswer = [questionInfo objectForKey:@"q_answer"];
    signalModel.questionCreateTime = [[questionInfo objectForKey:@"create_time"] integerValue];
    signalModel.questionHeadUrl = [questionInfo objectForKey:@"user_head"];
    signalModel.questionNickName = [questionInfo objectForKey:@"user_nickname"];
    signalModel.isGood = [[questionInfo objectForKey:@"has_good"] boolValue];
 
    return signalModel;
}

- (NNEmotionTeacherModel *)analysisteacherModelwithDic :(NSDictionary *)teacherInfo {
    NNEmotionTeacherModel *teacherModel = [[NNEmotionTeacherModel alloc] init];
    teacherModel.teacherHeadUrl = [NSString stringWithFormat:@"%@/%@",[teacherInfo objectForKey:@"t_head_path"],[teacherInfo objectForKey:@"t_head"]];
    teacherModel.backgroundImageUrl = [NSString stringWithFormat:@"%@/%@",[teacherInfo objectForKey:@"t_bg_pic_path"],[teacherInfo objectForKey:@"t_bg_pic"]];
    teacherModel.teacherTypeName = [teacherInfo objectForKey:@"t_good_at"];
    teacherModel.teacherNickName = [teacherInfo objectForKey:@"t_nickname"];
    return teacherModel;
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
