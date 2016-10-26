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
#import "NNPsychologicalTeacherVC.h"
#import "NNSpitslotCell.h"
#import "NNImageBroswerView.h"
#import "NNSpitslotDetailVC.h"
#import "NNEmotionTeacherModel.h"
#import "NNEmotionTeacherViewModel.h"


@interface NNTreeHoleVC ()<UITableViewDelegate,UITableViewDataSource> {
    UIButton *defaultSelectButton;
    NSArray *teacherModelArrays;
    NSArray *array;
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
    
    defaultSelectButton = view.index1Button;
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
            
            [_treeHoelTableView reloadData];
        }
    };
    self.navigationItem.titleView = view;
    
    _treeHoelTableView.backgroundColor = NN_BACKGROUND_COLOR;
    _treeHoelTableView.delegate = self;
    _treeHoelTableView.dataSource = self;
    [_treeHoelTableView registerNib:[UINib nibWithNibName:@"NNTreeHoelCell" bundle:nil] forCellReuseIdentifier:@"NNTreeHoelCell"];
    [_treeHoelTableView registerNib:[UINib nibWithNibName:@"NNSpitslotCell" bundle:nil] forCellReuseIdentifier:@"NNSpitslotCell"];
}

- (void)initData {
    array = @[@"图片地址"];
    
    NNEmotionTeacherViewModel  *emotionTeacherViewModel =  [[NNEmotionTeacherViewModel alloc] init];
    [emotionTeacherViewModel setBlockWithReturnBlock:^(id returnValue) {
        teacherModelArrays = returnValue;
        [_treeHoelTableView reloadData];
    } WithErrorBlock:^(id errorCode) {
        
    } WithFailureBlock:^(id failureBlock) {
        
    }];
    
    [emotionTeacherViewModel getEmotionTeacherListContentWithLastTeacherID:@"0" andUpdatePageNum:@"10"];
}

#pragma --mark  UItableViewDelegate UItableViewDatasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (defaultSelectButton.tag == 200) {
        return teacherModelArrays.count;
    }
    return 10;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (defaultSelectButton.tag == 200) {
        NNTreeHoelCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NNTreeHoelCell"];
        NNEmotionTeacherModel *model = [teacherModelArrays objectAtIndex:indexPath.section];
        [cell.backgroundImageView setImageWithURL:[NSURL URLWithString:model.backgroundImageUrl] placeholderImage:[UIImage imageNamed:@"detail_defalut"]];
        [cell.iconImageView setImageWithURL:[NSURL URLWithString:model.teacherHeadUrl] placeholderImage:[UIImage imageNamed:@"detail_defalut"]];
        cell.ninkNameLabel.text = model.teacherNickName;
        cell.specialityLabel.text = model.teacherTypeName;
        cell.questionNumLabel.text = [NSString stringWithFormat:@"%@提问",model.teacherQuestionNum];
        cell.expertIntroductionLabel.text = model.teacherDescription;
        return cell;
    }else{
        NNSpitslotCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NNSpitslotCell"];
     
        cell.contentLabel.text = @"我要是开始 测试了啊我要是开始 测试了啊我要是开始 测试了啊我要是开始 测试了啊我要是开始 测试了啊我要是开始 测试了啊";
        NNImageBroswerView *broswerImageView = [[NNImageBroswerView alloc] initWithFrame:CGRectMake(0, 0, NNAppWidth, 0) ImageUrls:array SpaceWithImage:10 SpaceWithSideOfSuperView:15 NumberImageOfLine:3];
        cell.broswerViewConstraint.constant = broswerImageView.broswerViewHeight;
        [cell.broswerView addSubview:broswerImageView];
        broswerImageView.block = ^(NSInteger tag){
            NNLog(@"%ld",(long)tag);
        };
        
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
    }
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat height;
    if (defaultSelectButton.tag == 200) {
        height = [tableView fd_heightForCellWithIdentifier:@"NNTreeHoelCell" cacheByIndexPath:indexPath configuration:^(id cell) {
            
        }];
    }else{
        height = [tableView fd_heightForCellWithIdentifier:@"NNSpitslotCell" cacheByIndexPath:indexPath configuration:^(id cell) {
            NNSpitslotCell *spitslotCell = cell;
            spitslotCell.contentLabel.text = @"我要是开始 测试了啊我要是开始 测试了啊我要是开始 测试了啊我要是开始 测试了啊我要是开始 测试了啊我要是开始 测试了啊";
            NNImageBroswerView *broswerImageView = [[NNImageBroswerView alloc] initWithFrame:CGRectMake(0, 0, NNAppWidth, 0) ImageUrls:array SpaceWithImage:10 SpaceWithSideOfSuperView:15 NumberImageOfLine:3];
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

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (defaultSelectButton.tag == 200) {
        NNPsychologicalTeacherVC *teacherVC = [[NNPsychologicalTeacherVC alloc] initWithNibName:@"NNPsychologicalTeacherVC" bundle:nil];
        teacherVC.model = [teacherModelArrays objectAtIndex:indexPath.section];
        teacherVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController: teacherVC animated:YES];
    }else{
        NNSpitslotDetailVC *spitslotDetailVC = [[NNSpitslotDetailVC alloc] initWithNibName:@"NNSpitslotDetailVC" bundle:nil];
        spitslotDetailVC.hidesBottomBarWhenPushed = YES;
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
