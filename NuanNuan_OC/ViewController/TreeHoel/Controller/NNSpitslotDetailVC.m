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
@interface NNSpitslotDetailVC () <UITableViewDelegate,UITableViewDataSource> {
    NSArray *array;
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
}

- (void)initData {
    array = @[@"http1",@"http2",@"http1",@"http2"];
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
            spitslotCell.contentLabel.text = @"我要是开始 测试了啊我要是开始 测试了啊我要是开始 测试了啊我要是开始 测试了啊我要是开始 测试了啊我要是开始 测试了啊";
            NNImageBroswerView *broswerImageView = [[NNImageBroswerView alloc] initWithFrame:CGRectMake(0, 0, NNAppWidth, 0) ImageUrls:nil SpaceWithImage:10 SpaceWithSideOfSuperView:15 NumberImageOfLine:3];
            spitslotCell.broswerViewConstraint.constant = broswerImageView.broswerViewHeight;
            
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
        [view addSubview:label];
        label.text = @"网友评论";
        label.font = [UIFont systemFontOfSize:14.f];
        label.textColor = [UIColor colorFromHexString:@"#ff8833"];
        view.backgroundColor = NN_BACKGROUND_COLOR;
        return view;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        NNSpitslotCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NNSpitslotCell"];
        
        cell.contentLabel.text = @"我要是开始 测试了啊我要是开始 测试了啊我要是开始 测试了啊我要是开始 测试了啊我要是开始 测试了啊我要是开始 测试了啊";
        NNImageBroswerView *broswerImageView = [[NNImageBroswerView alloc] initWithFrame:CGRectMake(0, 0, NNAppWidth, 0) ImageUrls:nil SpaceWithImage:10 SpaceWithSideOfSuperView:15 NumberImageOfLine:3];
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
