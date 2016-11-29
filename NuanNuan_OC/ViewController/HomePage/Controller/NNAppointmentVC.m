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
#import "NNAppointmentTypeViewModel.h"
#import "NNAppointmentQuestionViewModel.h"
@interface NNAppointmentVC ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,UITextViewDelegate,UIPickerViewDelegate,UIPickerViewDataSource> {
    NSArray *sexArray;
    NSArray *consultTypeArray;
    NSString *name;
    NSString *sex;
    NSString *age;
    NSString *phone;
    NSString *questionType;
    NSString *question;
   // NSInteger lineRow;
    NNQuestionCell *questionCell;
    UIPickerView *pickView;
    NSDictionary *cityDic;
    NSArray *provinceArrays;
    NSArray *cityArrays;
    NSInteger defaultRow;
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
    
    pickView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, NNAppHeight - 200 - 64, NNAppWidth, 200)];
    pickView.backgroundColor = [UIColor whiteColor];
    pickView.delegate = self;
    pickView.dataSource = self;
    [_appointmentTableView addSubview:pickView];
}

- (void)initData {
    defaultRow = 0;
    sexArray = @[@"男",@"女" ];
    NNAppointmentTypeViewModel *viewModel = [[NNAppointmentTypeViewModel alloc] init];
    [viewModel setBlockWithReturnBlock:^(id returnValue) {
        consultTypeArray = returnValue;
        [_appointmentTableView reloadData];
    } WithErrorBlock:^(id errorCode) {
        
    } WithFailureBlock:^(id failureBlock) {
        
    }];
    
    [viewModel getAllAppointTypeWithToken:TEST_TOKEN];
    
    [self readCityInfoFromFile:@"cityData"];
}

- (void)readCityInfoFromFile:(NSString *)plistname {
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:plistname ofType:@"plist"];
    cityDic = [[NSDictionary alloc] initWithContentsOfFile:plistPath];
    
    provinceArrays = [cityDic allKeys];
    cityArrays = [cityDic allValues];
}

#pragma --mark UItableViewDelagate UITableViewDatasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 7;
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
                
                sex = [NSString stringWithFormat:@"%ld",button.tag];
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
                questionType = [NSString stringWithFormat:@"%ld",button.tag];
            };
            
         

        }
        
       
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else if (  indexPath.row == 5){
        questionCell = [tableView dequeueReusableCellWithIdentifier:@"NNQuestionCell"];
        questionCell.selectionStyle = UITableViewCellSelectionStyleNone;
        questionCell.questionTextView.delegate = self;
        return questionCell;
    }else if (indexPath.row == 6){
        
        UITableViewCell *cell = [[UITableViewCell alloc] init];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, NNAppWidth, 44)];
        label.textColor = NN_MAIN_COLOR;
        label.font = [UIFont systemFontOfSize:16];
        label.text = @"提交资询";
        label.textAlignment = NSTextAlignmentCenter;
        [cell.contentView addSubview:label];
        return cell;
    }
    else{
        NNQuestionerInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NNQuestionerInfoCell"];
        cell.titleTextField.delegate = self;
        cell.titleTextField.tag = indexPath.row;
    
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 6) {
        
        __weak NNAppointmentVC *weakSelf = self;
        
        NNAppointmentQuestionViewModel *viewModel = [[NNAppointmentQuestionViewModel alloc] init];
        [viewModel setBlockWithReturnBlock:^(id returnValue) {
            [NNProgressHUD showHudAotoHideAddToView:self.view withMessage:@"预约成功"];
            [weakSelf.navigationController popViewControllerAnimated:YES];
        } WithErrorBlock:^(id errorCode) {
            
        } WithFailureBlock:^(id failureBlock) {
            
        }];
        if (name.length > 0 && phone.length> 0 && sex.length > 0 && question.length> 0 && questionType.length > 0) {
               [viewModel consultQuestionWithToken:TEST_TOKEN andUseName:name andTelphone:phone andSex:sex andQuestion:question andQuestionType:questionType];
        }else{
            [NNProgressHUD showHudAotoHideAddToView:self.view withMessage:@"请输入完整信息"];
        }
     
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    switch (textField.tag) {
        case 0:
            name = textField.text;
            break;
        case 2:
            age = textField.text;
            break;
        case 3:
            phone = textField.text;
            break;
        default:
            break;
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}


- (void)textViewDidBeginEditing:(UITextView *)textView{
    questionCell.placelabel.hidden = YES;
    question = textView.text;
}

- (void)textViewDidEndEditing:(UITextView *)textView {
    if (textView.text.length == 0 ) {
         questionCell.placelabel.hidden = NO;
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

#pragma UIPickViewDelegate UIPickViewdatasource
- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
    return NNAppWidth / 2.0;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component {
    return 44.0;
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 2;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    if (component == 0) {
        return provinceArrays.count;
    }else {
        return [[cityArrays objectAtIndex:defaultRow] count];
    }
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    if(component == 0){
        return [provinceArrays objectAtIndex:row];
    }else{
        return [[cityArrays objectAtIndex:defaultRow] objectAtIndex:row];
    }
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    if (component == 0) {
        defaultRow = row;
        [pickerView reloadComponent:1];
    }
}


#pragma --mark keyboard
- (void)keyboardWillHide:(NSNotification *)notification {


    CGFloat animationDuration =  [[[notification userInfo] objectForKey:UIKeyboardAnimationDurationUserInfoKey] floatValue];
    
    if (_appointmentTableView.frame.origin.y < 0 ) {
        [UIView animateWithDuration:animationDuration animations:^{
            _appointmentTableView.frame = CGRectMake(0, 0, NNAppWidth, NNAppHeight);
        }];
    }

}

- (void)keyboardWillShow:(NSNotification *)notification {
    //键盘高度
    CGRect keyBoardFrame = [[[notification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    CGFloat animationDuration =  [[[notification userInfo] objectForKey:UIKeyboardAnimationDurationUserInfoKey] floatValue];
    
    if ([questionCell.questionTextView isFirstResponder]) {
        [UIView animateWithDuration:animationDuration animations:^{
            _appointmentTableView.frame = CGRectMake(0, -keyBoardFrame.size.height, NNAppWidth, NNAppHeight);
        }];
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
