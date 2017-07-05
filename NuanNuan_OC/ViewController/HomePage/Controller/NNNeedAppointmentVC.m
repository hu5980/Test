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
#import "NNAppointmentOrderTypeViewModel.h"
#import "NNGoodsCell.h"
#import "NNAppointmentOrderViewModel.h"
#import "NNPayVC.h"
#import "NNUserAgreementVC.h"

@interface NNNeedAppointmentVC ()<UITableViewDelegate ,UITableViewDataSource,UITextFieldDelegate,UITextViewDelegate> {
    NSArray *infoArrays;
    NSArray *placeArrays;
    NSArray *chooseArrays;
    NSString *name;
    NSString *age;
    NSString *weChat;
//    NSString *phone;
    NSString *sex;
    NSString *merry;
    NSMutableArray *consultTypeArray;
//    __block NSString *questionType;
    NNServerAppointmentCell *appointmentCell;
//    NSString *question;
    NSString *pay;
    UIButton *protocolButton;
    __block NSString *money;
    NSArray *orderArrays;
    NSString *serverName;
    NSString *chooseGoodsId;
    UIButton *defaultChooseGoodButton;
    NNFloorAppointView *floorView ;
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
    
    floorView  = LOAD_VIEW_FROM_BUNDLE(@"NNFloorAppointView");
    
    [floorView.createOrderButton addTarget:self action:@selector(createOrder:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:floorView];
    [floorView.entryProtocol addTarget:self action:@selector(entryProtocolAction) forControlEvents:UIControlEventTouchUpInside];
    protocolButton = floorView.chooseProtocolButton;
    [floorView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(@0);
        make.right.mas_equalTo(@0);
        make.bottom.mas_equalTo(@0);
        make.height.mas_equalTo(@80);
    }];
}

- (void)initData {
    infoArrays = @[@[@"姓名",@"年龄"],@[@"微信号/手机号"]];
    placeArrays = @[@[@"输入姓名",@"输入年龄"],@[@"输入微信或手机号"]];
    sex = @"男";
    merry = @"已婚";
    chooseArrays =  @[@[@"男",@"女"],@[@"已婚",@"未婚"]];
    pay = @"36";
    consultTypeArray = [NSMutableArray array];
    
//    NNAppointmentTypeViewModel *viewModel = [[NNAppointmentTypeViewModel alloc] init];
//    [viewModel setBlockWithReturnBlock:^(id returnValue) {
//        consultTypeArray = returnValue;
//        if (consultTypeArray.count > 0) {
//            NNAppointmentModel *model = [consultTypeArray objectAtIndex:0];
//            questionType = [NSString stringWithFormat:@"%@",model.appointmentID];
//        }
//        [_appointmentTableView reloadSections:[[NSIndexSet alloc] initWithIndex:1] withRowAnimation:UITableViewRowAnimationFade];
//    } WithErrorBlock:^(id errorCode) {
//        NSLog(@"%@",errorCode);
//    } WithFailureBlock:^(id failureBlock) {
//        NSLog(@"%@",failureBlock);
//    }];
//    
//    
//    
//    [viewModel getAllAppointTypeWithToken:TEST_TOKEN];
    
    
    
    NNAppointmentOrderTypeViewModel *orderViewModel = [[NNAppointmentOrderTypeViewModel alloc] init];
    [orderViewModel setBlockWithReturnBlock:^(id returnValue) {
        orderArrays = returnValue;
        [appointmentCell.orderTableView reloadData];
        [_appointmentTableView reloadSections:[[NSIndexSet alloc] initWithIndex:1] withRowAnimation:UITableViewRowAnimationFade];
    } WithErrorBlock:^(id errorCode) {
        NSLog(@"%@",errorCode);
    } WithFailureBlock:^(id failureBlock) {
        NSLog(@"%@",failureBlock);
    }];
    [orderViewModel getAppointmentOrderType];
}


- (void)entryProtocolAction {
    NNUserAgreementVC *agreementVC = [[NNUserAgreementVC alloc] initWithNibName:@"NNUserAgreementVC" bundle:nil];
    [self.navigationController pushViewController:agreementVC animated:YES];

}


