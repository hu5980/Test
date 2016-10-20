//
//  NNMeVC.m
//  NuanNuan_OC
//
//  Created by 忘、 on 16/9/21.
//  Copyright © 2016年 NuanNuan. All rights reserved.
//

#import "NNMeVC.h"
#import "NNMineEmotionalMangmentCell.h"
#import "NNMineCell.h"
#import "Masonry.h"


@interface NNMeVC ()<UITableViewDelegate,UITableViewDataSource> {
    NSArray *imageArray;
    NSArray *titleArray;
    
    UILabel *ninkNameLabel;
    UIButton *headerButton;
    UIButton *backgroundButton;
}
@property (weak, nonatomic) IBOutlet UITableView *meTableView;

@end

@implementation NNMeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initdata];
    [self initView];
    // Do any additional setup after loading the view.
}


- (void)initView {
    
    _meTableView.tableHeaderView = [self createTableHeaderView];
    
    _meTableView.delegate = self;
    _meTableView.dataSource = self;
    _meTableView.rowHeight = 44.f;
    _meTableView.backgroundColor = NN_BACKGROUND_COLOR;
    _meTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [_meTableView registerNib:[UINib nibWithNibName:@"NNMineEmotionalMangmentCell" bundle:nil] forCellReuseIdentifier:@"NNMineEmotionalMangmentCell"];
}

- (UIView *)createTableHeaderView {
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, NNAppWidth, NNAppWidth *164 / 375)];
    backgroundButton = [UIButton buttonWithType:UIButtonTypeCustom];
    backgroundButton.backgroundColor = [UIColor redColor];
    [headerView addSubview:backgroundButton];
    
    [backgroundButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@0);
        make.right.equalTo(@0);
        make.top.equalTo(@-20);
        make.bottom.equalTo(@0);
    }];
    
    headerButton = [UIButton buttonWithType:UIButtonTypeCustom];
    headerButton.layer.masksToBounds = YES;
    headerButton.layer.cornerRadius = 30;
    headerButton.backgroundColor = [UIColor yellowColor];
    [backgroundButton addSubview:headerButton];
    [headerButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@60);
        make.height.equalTo(@60);
        make.top.equalTo(@((NNAppWidth*62)/375 ));
        make.centerX.equalTo(backgroundButton.mas_centerX);
    }];
    
    ninkNameLabel = [[UILabel alloc] init];
    ninkNameLabel.textColor = [UIColor colorFromHexString:@"#333333"];
    ninkNameLabel.font = [UIFont systemFontOfSize:14.f];
    [backgroundButton addSubview:ninkNameLabel];
    [ninkNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@150);
        make.centerX.equalTo(backgroundButton.mas_centerX);
        make.top.equalTo(headerButton.mas_bottom).with.offset(8.0f);
        make.height.equalTo(@20);
    }];
    
    ninkNameLabel.backgroundColor = [UIColor whiteColor];
    
    return headerView;
}

- (void)initdata {
    titleArray = @[@"我的预约",@"我的问吧",@"我的消息",@"意见反馈",@"设置"];
    imageArray = @[@"400_16",@"400_23",@"400_27",@"400_29",@"400_31"];
}


#pragma --Mark  UItableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if(section == 0){
        return 1;
    }
    else if(section == 1) {
        return 3;
    }else{
        return 2;
    }
        
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 60;
    }else{
        return 44;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"mineCell";
    NNMineCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"NNMineCell" owner:self options:nil][0];
    }
    if (indexPath.section == 0) {
        NNMineEmotionalMangmentCell *emotionalMangmentCell = [tableView dequeueReusableCellWithIdentifier:@"NNMineEmotionalMangmentCell"];
        
        return emotionalMangmentCell;
    }else if (indexPath.section == 1) {
        cell.iconImageView.image = [UIImage imageNamed:[imageArray objectAtIndex:indexPath.row]];
        cell.mineTitleLabel.text = [titleArray objectAtIndex:indexPath.row];
    }else {
        cell.iconImageView.image = [UIImage imageNamed:[imageArray objectAtIndex:indexPath.row + 3]];
        cell.mineTitleLabel.text = [titleArray objectAtIndex:indexPath.row + 3];

    }
    
    return cell;
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
