//
//  NNNeedAppointmentVC.m
//  NuanNuan_OC
//
//  Created by 胡光耀 on 2017/6/3.
//  Copyright © 2017年 NuanNuan. All rights reserved.
//

#import "NNNeedAppointmentVC.h"
#import "NNAddInfoCell.h"
#import "NNQuestionerChooseCell.h"
#import "NNServerAppointmentCell.h"
#import "NNAppointmentTypeViewModel.h"
#import "Masonry.h"
#import "NNFloorAppointView.h"


@interface NNNeedAppointmentVC ()<UITableViewDelegate ,UITableViewDataSource,UITextFieldDelegate,UITextViewDelegate> {
    NSArray *infoArrays;
    NSArray *chooseArrays;
    NSString *name;
    NSString *age;
    NSString *weChat;
    NSString *phone;
    NSString *sex;
    NSString *merry;
    NSMutableArray *consultTypeArray;
    __block NSString *questionType;
    NNServerAppointmentCell *appointmentCell;
    NSString *question;
    NSString *pay;
    UIButton *protocolButton;
}
@property (weak, nonatomic) IBOutlet UITableView *appointmentTableView;

@end

@implementation NNNeedAppointmentVC

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
       [self.navigationController setNavigationBarHidden:NO animated:animated];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
  
    [self initUI];
    
    [self initData];
    
    // Do any additional setup after loading the view from its nib.
}

- (void)initUI {
    self.navTitle = @"我要预约";
    [self setNavigationBackButton:YES];
    self.view.backgroundColor = NN_BACKGROUND_COLOR;
    [_appointmentTableView registerNib:[UINib nibWithNibName:@"NNAddInfoCell" bundle:nil] forCellReuseIdentifier:@"NNAddInfoCell"];
    [_appointmentTableView registerNib:[UINib nibWithNibName:@"NNQuestionerChooseCell" bundle:nil] forCellReuseIdentifier:@"NNQuestionerChooseCell"];
    [_appointmentTableView registerNib:[UINib nibWithNibName:@"NNServerAppointmentCell" bundle:nil] forCellReuseIdentifier:@"NNServerAppointmentCell"];
    _appointmentTableView.delegate = self;
    _appointmentTableView.dataSource = self;
    _appointmentTableView.backgroundColor = NN_BACKGROUND_COLOR;
    
   
}

- (void)initData {
    infoArrays = @[@[@"姓名",@"年龄"],@[@"微信号",@"手机号"]];
    sex = @"男";
    merry = @"已婚";
    chooseArrays =  @[@[@"男",@"女"],@[@"已婚",@"未婚"]];
    pay = @"36";
    consultTypeArray = [NSMutableArray array];
    
    NNAppointmentTypeViewModel *viewModel = [[NNAppointmentTypeViewModel alloc] init];
    [viewModel setBlockWithReturnBlock:^(id returnValue) {
        consultTypeArray = returnValue;
        if (consultTypeArray.count > 0) {
            NNAppointmentModel *model = [consultTypeArray objectAtIndex:0];
            questionType = [NSString stringWithFormat:@"%@",model.appointmentID];
        }
        [_appointmentTableView reloadSections:[[NSIndexSet alloc] initWithIndex:1] withRowAnimation:UITableViewRowAnimationFade];
    } WithErrorBlock:^(id errorCode) {
        NSLog(@"%@",errorCode);
    } WithFailureBlock:^(id failureBlock) {
        NSLog(@"%@",failureBlock);
    }];
    
    [viewModel getAllAppointTypeWithToken:TEST_TOKEN];
}


