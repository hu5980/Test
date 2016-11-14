//
//  NNAppointmentVC.m
//  NuanNuan_OC
//
//  Created by 忘、 on 16/11/14.
//  Copyright © 2016年 NuanNuan. All rights reserved.
//

#import "NNAppointmentVC.h"
#import "NNQuestionerInfoCell.h"
#import "NNChooseView.h"
#import "NNQuestionerChooseCell.h"
#import "NNQuestionCell.h"
@interface NNAppointmentVC ()<UITableViewDelegate,UITableViewDataSource> {
    NSArray *sexArray;
    NSArray *consultTypeArray;
}
@property (weak, nonatomic) IBOutlet UITableView *appointmentTableView;

@end

@implementation NNAppointmentVC

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initData];
    [self initUI];

    // Do any additional setup after loading the view from its nib.
}

- (void)initUI {
    self.navTitle = @"免费咨询";
    [self setNavigationBackButton:YES];
    _appointmentTableView.delegate = self;
    _appointmentTableView.dataSource = self;
    _appointmentTableView.backgroundColor = NN_BACKGROUND_COLOR;
    _appointmentTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_appointmentTableView registerNib:[UINib nibWithNibName:@"NNQuestionerInfoCell" bundle:nil] forCellReuseIdentifier:@"NNQuestionerInfoCell"];
    [_appointmentTableView registerNib:[UINib nibWithNibName:@"NNQuestionerChooseCell" bundle:nil] forCellReuseIdentifier:@"NNQuestionerChooseCell"];
    [_appointmentTableView registerNib:[UINib nibWithNibName:@"NNQuestionCell" bundle:nil] forCellReuseIdentifier:@"NNQuestionCell"];
}

- (void)initData {
    sexArray = @[@"男",@"女" ];
    consultTypeArray = @[@"爱情烦恼",@"性格不合",@"感情变淡",@"走出失恋",@"经济矛盾",@"婆媳关系",@"家庭暴力",@"异地分居",@"小三插足",@"其他"];
}

#pragma --mark UItableViewDelagate UITableViewDatasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 6;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row < 4) {
        return 44;
    }else if(indexPath.row == 4){
        return 44 * 5;
    }else{
        return 80;
    }

}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 1 || indexPath.row == 4) {
        NNQuestionerChooseCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NNQuestionerChooseCell"];
        if (indexPath.row == 1) {
            cell.chooseTitleLabel.text = @"性别";
            cell.chooseView.chooseArray = sexArray;
            cell.chooseView.chooseBlock = ^(NNChooseButton *button){
                if (button.selected) {
                    [button.chooseImageView setImage:[UIImage imageNamed:@"303_05"]];
                }else{
                    [button.chooseImageView setImage:[UIImage imageNamed:@"303_03"]];
                }
            };
        }else{
            cell.chooseTitleLabel.text = @"问题类型";
            cell.chooseView.chooseArray = consultTypeArray;
            cell.chooseView.chooseBlock = ^(NNChooseButton *button){
                if (button.selected) {
                    [button.chooseImageView setImage:[UIImage imageNamed:@"303_05"]];
                }else{
                    [button.chooseImageView setImage:[UIImage imageNamed:@"303_03"]];
                }
            };

        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else if (  indexPath.row == 5){
        NNQuestionCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NNQuestionCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell;
    }else{
        NNQuestionerInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NNQuestionerInfoCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        switch (indexPath.row) {
            case 0:
                cell.titleLabel.text = @"姓名";
                break;
            case 2:
                cell.titleLabel.text = @"年龄";
                break;
            case 3:
                cell.titleLabel.text = @"手机";
                break;
                
            default:
                break;
        }
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
