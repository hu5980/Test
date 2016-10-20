//
//  NNServerVC.m
//  NuanNuan_OC
//
//  Created by 忘、 on 16/9/21.
//  Copyright © 2016年 NuanNuan. All rights reserved.
//

#import "NNServerVC.h"
#import "NNCustomNavigationView.h"
#import "NNServerListCell.h"

@interface NNServerVC () <UITableViewDelegate,UITableViewDataSource> {
    UIButton *defaultSelectButton;
}
@property (weak, nonatomic) IBOutlet UITableView *serverListTableView;

@end

@implementation NNServerVC

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    // Do any additional setup after loading the view.
}

- (void) initUI {
    NNCustomNavigationView *view = LOAD_VIEW_FROM_BUNDLE(@"NNCustomNavigationView");
    view.backgroundColor = [UIColor clearColor];
    defaultSelectButton = view.index1Button;
    [view.index1Button setTitle:@"私人定制" forState:UIControlStateNormal];
    [view.index2Button setTitle:@"夏日特惠" forState:UIControlStateNormal];
    
    view.selectBlock = ^(UIButton *button) {
        if (defaultSelectButton.tag != button.tag ) {
            defaultSelectButton.selected = NO;
            defaultSelectButton = button;
            defaultSelectButton.selected = YES;
            if (button.tag == 200) {
                NNLog(@"私人定制");
            }else{
                NNLog(@"夏日特惠");
            }
        }
    };
    self.navigationItem.titleView = view;
    
    _serverListTableView.dataSource = self;
    _serverListTableView.delegate = self;
    _serverListTableView.backgroundColor = NN_BACKGROUND_COLOR;
    [_serverListTableView registerNib:[UINib nibWithNibName:@"NNServerListCell" bundle:nil] forCellReuseIdentifier:@"NNServerListCell"];
}

#pragma --mark UITableViewdelegate UItableViewdatasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 5;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, NNAppWidth, 10)];
    view.backgroundColor = [UIColor clearColor];
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat height = [tableView fd_heightForCellWithIdentifier:@"NNServerListCell" cacheByIndexPath:indexPath configuration:^(id cell) {
        
    }];
    return height   ;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NNServerListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NNServerListCell"];
    
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
