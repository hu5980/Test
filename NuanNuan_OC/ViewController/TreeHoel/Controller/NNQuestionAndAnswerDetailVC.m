//
//  NNQuestionAndAnswerDetailVC.m
//  NuanNuan_OC
//
//  Created by 忘、 on 16/10/12.
//  Copyright © 2016年 NuanNuan. All rights reserved.
//

#import "NNQuestionAndAnswerDetailVC.h"
#import "NNPsychologicalTeacherHeaderView.h"
@interface NNQuestionAndAnswerDetailVC () {
    NNPsychologicalTeacherHeaderView *headerView;
}

@property (weak, nonatomic) IBOutlet UITableView *questionAndAnswerTableView;

@end

@implementation NNQuestionAndAnswerDetailVC



- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initUI];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    CGSize size = [headerView systemLayoutSizeFittingSize:UILayoutFittingExpandedSize];
    NNLog(@"%f,%f",size.width,size.height);
    headerView.size = size;
}

- (void)initUI {
    
    headerView = LOAD_VIEW_FROM_BUNDLE(@"NNPsychologicalTeacherHeaderView");
    _questionAndAnswerTableView.tableHeaderView = headerView;
    
    __weak NNQuestionAndAnswerDetailVC *weakSelf = self;
    headerView.popblock = ^(){
        [weakSelf.navigationController popViewControllerAnimated:YES];
    };
    
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
