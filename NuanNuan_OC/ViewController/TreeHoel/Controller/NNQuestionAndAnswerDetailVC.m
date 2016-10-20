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
@interface NNQuestionAndAnswerDetailVC ()<UITableViewDelegate,UITableViewDataSource>


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
    // Do any additional setup after loading the view from its nib.
}

- (void)initUI {
    self.navTitle = @"问答详情";
   
    _questionAndAnswerTableView.delegate = self;
    _questionAndAnswerTableView.dataSource = self;
    _questionAndAnswerTableView.backgroundColor = NN_BACKGROUND_COLOR;
    [_questionAndAnswerTableView registerNib:[UINib nibWithNibName:@"NNNeterReplyCell" bundle:nil] forCellReuseIdentifier:@"NNNeterReplyCell"];
    [_questionAndAnswerTableView registerNib:[UINib nibWithNibName:@"NNQuestionAndAnswerCell" bundle:nil] forCellReuseIdentifier:@"NNQuestionAndAnswerCell"];
}

#pragma --mark UITableViewDelegate UItableViewDatasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }
    return 10;
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
        
        return cell;
    }else{
        NNNeterReplyCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NNNeterReplyCell"];
        
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