- (void)createOrder:(UIButton *)button {

}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 4;
    }else  {
        return 1;
    }

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        if(indexPath.row == 0 || indexPath.row == 3){
            NNAddInfoCell *addInfoCell = [tableView dequeueReusableCellWithIdentifier:@"NNAddInfoCell"];
            if (indexPath.row == 0) {
                addInfoCell.firstlabel.text = [[infoArrays objectAtIndex:0] objectAtIndex:0];
                addInfoCell.secondLabel.text = [[infoArrays objectAtIndex:0] objectAtIndex:1];
                addInfoCell.firstTextField.tag = 0;
                addInfoCell.secondTextField.tag = 1;
            }else{
                addInfoCell.firstlabel.text = [[infoArrays objectAtIndex:1] objectAtIndex:0];
                addInfoCell.secondLabel.text = [[infoArrays objectAtIndex:1] objectAtIndex:1];
                addInfoCell.firstTextField.tag = 2;
                addInfoCell.secondTextField.tag = 3;
            }
            addInfoCell.firstTextField.delegate = self;
            addInfoCell.secondTextField.delegate = self;
            return addInfoCell;
        }else  {
            NNQuestionerChooseCell *questionChooseCell = [tableView dequeueReusableCellWithIdentifier:@"NNQuestionerChooseCell"];
            if (indexPath.row == 1) {
                questionChooseCell.chooseTitleLabel.text = @"性 别:";
                questionChooseCell.chooseView.chooseArray = [chooseArrays objectAtIndex:0];
                questionChooseCell.chooseView.chooseBlock = ^(NSString *selectString){
                    sex = selectString;
                };
            }else{
                questionChooseCell.chooseTitleLabel.text = @"婚 姻:";
                questionChooseCell.chooseView.chooseArray = [chooseArrays objectAtIndex:1];
                questionChooseCell.chooseView.chooseBlock = ^(NSString *selectString){
                    merry = selectString;
                };
            }
            return questionChooseCell;
        }
    }else if(indexPath.section == 1) {
        appointmentCell = [tableView dequeueReusableCellWithIdentifier:@"NNServerAppointmentCell"];
        appointmentCell.chooseView.ismultiSelect = YES;
        appointmentCell.chooseView.chooseArray = consultTypeArray;
        appointmentCell.chooseViewConstraint.constant = 40 * consultTypeArray.count /2 ;
        appointmentCell.chooseView.chooseBlock = ^(NSString *selectType){
            questionType = selectType;
        };
        appointmentCell.payBlock = ^(NSString *payNums) {
            pay = payNums;
        };
        appointmentCell.descributeTextView.delegate = self;
        
        appointmentCell.selectionStyle = UITableViewCellSelectionStyleNone;
        return appointmentCell;
    }else{
        UITableViewCell *cell = [[UITableViewCell alloc] init];
        NNFloorAppointView *floorView  = LOAD_VIEW_FROM_BUNDLE(@"NNFloorAppointView");
        [floorView.createOrderButton addTarget:self action:@selector(createOrder:) forControlEvents:UIControlEventTouchUpInside];
        [cell.contentView addSubview:floorView];
        protocolButton = floorView.chooseProtocolButton;
        [floorView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(@0);
            make.right.mas_equalTo(@0);
            make.top.mas_equalTo(@0);
            make.bottom.mas_equalTo(@0);
        }];
        return cell;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor clearColor];
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0 ) {
        return 44;
    }else if(indexPath.section == 1){
        return 195 + consultTypeArray.count/2 * 40;
    }else{
        return 80;
    }

}


- (void)textFieldDidEndEditing:(UITextField *)textField {
    switch (textField.tag) {
        case 0:
            name = textField.text;
            break;
        case 1:
            age = textField.text;
            break;
        case 2:
            weChat = textField.text;
            break;
        case 3:
            phone = textField.text;
            break;
        default:
            break;
    }
}

- (void)textViewDidBeginEditing:(UITextView *)textView{
    appointmentCell.placeLabel.hidden = YES;
    question = textView.text;
}

- (void)textViewDidEndEditing:(UITextView *)textView {
    if (textView.text.length == 0 ) {
        appointmentCell.placeLabel.hidden = NO;
    }
    question = textView.text;
    
}


-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString*)text
{
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    return YES;
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
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
