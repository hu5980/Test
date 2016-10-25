//
//  NNMineLikeVC.m
//  NuanNuan_OC
//
//  Created by 忘、 on 16/10/24.
//  Copyright © 2016年 NuanNuan. All rights reserved.
//

#import "NNMineLikeVC.h"
#import "NNEmotionallItemCell.h"
@interface NNMineLikeVC ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *likeTableView;

@end

@implementation NNMineLikeVC

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavigationBackButton:YES];
    [self createUI];
    // Do any additional setup after loading the view from its nib.
}

- (void)createUI {
    self.navTitle = @"我的喜欢";
    [self setNavigationBackButton:YES];
    
    _likeTableView.delegate = self;
    _likeTableView.dataSource = self;
    _likeTableView.backgroundColor = NN_BACKGROUND_COLOR;
    [_likeTableView registerNib:[UINib nibWithNibName:@"NNEmotionallItemCell" bundle:nil] forCellReuseIdentifier:@"NNEmotionallItemCell"];
}

#pragma --mark Delegate
#pragma --mark UItableViewdelegate UItableViewdatasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 10;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat height = [tableView fd_heightForCellWithIdentifier:@"NNEmotionallItemCell" cacheByIndexPath:indexPath configuration:^(id cell) {
        
    }];
    return height   ;

}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, NNAppWidth, 10)];
    view.backgroundColor = [UIColor clearColor];
    return  view;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NNEmotionallItemCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NNEmotionallItemCell"];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

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