- (void)createOrder:(UIButton *)button {
    
    if (!floorView.chooseProtocolButton.selected) {
        
        [NNProgressHUD showHudAotoHideAddToView:self.view withMessage:@"请先同意《暖暖情感心理》服务协议"];
        
        return;
    }
    
    
    if (name.length > 0  && sex.length > 0 && age.length > 0 &&merry.length > 0 && weChat.length > 0 && chooseGoodsId.length > 0) {
        NNAppointmentOrderViewModel  *createOrderModel = [[NNAppointmentOrderViewModel alloc] init];
        [createOrderModel setBlockWithReturnBlock:^(id returnValue) {
            NSString *orderNo =  [[returnValue objectForKey:@"data"] objectForKey:@"o_code"];
            NSString *orderId =  [[returnValue objectForKey:@"data"] objectForKey:@"o_id"];
            NNPayVC  *payVC = [[NNPayVC alloc] initWithNibName:@"NNPayVC" bundle:nil];
            payVC.orderNO = orderNo;
            payVC.orderId = orderId;
            payVC.money = money;
            payVC.serverType = @"情感问题";
            payVC.name = name;
            payVC.wechat = weChat;

            payVC.serverName = serverName;
            [self.navigationController pushViewController:payVC animated:YES];
        } WithErrorBlock:^(id errorCode) {
            
        } WithFailureBlock:^(id failureBlock) {
            
        }];
        [createOrderModel submitOrderWithToken:TEST_TOKEN userName:name  sex:sex  married:merry wechat:weChat age:age serviceId:chooseGoodsId ];
        
    }else{
        [NNProgressHUD showHudAotoHideAddToView:self.view withMessage:@"请输入完整信息"];
    }
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (tableView.tag == 100) {
        return 1;
    }else{
        return 2;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView.tag == 100) {
        return orderArrays.count;
    }else{
        if (section == 0) {
            return 4;
        }else  {
            return 1;
        }
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView.tag == 100) {
        NNGoodsCell *goodesCell = [tableView dequeueReusableCellWithIdentifier:@"NNGoodsCell" ];
        goodesCell.selectionStyle = UITableViewCellSelectionStyleNone;
        NNOrderServerModel *model = [orderArrays objectAtIndex:indexPath.row];
        goodesCell.model = model;
        
        if (indexPath.row == 0) {
            defaultChooseGoodButton = goodesCell.chooseButton;
            defaultChooseGoodButton.selected = YES;
            money = goodesCell.model.g_discount_price;
            chooseGoodsId = model.orderServerId;
            serverName = model.orderTitle;
        }
        goodesCell.chooseBlock = ^(NSString *goodsID,UIButton *button ,NSString *price,NSString *goodsName) {
            defaultChooseGoodButton.selected = NO;
            defaultChooseGoodButton = button;
            defaultChooseGoodButton.selected = YES;
            chooseGoodsId = goodsID;
            money = price;
            serverName = goodsName;
        };
        return goodesCell;
    }else{
        if (indexPath.section == 0) {
            if(indexPath.row == 0 || indexPath.row == 3){
                NNAddInfoCell *addInfoCell = [tableView dequeueReusableCellWithIdentifier:@"NNAddInfoCell"];
                addInfoCell.selectionStyle = UITableViewCellSelectionStyleNone;
                if (indexPath.row == 0) {
                    addInfoCell.firstlabel.text = [[infoArrays objectAtIndex:0] objectAtIndex:0];
                    
                    addInfoCell.secondLabel.text = [[infoArrays objectAtIndex:0] objectAtIndex:1];
                    addInfoCell.firstTextField.tag = 0;
                    addInfoCell.secondTextField.tag = 1;
                    addInfoCell.firstTextField.placeholder = [[placeArrays objectAtIndex:0] objectAtIndex:0];;
                    addInfoCell.secondTextField.placeholder = [[placeArrays objectAtIndex:0] objectAtIndex:1];
                }else{
                    addInfoCell.firstlabel.text = [[infoArrays objectAtIndex:1] objectAtIndex:0];
                    addInfoCell.secondLabel.hidden = YES;
                    addInfoCell.firstTextField.tag = 2;
                    addInfoCell.imageView.hidden = YES;
                    addInfoCell.centerxContraint.constant = 100;
                    addInfoCell.firstTextField.placeholder = [[placeArrays objectAtIndex:1] objectAtIndex:0];
                    addInfoCell.secondTextField.hidden = YES;
                }
                addInfoCell.firstTextField.delegate = self;
                addInfoCell.secondTextField.delegate = self;
                return addInfoCell;
            }else  {
                NNQuestionerChooseCell *questionChooseCell = [tableView dequeueReusableCellWithIdentifier:@"NNQuestionerChooseCell"];
                questionChooseCell.selectionStyle = UITableViewCellSelectionStyleNone;
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
        }else {
            appointmentCell.selectionStyle = UITableViewCellSelectionStyleNone;
            appointmentCell = [tableView dequeueReusableCellWithIdentifier:@"NNServerAppointmentCell"];
                    appointmentCell.payBlock = ^(NSString *payNums) {
                pay = payNums;
            };
      
            
            appointmentCell.selectionStyle = UITableViewCellSelectionStyleNone;
            appointmentCell.orderTableView.delegate = self;
            appointmentCell.orderTableView.dataSource = self;
            appointmentCell.orderTableView.tag = 100;
            
            return appointmentCell;
        }
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
    
    if (tableView.tag == 100) {
        return 40;
    }else{
        
        if (indexPath.section == 0 ) {
            return 44;
        }else{
            return 52 +  orderArrays.count * 40;
        }
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
     
        default:
            break;
    }
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
