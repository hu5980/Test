//
//  NNSetVC.m
//  NuanNuan_OC
//
//  Created by 忘、 on 16/10/24.
//  Copyright © 2016年 NuanNuan. All rights reserved.
//

#import "NNMineSetVC.h"
#import "NNSetCell.h"
#import "NNLoginAndRegisterVC.h"
#import "NNUserAgreementVC.h"
#import "NNAboutNuanNuan.h"
@interface NNMineSetVC ()<UITableViewDelegate,UITableViewDataSource> {
    NSArray *titleArray;
    NSString *cacheText;
}
@property (weak, nonatomic) IBOutlet UITableView *setTableView;

@end

@implementation NNMineSetVC

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
    self.navTitle = @"设置";
    [self setNavigationBackButton:YES];
    
    _setTableView.delegate = self;
    _setTableView.backgroundColor = NN_BACKGROUND_COLOR;
    _setTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _setTableView.dataSource = self;
    _setTableView.rowHeight = 44.f;
    [_setTableView registerNib:[UINib nibWithNibName:@"NNSetCell" bundle:nil] forCellReuseIdentifier:@"NNSetCell"];
}

- (void)initData {
    titleArray = @[@"关于暖暖",@"用户协议",@"清除缓存"];
    [self getCache];
}


- (void)getCache {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        SDImageCache *cache = [SDImageCache sharedImageCache];
        NSUInteger cacheSize = cache.getSize;
        cacheText = [NSString stringWithFormat:@"%.2f M",cacheSize/1024.0/1024.0];
        [_setTableView reloadData];
    });
}


#pragma --mark UItableViewDelegate UITableViewDatasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 3;
    }else{
        return 1;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, NNAppWidth, 10)];
    view.backgroundColor = [UIColor clearColor];
    return view;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        NNSetCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NNSetCell"];
        cell.setTltleLabel.text = [titleArray objectAtIndex:indexPath.row];
        if (indexPath.row == 2) {
            UILabel *cacheLabel = [[UILabel alloc] init];
            [cell.contentView addSubview:cacheLabel];
            [cacheLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.equalTo(@-25);
                make.top.equalTo(@0);
                make.bottom.equalTo(@0);
                make.left.equalTo(cell.setTltleLabel.mas_right).with.offset(10.0f);
            }];
            cacheLabel.textAlignment = NSTextAlignmentRight;
            cacheLabel.font = [UIFont systemFontOfSize:14.f];
            cacheLabel.textColor = NN_TEXT666666_COLOR;
            cacheLabel.text = cacheText;
        }
        return cell;
    }else{
        UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake((NNAppWidth - 100)/2 , 0, 100, 44)];
        label.textColor = [UIColor colorFromHexString:@"#ff9933"];
        label.font = [UIFont systemFontOfSize:14.f];
        label.text = @"退出帐号";
        label.textAlignment = NSTextAlignmentCenter;
        [cell.contentView addSubview:label];
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            NNAboutNuanNuan *aboutVC = [[NNAboutNuanNuan alloc] init];
            
            [self.navigationController pushViewController:aboutVC animated:YES];
        }else if (indexPath.row == 1){
            NNUserAgreementVC *agreementVC = [[NNUserAgreementVC alloc] initWithNibName:@"NNUserAgreementVC" bundle:nil];
            [self.navigationController pushViewController:agreementVC animated:YES];
        }else if (indexPath.row == 2){
            [[SDImageCache sharedImageCache] clearDisk];
            [self getCache];
        }
    }else{
        NNLoginAndRegisterVC *loginOrRegisterVC = [[NNLoginAndRegisterVC alloc] initWithNibName:@"NNLoginAndRegisterVC" bundle:nil];
        
        [self.navigationController pushViewController:loginOrRegisterVC animated:YES];
      
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
