//
//  NNSetVC.m
//  NuanNuan_OC
//
//  Created by 忘、 on 16/10/24.
//  Copyright © 2016年 NuanNuan. All rights reserved.
//

#import "NNMineSetVC.h"
#import "NNSetCell.h"
#import "NNLoginVC.h"
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
    titleArray = @[@"关于暖暖情感",@"用户协议",@"清除缓存"];
    [self getCacheisDisk:NO];
}

- (void)getCacheisDisk:(BOOL)isDesk {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        SDImageCache *cache = [SDImageCache sharedImageCache];
        NSUInteger cacheSize = cache.getSize;
        cacheText = [NSString stringWithFormat:@"%.2f M",cacheSize/1024.0/1024.0];
        
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [_setTableView reloadData];
            [[NNProgressHUD instance] hideHud];
            if (isDesk) {
                [NNProgressHUD showHudAotoHideAddToView:self.view withMessage:@"缓存清除成功"];
            }
        });
        
        
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
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.setTltleLabel.text = [titleArray objectAtIndex:indexPath.row];
        if (indexPath.row == 2) {
            cell.contentLabel.text = cacheText;
        }
        return cell;
    }else{
        UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"loginOut"];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake((NNAppWidth - 100)/2 , 0, 100, 44)];
        label.textColor = [UIColor colorFromHexString:@"#333333"];
        
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
             [MobClick event:@"clk_about"];
            NNAboutNuanNuan *aboutVC = [[NNAboutNuanNuan alloc] init];
            
            [self.navigationController pushViewController:aboutVC animated:YES];
        }else if (indexPath.row == 1){
              [MobClick event:@"clk_ agreement"];
            NNUserAgreementVC *agreementVC = [[NNUserAgreementVC alloc] initWithNibName:@"NNUserAgreementVC" bundle:nil];
            [self.navigationController pushViewController:agreementVC animated:YES];
        }else if (indexPath.row == 2){
              [MobClick event:@"clk_CleanCache"];
            [[NNProgressHUD instance] showHudToView:self.view withMessage:@"缓存清除中"];
            [[SDImageCache sharedImageCache] clearDisk];
            
            [self getCacheisDisk:YES];
        }
    }else{
          [MobClick event:@"clk_quit"];
        NNLoginVC *loginOrRegisterVC = [[NNLoginVC alloc] initWithNibName:@"NNLoginVC" bundle:nil];
        loginOrRegisterVC.isPresent = YES;
        loginOrRegisterVC.hidesBottomBarWhenPushed = YES;
        [[NSUserDefaults standardUserDefaults] setObject:nil forKey:@"token"];
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
