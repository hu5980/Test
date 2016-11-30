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
    NSString *address;
    
    NNQuestionCell *questionCell;

    NSDictionary *cityDic;
    NSArray *provinceArrays;
    NSArray *cityArrays;
    NSInteger defaultRow;
    UITextField *addressTextField;
    
    NSString *province;
    NSString *city;
    
    UIView *pickView;
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
    
    [self setNavigationRightItem:@"提交"];
    
    _appointmentTableView.delegate = self;
    _appointmentTableView.dataSource = self;
    _appointmentTableView.backgroundColor = NN_BACKGROUND_COLOR;
    _appointmentTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_appointmentTableView registerNib:[UINib nibWithNibName:@"NNQuestionerInfoCell" bundle:nil] forCellReuseIdentifier:@"NNQuestionerInfoCell"];
    [_appointmentTableView registerNib:[UINib nibWithNibName:@"NNQuestionerChooseCell" bundle:nil] forCellReuseIdentifier:@"NNQuestionerChooseCell"];
    [_appointmentTableView registerNib:[UINib nibWithNibName:@"NNQuestionCell" bundle:nil] forCellReuseIdentifier:@"NNQuestionCell"];
    
    pickView = [[UIView alloc] initWithFrame:CGRectMake(0, NNAppHeight - 200 - 64, NNAppWidth, 200)];
    pickView.backgroundColor = NN_BACKGROUND_COLOR;
    pickView.hidden = YES;
    UIButton *cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
    cancelButton.frame = CGRectMake(0, 0, 60, 40);
    [cancelButton.titleLabel setFont:[UIFont systemFontOfSize:14.f]];
    [cancelButton setTitle:@"取消" forState:UIControlStateNormal];
    [cancelButton setTitleColor:NN_MAIN_COLOR forState:UIControlStateNormal];
    [cancelButton addTarget:self action:@selector(cancelAction:) forControlEvents:UIControlEventTouchUpInside];
    [pickView addSubview:cancelButton];
    
    UIButton *sureButton = [UIButton buttonWithType:UIButtonTypeCustom];
    sureButton.frame = CGRectMake(NNAppWidth - 60, 0, 60, 40);
    [sureButton.titleLabel setFont:[UIFont systemFontOfSize:14.f]];
    [sureButton setTitle:@"确定" forState:UIControlStateNormal];
    [sureButton setTitleColor:NN_MAIN_COLOR forState:UIControlStateNormal];
    [sureButton addTarget:self action:@selector(sureAction:) forControlEvents:UIControlEventTouchUpInside];
    [pickView addSubview:sureButton];

    
    UIPickerView *pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 40, NNAppWidth, 160)];
    pickerView.delegate = self;
    pickerView.dataSource = self;
    
    [pickView addSubview:pickerView];
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
    
    province = [provinceArrays objectAtIndex:0];
    city = [[cityArrays objectAtIndex:0] objectAtIndex:0];
}

- (void)readCityInfoFromFile:(NSString *)plistname {
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:plistname ofType:@"plist"];
    cityDic = [[NSDictionary alloc] initWithContentsOfFile:plistPath];
    provinceArrays = [cityDic allKeys];
    cityArrays = [cityDic allValues];
}

- (void)cancelAction :(UIButton *)button {
    pickView.hidden = YES;
}

- (void)sureAction:(UIButton *)button {
    address = [NSString stringWithFormat:@"%@ %@",province,city];
    addressTextField.text = address;
    pickView.hidden = YES;
}

- (void)rightItemAction:(UIBarButtonItem *)item {
    __weak NNAppointmentVC *weakSelf = self;
    
    NNAppointmentQuestionViewModel *viewModel = [[NNAppointmentQuestionViewModel alloc] init];
    [viewModel setBlockWithReturnBlock:^(id returnValue) {
        [NNProgressHUD showHudAotoHideAddToView:self.view withMessage:@"预约成功"];
        [weakSelf.navigationController popViewControllerAnimated:YES];
    } WithErrorBlock:^(id errorCode) {
        [NNProgressHUD showHudAotoHideAddToView:self.view withMessage:errorCode];
    } WithFailureBlock:^(id failureBlock) {
        
    }];
    if (name.length > 0 && phone.length> 0 && sex.length > 0 && question.length> 0 && questionType.length > 0 &&address.length > 0) {
        [viewModel consultQuestionWithToken:TEST_TOKEN andUseName:name andTelphone:phone andSex:sex andQuestion:question andQuestionType:questionType andAddress:address];
    }else{
        [NNProgressHUD showHudAotoHideAddToView:self.view withMessage:@"请输入完整信息"];
    }

}

#pragma --mark UItableViewDelagate UITableViewDatasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 7;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row < 5) {
        return 44;
    }else if(indexPath.row == 5){
        return 44 * 5;
    }else{
        return 80;
    }

}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 1 || indexPath.row == 5) {
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
    }else if (  indexPath.row == 6){
        questionCell = [tableView dequeueReusableCellWithIdentifier:@"NNQuestionCell"];
        questionCell.selectionStyle = UITableViewCellSelectionStyleNone;
        questionCell.questionTextView.delegate = self;
        return questionCell;
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
                cell.titleLabel.text = @"地址";
                break;
            case 4:
                cell.titleLabel.text = @"手机";
                break;
                
            default:
                break;
        }
        return cell;
    }
}

//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    if (indexPath.row == 7) {
//        
//        
//    }
//}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    switch (textField.tag) {
        case 0:
            name = textField.text;
            break;
        case 2:
            age = textField.text;
            break;
        case 4:
            phone = textField.text;
            break;
        default:
            break;
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    if(textField.tag != 3){
        [textField resignFirstResponder];
    }
    return YES;
}


- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    if(textField.tag == 3){
        [textField resignFirstResponder];
        addressTextField = textField;
        pickView.hidden = NO;
        return NO;
    }
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
        province = [provinceArrays objectAtIndex:row];
        defaultRow = row;
        NSInteger cityIndex = [pickerView selectedRowInComponent:1];
        city = [[cityArrays objectAtIndex:defaultRow] objectAtIndex:cityIndex];
        [pickerView reloadComponent:1];
    }else{
        city = [[cityArrays objectAtIndex:defaultRow] objectAtIndex:row];
        NSInteger provinceIndex = [pickerView selectedRowInComponent:0];
        province = [provinceArrays objectAtIndex:provinceIndex];
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
